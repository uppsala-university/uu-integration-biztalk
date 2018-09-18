
using Microsoft.BizTalk.Adapter.Common;
using Microsoft.BizTalk.Component.Interop;
using Microsoft.BizTalk.Message.Interop;
using Microsoft.BizTalk.TransportProxy.Interop;
using Shared.Components;
using System;
using System.IO;
using System.Net;
using System.Text;
using System.Threading;
using System.Transactions;
using System.Xml;
using System.Xml.Serialization;

namespace BizTalk.Adapter.Atom
{
    //  An instance of this class should exist for every enabled receive location.
    //
    //  This is where all the receive location specific work goes. For example, any listening or polling generally goes in here.
    //
    //  If you want to have multiple independent threads listening or working per receive location that might effectively
    //  be done as member objects from this endpoint class. In this particular example there is only a single timer doing some
    //  polling and it is contained in here.
    //
    //  After the Receiver creates a member of this class it calls Open and when the receive location is deleted Dispose is called.
    //  Otherwise all Updates are plumbed through to the Update function on this class.

    internal class AtomReceiverEndpoint : ReceiverEndpoint
    {
        //  timer and buffer
        Timer timer;
        //private ManualResetEvent batchFinished = new ManualResetEvent(false);
        //  properties
        private AtomReceiveProperties properties;

        private bool busy = false;
        //  handle to the EPM
        private IBTTransportProxy transportProxy;
        private IBaseMessageFactory messageFactory;
        private ControlledTermination control;

        private string uri;
        private string transportType;
        private string propertyNamespace;
        private AtomState atomState = null;
        private XmlSerializer stateSerializer = null;


        public AtomReceiverEndpoint()
        {
        }

        public override void Open(string uri, Microsoft.BizTalk.Component.Interop.IPropertyBag config, IPropertyBag bizTalkConfig, Microsoft.BizTalk.Component.Interop.IPropertyBag handlerPropertyBag, IBTTransportProxy transportProxy, string transportType, string propertyNamespace, ControlledTermination control)
        {
            try
            {
                this.properties = new AtomReceiveProperties(uri);

                XmlDocument locationConfigDom = ConfigProperties.ExtractConfigDom(config);
                this.properties.LocationConfiguration(locationConfigDom, false);

                //  this is our handle back to the EPM
                this.transportProxy = transportProxy;

                //  used to control whether the EPM can unload us
                this.control = control;

                this.uri = uri;
                this.transportType = transportType;
                this.propertyNamespace = propertyNamespace;
                this.messageFactory = this.transportProxy.GetMessageFactory();
                stateSerializer = new XmlSerializer(typeof(AtomState));

                Start();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
            }
        }

        //  update and delete
        public override void Update(IPropertyBag config, IPropertyBag bizTalkConfig, IPropertyBag handlerPropertyBag)
        {
            try
            {
                Stop();

                this.properties = new AtomReceiveProperties(this.properties.Uri);

                XmlDocument locationConfigDom = ConfigProperties.ExtractConfigDom(config);
                this.properties.LocationConfiguration(locationConfigDom, true);

                Start();
            }
            finally
            {
            }
        }

        public override void Dispose()
        {
            try
            {
                Stop();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
            }
        }

        private void Log(Entry entry, string uri)
        {
            if (this.properties.UseLogging)
            {
                try
                {
                    string content = entry.Content;
                    if (!string.IsNullOrWhiteSpace(this.properties.LogContentXpath))
                    {
                        XmlDocument xml = new XmlDocument();
                        xml.LoadXml(content);
                        XmlNode node = xml.SelectSingleNode(this.properties.LogContentXpath.Trim());
                        if (node != null)
                            content = node.InnerText;
                    }

                    string format = "[AtomAdapter] {0}{1}{2}{3}{4}{5}{6}{7}";
                    string message = string.Format(format,
                        this.properties.LogEventId ? "[Entry] " : "",
                        this.properties.LogEventId ? entry.Id : "",
                        this.properties.LogEventId ? " " : "",
                        "[Event] ",
                        content,
                        this.properties.LogUri ? " " : "",
                        this.properties.LogUri ? "[Feed] " : "",
                        this.properties.LogUri ? uri : ""
                        );
                    System.Diagnostics.EventLog.WriteEntry(this.properties.LogSource, message);
                }
                catch (Exception e)
                {
                    throw new InvalidConfiguration(string.Format("Unable to log using current logging configuration. Exception message: {0}", e.Message));
                }
            }
        }

        private IBaseMessage CreateMessage(Shared.Components.Entry message)
        {

            MemoryStream mem = new MemoryStream(UTF8Encoding.UTF8.GetBytes(message.Content));

            IBaseMessageFactory factory = this.transportProxy.GetMessageFactory();
            IBaseMessagePart part = factory.CreateMessagePart();

            part.Data = mem;

            IBaseMessage msg = factory.CreateMessage();
            msg.AddPart("body", part, true);

            //  We must add these context properties
            SystemMessageContext context = new SystemMessageContext(msg.Context);
            context.InboundTransportLocation = this.uri;
            context.InboundTransportType = this.transportType;
            //Set ActionOnFailure to zero in the context property of each messaqe that you do not want BizTalk Server to suspend on a processing exception. 
            //Failure to set this property allows BizTalk Server to fall back to its default behavior 
            //of suspending the message on a processing exception. 
            //context.ActionOnFailure = 0;

            //we could promote entity id and updated, msg.Context.Promote(ns, message.Id
            return msg;
        }

