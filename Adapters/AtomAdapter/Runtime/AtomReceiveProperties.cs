
using System;
using System.IO;
using System.Xml;
using System.Net;
using System.Collections;
using Microsoft.BizTalk.Message.Interop;
using Microsoft.BizTalk.Adapter.Common;
using Shared.Components;

namespace BizTalk.Adapter.Atom
{

   // public enum SizeUnit { Bytes, KBytes, MBytes }

    // //////////////////////////////////////////////////////////////////////////////////////////////

    internal class AtomReceiveProperties : ConfigProperties
    {
        private string uri;
        private string address;
        private int pollingInterval;
        private string pollingIntervalUnit;
        private string stateFile;
        private string userName;
        private string password;
        private SecuritySettings securitySettings = null;

        private string firstFeed;
        private bool findFirst;

        private string clientCertificate;
        public SecuritySettings SecuritySettings {
            get {
                return securitySettings;
            }
        }
       
        public string StateFile { get { return stateFile; } }
        public string Uri { get { return uri; } }

        public string Address { get { return address; } }
        public int PollingInterval { get { return pollingInterval; } }
        public string PollingIntervalUnit { get { return pollingIntervalUnit; } }


        public string FirstFeed { get { return firstFeed; } }
        public bool FirdFirst { get { return findFirst; } }
        /*
        public static TimeSpan Time(string time)
        {
            TimeSpan span;
            if (TimeSpan.TryParse(time, out span) == false)
                span = new TimeSpan(0, 0, 1);

            return span;
        }
        */
        public AtomReceiveProperties (string uri)
        {
            try
            {
                this.uri = uri;
                this.pollingInterval = 3000;
                this.pollingIntervalUnit = "seconds";
                this.stateFile = String.Empty;
                this.address = String.Empty;
                this.userName = String.Empty;
                this.password = String.Empty;
                this.clientCertificate = String.Empty;
                this.findFirst = false;
                this.firstFeed = String.Empty;

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


                XmlNode nodeAddress = configDOM.SelectSingleNode("Config/address");

                if (nodeAddress == null)
                    throw new ArgumentNullException("NodeAddress", "Atom feed address must be specified!");

                this.address = nodeAddress.InnerText;

                int pollingIntervalValue = int.Parse(nodePollingInterval.InnerText);

                this.pollingInterval = pollingIntervalMultiplier * pollingIntervalValue;

                XmlNode nodeStateFile = configDOM.SelectSingleNode("Config/stateFile");

                if (nodeStateFile == null)
                    throw new ArgumentNullException("NodeStateFile", "Path to state file must be specified!");

                this.stateFile = nodeStateFile.InnerText;

                XmlNode userName = configDOM.SelectSingleNode("Config/userName");

                if (userName != null)
                {
                    XmlNode password = configDOM.SelectSingleNode("Config/password");

                    if (securitySettings == null)
                        securitySettings = new SecuritySettings();

                    securitySettings.Credentials = new NetworkCredential(StringIFNull(userName), StringIFNull(password));
                

                }

                XmlNode clientCertificate = configDOM.SelectSingleNode("Config/clientCertificate");

                if(clientCertificate != null)
                {
                    if (securitySettings == null)
                        securitySettings = new SecuritySettings();

                    securitySettings.ClientCertificate = CertificateStore.GetCertByThumbprint(clientCertificate.InnerText);
                }

                XmlNode firstFeed = configDOM.SelectSingleNode("Config/firstFeed");

                if(firstFeed != null)
                {
                    this.firstFeed = firstFeed.InnerText;
                }


                XmlNode findFirst = configDOM.SelectSingleNode("Config/findFirst");

                if (findFirst != null)
                {
                    this.findFirst = Boolean.Parse(findFirst.InnerText);
                }


            }
            catch (Exception ex)
            {
                throw new ArgumentNullException("One or more configuration parameters are missing!",ex);
            }
           
        }

        private string StringIFNull(XmlNode node)
        {
            return StringIFNull(node, "");
        }

        private string StringIFNull(XmlNode node,string replacement)
        {
            if(node == null)
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
