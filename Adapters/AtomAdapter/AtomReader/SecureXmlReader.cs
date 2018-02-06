using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.IO;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Collections.Concurrent;

namespace Shared.Components
{
    public class SecureXmlReader
    {
        private SecuritySettings securitysettings = null;
        private MemoryStream mem = null;//the last entry i always saved, if the next call is to the same uri
        string latestUri = String.Empty;
        public SecureXmlReader(SecuritySettings securitysettings)
        {
            this.securitysettings = securitysettings;
            mem = new MemoryStream();
        }

        public SecureXmlReader():this((SecuritySettings)null)
        {
          
        }

        public string LatestUri{
            get{
                return latestUri;
            }
            }


        public XmlReader Create()
        {
            if (latestUri == String.Empty)
                throw new ArgumentException("This is the first time Create is called, uri must be specified");

            return Create(latestUri);
        }
        public  XmlReader Create(string uri)
        {

           
           if (securitysettings == null)
            {
                latestUri = uri;
                return XmlReader.Create(uri);
            }
                


            if (latestUri != uri)
            {

           
                HttpWebRequest httpWRequest = (HttpWebRequest)WebRequest.Create(uri);

                httpWRequest.KeepAlive = true;

                if (securitysettings.ClientCertificate != null)
                {
                    X509Certificate2 cert = securitysettings.ClientCertificate;

                    httpWRequest.ClientCertificates.Add(cert);
                }

                if (securitysettings.Credentials != null)
                {
                    httpWRequest.Credentials = securitysettings.Credentials;
                }


                using (HttpWebResponse response = (HttpWebResponse)httpWRequest.GetResponse())
                {
                    response.GetResponseStream().CopyTo(mem = new MemoryStream());
                }

                latestUri = uri;
            }

            mem.Seek(0, SeekOrigin.Begin);

            return XmlReader.Create(mem);
           

        }





    }
}