        public void ProcessBatch()
        {
            bool needToLeave = false;

            busy = true;

            try
            {
                //  used to block the Terminate from BizTalk 
                if (!this.control.Enter())
                {
                    needToLeave = false;
                    return;
                }
                needToLeave = true;

                StateSettings stateSettings = new StateSettings();
                stateSettings.FindFirst = this.properties.FirdFirst;
                stateSettings.WorkingFeed = string.IsNullOrWhiteSpace(atomState.LastFeed) ? this.properties.FirstFeed : atomState.LastFeed;
                stateSettings.Id = string.IsNullOrWhiteSpace(atomState.LastEntryId) ? this.properties.FirstEntry : atomState.LastEntryId;

                AtomReader atom = new AtomReader(this.properties.Uri, stateSettings, this.properties.SecuritySettings, this.properties.FeedMax);

                Feed feed = null;
                bool discard = atom.IdFound;
                string stateId = stateSettings.Id;
                string lastId = String.Empty;

                bool getAllEntries = properties.NumberOfEvents == 0;
                int entryCounter = 0;
                bool getEntry = getAllEntries || entryCounter < properties.NumberOfEvents;

                while (getEntry && (feed = atom.NextFeed()) != null && feed.Entries.Count > 0)
                {
                    ManualResetEvent orderedEvent = null;
                    CommittableTransaction transaction = null;

                    Entry entry = feed.Entries.PopOrNUll();

                    while (getEntry && entry != null)
                    {
                        if (discard == false)
                        {
                            Log(entry, feed.Uri);
                            orderedEvent = new ManualResetEvent(false);
                            transaction = new CommittableTransaction();
                            atomState.LastEntryId = entry.Id;
                            atomState.LastUpdated = feed.Updated;
                            atomState.LastFeed = feed.Uri;

                            SaveState(transaction);

                            using (SingleMessageReceiveTxnBatch batch = new SingleMessageReceiveTxnBatch(this.transportProxy, this.control, transaction, orderedEvent))
                            {
                                batch.SubmitMessage(CreateMessage(entry));
                                batch.Done();
                                orderedEvent.WaitOne();
                            }
                            entryCounter++;
                            getEntry = getAllEntries || entryCounter < properties.NumberOfEvents;
                        }

                        if (stateId == entry.Id)
                            discard = false;

                        if (getEntry)
                            entry = feed.Entries.PopOrNUll();
                    }
                }

                needToLeave = false;
            }
            catch (MaxDeepthException deepth)
            {
                this.transportProxy.ReceiverShuttingdown(this.properties.Uri, deepth);
            }
            catch (InvalidConfiguration arg)
            {
                this.transportProxy.ReceiverShuttingdown(this.properties.Uri, arg);

            }
            catch (WebException ex)
            {
                this.transportProxy.ReceiverShuttingdown(this.properties.Uri, ex);

            }
            catch (Exception e)
            {
                this.transportProxy.SetErrorInfo(e);

            }
            finally
            {
                busy = false;
                //  if this is true there must have been some exception in or before Done
                if (needToLeave)
                    this.control.Leave();
            }
        }

        private void Start()
        {
            if (File.Exists(this.properties.StateFile))
            {
                using (FileStream stateFile = new FileStream(this.properties.StateFile, FileMode.Open, FileAccess.Read))
                {
                    atomState = (AtomState)stateSerializer.Deserialize(stateFile);
                }

            }

            if (atomState == null)
                atomState = new AtomState();

            this.timer = new Timer(new TimerCallback(TimerTask));
            this.timer.Change(0, this.properties.PollingInterval);
        }

        private void SaveState(System.Transactions.Transaction transaction)
        {

            if (TransactionalFile.WriteStateFileTransacted(this.properties.StateFile, stateSerializer, atomState, transaction) == false)
                throw new Exception(String.Format("State file {0} could not be written!", this.properties.StateFile));

        }
        private void SaveState()
        {
            try
            {
                using (FileStream stateFile = new FileStream(this.properties.StateFile, FileMode.Create, FileAccess.ReadWrite))
                {
                    stateSerializer.Serialize(stateFile, atomState);
                }
            }
            catch (Exception ex)
            {

                throw new Exception(String.Format("State file {0} could not be written!", this.properties.StateFile), ex);
            }

        }
        private void Stop()
        {
            try
            {
                SaveState();
            }
            catch (Exception ex)
            {

                throw new FileLoadException(String.Format("File {0} could not be written!", this.properties.StateFile), ex);

            }
            finally
            {
                this.timer.Dispose();
            }



        }

        private void TimerTask(object state)
        {
            if (busy == false)
                ProcessBatch();//if busy wait for next timer

        }


    }
}
