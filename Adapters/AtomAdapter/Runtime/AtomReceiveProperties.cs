
using Microsoft.BizTalk.Adapter.Common;
using Shared.Components;
using System;
using System.Collections.Generic;
using System.Net;
using System.Xml;

namespace BizTalk.Adapter.Atom
{
    internal class AtomReceiveProperties : ConfigProperties
    {
        private string uri;
        private string address;
        private int pollingInterval;
        private string pollingIntervalUnit;
        private int numberOfEvents;
        private string stateFile;
        private string userName;
        private string password;
        private string namespaceWhitelist;
        private SecuritySettings securitySettings = null;

        private string firstFeed;
        private string firstEntry;
        private bool findFirst;

        private bool useLogging;
        private string logSource;
        private bool logEventId;
        private bool logUri;
        private string logContentXpath;
        private bool logNamespace;
        private bool logDiscarded;


        private int feedMax = 0;

        public SecuritySettings SecuritySettings
        {
            get
            {
                return securitySettings;
            }
        }

        public int FeedMax { get { return feedMax; } }
        public string StateFile { get { return stateFile; } }
        public string Uri { get { return uri; } }

        public string Address { get { return address; } }
        public int PollingInterval { get { return pollingInterval; } }
        public string PollingIntervalUnit { get { return pollingIntervalUnit; } }
        public int NumberOfEvents { get { return numberOfEvents; } }

        public string FirstFeed { get { return firstFeed; } }
        public string FirstEntry { get { return firstEntry; } }
        public bool FirdFirst { get { return findFirst; } }



        public bool UseLogging { get { return useLogging; } }
        public string LogSource { get { return logSource; } }
        public bool LogEventId { get { return logEventId; } }
        public bool LogUri { get { return logUri; } }
        public string LogContentXpath { get { return logContentXpath; } }
        public bool LogNamespace { get { return logNamespace; } }
        public bool LogDiscarded { get { return logDiscarded; } }
        private List<string> _namespaceWhiteList;
        public List<string> NamespaceWhiteList { get { return _namespaceWhiteList; } }

        public bool NeedXMLContent {
            get
            {
                return NamespaceWhiteList.Count > 0 || !string.IsNullOrWhiteSpace(LogContentXpath);
            }
        }


        public AtomReceiveProperties(string uri)
        {
            try
            {
                this.uri = uri;
                this.pollingInterval = 3000;
                this.pollingIntervalUnit = "seconds";
                this.numberOfEvents = 10;
                this.stateFile = String.Empty;
                this.address = String.Empty;
                this.userName = String.Empty;
                this.password = String.Empty;
                this.findFirst = false;
                this.firstFeed = String.Empty;
                this.firstEntry = String.Empty;
                this.feedMax = 10;

                this.useLogging = false;
                this.logSource = "BizTalk Application";
                this.logEventId = false;
                this.logUri = false;
                this.logContentXpath = string.Empty;
                this.logNamespace = false;
                this.logDiscarded = false;
                this.namespaceWhitelist = string.Empty;
                this._namespaceWhiteList = new List<string>();

            }
            finally
            {
            }
        }

        public virtual void HandlerConfiguration(XmlDocument configDOM)
        {
        }

