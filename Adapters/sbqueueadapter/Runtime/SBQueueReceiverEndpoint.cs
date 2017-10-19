
using System;
using System.IO;
using System.Xml;
using System.Threading;
using System.Text;
using System.Transactions;
using System.Data.SqlClient;
using Microsoft.BizTalk.Component.Interop;
using Microsoft.BizTalk.Message.Interop;
using Microsoft.BizTalk.TransportProxy.Interop;
using Microsoft.Samples.BizTalk.Adapter.Common;
using System.Collections.Concurrent;
using Microsoft.ServiceBus;
using Microsoft.ServiceBus.Messaging;

namespace BizTalk.Adapter.SBQueue
{
    //  An instance of this class should exist for every enabled receive location.
    //
    //  This is where all the receive location specific work goes. For example, any listening or polling generally goes in here.
    //
    //  If you want to have multiple independent threads listening or working per receive location that might effectively
    //  be done as member objects from this endpoint class. In this particular example there is only a simgle timer doing some
    //  polling and it is contained in here.
    //
    //  After the Receiver creates a member of this class it calls Open and when the receive location is deleted Dispose is called.
    //  Otherwise all Updates are plumbed through to the Update function on this class.

    internal class SBQueueReceiverEndpoint : ReceiverEndpoint
    {
        //  timer and buffer
        Timer timer;
        private ManualResetEvent batchFinished = new ManualResetEvent(false);
        //  properties
        private SBQueueReceiveProperties properties;

        private bool busy = false; 
        //  handle to the EPM
        private IBTTransportProxy transportProxy;
        private IBaseMessageFactory messageFactory;
        private ControlledTermination control;

        private string uri;
        private string transportType;
        private string propertyNamespace;
       
        public SBQueueReceiverEndpoint()
        {
        }

