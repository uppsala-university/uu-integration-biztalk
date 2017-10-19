
using System;
using System.IO;
using System.Xml;
using System.Net;
using System.Collections;
using Microsoft.BizTalk.Message.Interop;
using Microsoft.Samples.BizTalk.Adapter.Common;
using Microsoft.ServiceBus;
using Microsoft.ServiceBus.Messaging;

namespace BizTalk.Adapter.SBQueue
{

    public enum SizeUnit { Bytes, KBytes, MBytes }

    // //////////////////////////////////////////////////////////////////////////////////////////////

    internal class SBQueueReceiveProperties : ConfigProperties
    {
        private string uri;
        private int pollingInterval;
        private string sharedAccessKey;
        private string sharedAccessKeyName;
        private int prefetch;
        private string session;
        private bool useSession;
        private string pollingIntervalUnit;
        private string endpoint;
        private string queue;
        private string receiveTimeout;

        public string Uri { get { return uri; } }
        public int PollingInterval { get { return pollingInterval; } }

        public string PollingIntervalUnit { get { return pollingIntervalUnit; } }

        public TimeSpan ReceiveTimeout { get { return Time(receiveTimeout); } }

        public string SharedAccessKey { get { return sharedAccessKey; } }
        public string SharedAccessKeyName { get { return sharedAccessKeyName; } }    
        public int Prefetch { get { return prefetch; } }
        public string Session { get { return session; } }
        public bool UseSession { get { return useSession; } }

        public string Queue { get { return queue; } }
        public string Endpoint { get { return endpoint; } }

        public static TimeSpan Time(string time)
        {
            TimeSpan span;
            if (TimeSpan.TryParse(time, out span) == false)
                span = new TimeSpan(0, 0, 1);

            return span;
        }

        public SBQueueReceiveProperties (string uri)
        {
            try
            {
                this.uri = uri;
                this.pollingInterval = 3000;
                this.pollingIntervalUnit = "seconds";
                this.sharedAccessKey = String.Empty;
                this.sharedAccessKeyName = String.Empty;
                this.prefetch = 0;
                this.session = String.Empty;
                this.endpoint = String.Empty;
                this.queue = String.Empty;
                this.useSession = false;
                this.receiveTimeout = "00:00:01";
            }
            finally
            {
            }
        }

        public virtual void HandlerConfiguration (XmlDocument configDOM)
        {
        }

        public virtual void LocationConfiguration (XmlDocument configDOM,bool update)
        {
            try
            {
                int pollingIntervalMultiplier = 1;

                XmlNode nodePollingIntervalUnit = configDOM.SelectSingleNode("Config/pollingIntervalUnit");
                switch (nodePollingIntervalUnit.InnerText.ToLower())
                {
                    case "milliseconds":
                        pollingIntervalMultiplier = 1;
                        break;
                    case "seconds":
                        pollingIntervalMultiplier = 1000;
                        break;
                    case "minutes":
                        pollingIntervalMultiplier = 1000 * 60;
                        break;
                }

                XmlNode nodePollingInterval = configDOM.SelectSingleNode("Config/pollingInterval");

               
                int pollingIntervalValue = int.Parse(nodePollingInterval.InnerText);

                this.pollingInterval = pollingIntervalMultiplier * pollingIntervalValue;

                XmlNode nodeSharedAccessKey = configDOM.SelectSingleNode("Config/SharedAccessKey");
                this.sharedAccessKey = nodeSharedAccessKey.InnerText;

                XmlNode nodeSharedAccessKeyName = configDOM.SelectSingleNode("Config/SharedAccessKeyName");
                this.sharedAccessKeyName = nodeSharedAccessKeyName.InnerText;

                XmlNode nodePrefetch = configDOM.SelectSingleNode("Config/prefetch");

                if(nodePrefetch != null)
                    this.prefetch = Int32.Parse(nodePrefetch.InnerText);

                XmlNode nodeSession = configDOM.SelectSingleNode("Config/session");

                if (nodeSession != null)
                    this.session = nodeSession.InnerText;

                XmlNode nodeUseSession = configDOM.SelectSingleNode("Config/usesession");
                this.useSession = Boolean.Parse(nodeUseSession.InnerText);

                XmlNode nodeQueue = configDOM.SelectSingleNode("Config/queue");
                this.queue = nodeQueue.InnerText;

                XmlNode nodeEndpoint = configDOM.SelectSingleNode("Config/endpoint");
                this.endpoint = nodeEndpoint.InnerText;

                var slash = nodeEndpoint.InnerText.EndsWith("/") ? String.Empty : "/";

                this.uri = String.Format("{0}{1}{2}", nodeEndpoint.InnerText, slash, nodeQueue.InnerText);

                if(update == true)
                {
                    Session client = null;
                    SBQueueReceiver.clients.TryRemove(this.uri, out client);
                }

                XmlNode nodeReceiveTimeout = configDOM.SelectSingleNode("Config/receiveTimeout");
                this.receiveTimeout = nodeReceiveTimeout.InnerText;
                



            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
            }
        }
    }
}