        public virtual void LocationConfiguration(XmlDocument configDOM, bool update)
        {
            try
            {

                XmlNode nodeAddress = configDOM.SelectSingleNode("Config/address");
                if (nodeAddress == null)
                    throw new ArgumentNullException("NodeAddress", "Atom feed address must be specified!");
                this.address = nodeAddress.InnerText;

                XmlNode nodeStateFile = configDOM.SelectSingleNode("Config/stateFile");
                if (nodeStateFile == null)
                    throw new ArgumentNullException("NodeStateFile", "Path to state file must be specified!");
                this.stateFile = nodeStateFile.InnerText;

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

                XmlNode nodeNumberOfEvents = configDOM.SelectSingleNode("Config/numberOfEvents");
                this.numberOfEvents = int.Parse(nodeNumberOfEvents.InnerText);

                XmlNode userName = configDOM.SelectSingleNode("Config/userName");
                if (userName != null)
                {
                    XmlNode password = configDOM.SelectSingleNode("Config/password");

                    if (securitySettings == null)
                        securitySettings = new SecuritySettings();

                    securitySettings.Credentials = new NetworkCredential(StringIFNull(userName), StringIFNull(password));
                }

                XmlNode clientCertificate = configDOM.SelectSingleNode("Config/clientCertificate");
                if (clientCertificate != null)
                {
                    if (securitySettings == null)
                        securitySettings = new SecuritySettings();

                    securitySettings.ClientCertificate = CertificateStore.GetCertByThumbprint(clientCertificate.InnerText);
                }

                XmlNode firstFeed = configDOM.SelectSingleNode("Config/firstFeed");
                if (firstFeed != null)
                {
                    this.firstFeed = firstFeed.InnerText;
                }

                XmlNode nodeFirstEntry = configDOM.SelectSingleNode("Config/firstEntry");
                if (firstFeed != null)
                {
                    this.firstEntry = nodeFirstEntry.InnerText;
                }          
                      
                XmlNode findFirst = configDOM.SelectSingleNode("Config/findFirst");
                if (findFirst != null)
                {
                    this.findFirst = Boolean.Parse(findFirst.InnerText);
                }

                XmlNode feedMax = configDOM.SelectSingleNode("Config/feedMax");
                if (feedMax != null)
                {
                    this.feedMax = Int32.Parse(feedMax.InnerText);
                }

                XmlNode useLoggingNode = configDOM.SelectSingleNode("Config/useLogging");
                if (useLoggingNode != null)
                {
                    this.useLogging = Boolean.Parse(useLoggingNode.InnerText);
                }

                XmlNode logSourceNode = configDOM.SelectSingleNode("Config/logSource");
                if (logSourceNode != null && !string.IsNullOrWhiteSpace(logSourceNode.InnerText))
                {
                    this.logSource = logSourceNode.InnerText;
                }

                XmlNode logEventIdNode = configDOM.SelectSingleNode("Config/logEventId");
                if (logEventIdNode != null)
                {
                    this.logEventId = Boolean.Parse(logEventIdNode.InnerText);
                }

                XmlNode logUriNode = configDOM.SelectSingleNode("Config/logUri");
                if (logUriNode != null)
                {
                    this.logUri = Boolean.Parse(logUriNode.InnerText);
                }

                XmlNode logContentXpathNode = configDOM.SelectSingleNode("Config/logContentXpath");
                if (logContentXpathNode != null)
                {
                    this.logContentXpath = logContentXpathNode.InnerText;
                }

                XmlNode logNamespaceNode = configDOM.SelectSingleNode("Config/logNamespace");
                if (logNamespaceNode != null)
                {
                    this.logNamespace = Boolean.Parse(logNamespaceNode.InnerText);
                }

                XmlNode logDiscardedNode = configDOM.SelectSingleNode("Config/logDiscarded");
                if (logDiscardedNode != null)
                {
                    this.logDiscarded = Boolean.Parse(logDiscardedNode.InnerText);
                }

                XmlNode namespaceWhitelistNode = configDOM.SelectSingleNode("Config/namespaceWhitelist");
                if (namespaceWhitelistNode != null)
                {
                    this.namespaceWhitelist = namespaceWhitelistNode.InnerText;
                    if (!string.IsNullOrWhiteSpace(this.namespaceWhitelist))
                    {

                        _namespaceWhiteList = new List<string>(this.namespaceWhitelist.Split('|'));
                    }
                }

            }
            catch (Exception ex)
            {
                throw new ArgumentNullException("One or more configuration parameters are missing!", ex);
            }
        }

        private string StringIFNull(XmlNode node)
        {
            return StringIFNull(node, "");
        }

        private string StringIFNull(XmlNode node, string replacement)
        {
            if (node == null)
            {
                return replacement;
            }
            else
            {
                return node.InnerText;
            }
        }
    }
}