        public override void Open(string uri, Microsoft.BizTalk.Component.Interop.IPropertyBag config, IPropertyBag bizTalkConfig, Microsoft.BizTalk.Component.Interop.IPropertyBag handlerPropertyBag, IBTTransportProxy transportProxy, string transportType, string propertyNamespace, ControlledTermination control)
        {
            try
            {
                this.properties = new SBQueueReceiveProperties(uri);
              
                  XmlDocument locationConfigDom = ConfigProperties.ExtractConfigDom(config);
                this.properties.LocationConfiguration(locationConfigDom,false);

                //  this is our handle back to the EPM
                this.transportProxy = transportProxy;

                //  used to control whether the EPM can unload us
                this.control = control;

                this.uri = uri;
                this.transportType = transportType;
                this.propertyNamespace = propertyNamespace;
                this.messageFactory = this.transportProxy.GetMessageFactory();

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
        public override void Update (IPropertyBag config, IPropertyBag bizTalkConfig, IPropertyBag handlerPropertyBag)
        {
            try
            {
                Stop();

                this.properties = new SBQueueReceiveProperties(this.properties.Uri);

                XmlDocument locationConfigDom = ConfigProperties.ExtractConfigDom(config);
                this.properties.LocationConfiguration(locationConfigDom,true);

                Start();
            }
            finally
            {
            }
        }

        public override void Dispose ()
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

    private IBaseMessage CreateMessage(BrokeredMessage message)
    {

          
        Stream stm = message.GetBody<Stream>();

            
        IBaseMessageFactory factory = this.transportProxy.GetMessageFactory();
        IBaseMessagePart part = factory.CreateMessagePart();

        part.Data = stm;
            


        IBaseMessage msg = factory.CreateMessage();
        msg.AddPart("body", part, true);

        //  We must add these context properties
        SystemMessageContext context = new SystemMessageContext(msg.Context);
        context.InboundTransportLocation = this.uri;
        context.InboundTransportType = this.transportType;

        msg.Context.Promote("SequenceNumber", this.propertyNamespace, message.SequenceNumber.ToString());

        return msg;
    }

    public void SubmitBatch()
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
            //properties



            var connectionString = String.Format("Endpoint={0};SharedAccessKeyName={1};SharedAccessKey={2}", properties.Endpoint, properties.SharedAccessKeyName, properties.SharedAccessKey);
            var clientKey = String.Format("{0}/{1}", properties.Endpoint, properties.Queue);

            Session ses = null;

               
            if (SBQueueReceiver.clients.TryGetValue(clientKey, out ses) == false)
            {
                ServiceBusConnectionStringBuilder conn = new ServiceBusConnectionStringBuilder(connectionString);
                QueueClient client = QueueClient.CreateFromConnectionString(connectionString, properties.Queue, ReceiveMode.PeekLock);
                
                ses = new Session { Busy = true, Client = client };
                SBQueueReceiver.clients.TryAdd(clientKey, ses);

                client.PrefetchCount = properties.Prefetch;
            }

            lock (ses)
            {


                if (properties.UseSession == true)
                {
                    if (properties.Session == String.Empty)
                    {
                        GetAllMessagesWithSession(ses.Client);
                    }
                    else
                    {
                        GetSessionMessages(ses.Client);
                    }

                }
                else
                {
                    GetMessages(ses.Client);
                }

                ses.Busy = false;
            }

            //  no exception in Done so we will be getting a BatchComplete which will do the necessary Leave
            needToLeave = false;


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


    /// <summary>
    /// Get all messages from a session less queue
    /// </summary>
    /// <param name="client">QueueClient</param>
    private void GetMessages(QueueClient client)
    {

        try
        {
            BrokeredMessage item = client.Receive(properties.ReceiveTimeout);

            while (true)
            {
                if (item == null)
                    break;

                if (SubmitMessage(item) == false)
                {
                    client.Abort();
                    break;
                }

                //allow setting timeout
                item = client.Receive(properties.ReceiveTimeout);
            }
        }
        catch (Exception)
        {

            //probably lock
        }

    }
    /// <summary>
    /// Get all messages that has a session
    /// </summary>
    /// <param name="client">QueueClient</param>
    private void GetSessionMessages(QueueClient client)
    {

            try
            {
                MessageSession ses = client.AcceptMessageSession(properties.Session);

                BrokeredMessage item = ses.Receive(properties.ReceiveTimeout);

                while (true)
                {
                    if (item == null)
                        break;

                    if (SubmitMessage(item) == false)
                    {
                        ses.Abort();
                        break;
                    }

                    //allow setting timeout
                    item = ses.Receive(properties.ReceiveTimeout);
                }
            }
            catch (Exception)
            {

                //probably lock
            }
       
            
    }


       
    private bool SubmitMessage(BrokeredMessage message)
    {

        try
        {

            SyncReceiveSubmitBatch batch = new SyncReceiveSubmitBatch(this.transportProxy, this.control, 1);

            batch.SubmitMessage(CreateMessage(message));
                
            batch.Done();

            if (batch.Wait() == true)
                message.Complete();

            return batch.OverallSuccess;

        }
        catch (Exception e)
        {
            this.transportProxy.SetErrorInfo(e);
        }

        return false;
          


    }
    /// <summary>
    /// Get all messages with a specific session
    /// </summary>
    /// <param name="client">QueueClient</param>
    private void GetAllMessagesWithSession(QueueClient client)
    {

        foreach (MessageSession sessions in client.GetMessageSessions())
        {
                try
                {
                    MessageSession ses = client.AcceptMessageSession(sessions.SessionId);

                    BrokeredMessage item = ses.Receive(properties.ReceiveTimeout);

                    while (true)
                    {
                        if (item == null)
                            break;

                        if (SubmitMessage(item) == false)
                        {
                            ses.Abort();
                            break;
                        }
                        //allow setting timeout
                        item = ses.Receive(properties.ReceiveTimeout);

                    }
                }
                catch (Exception)
                {

                    break;
                }
           
        }
 

    }

        private void Start()
        {
            this.timer = new Timer(new TimerCallback(TimerTask));
            this.timer.Change(0, this.properties.PollingInterval);
        }

        private void Stop()
        {
            this.timer.Dispose();
        }

        private void TimerTask(object state)
        {
            if(busy == false)
                SubmitBatch();//if busy wait for next timer

        }
        
       
    }
}
