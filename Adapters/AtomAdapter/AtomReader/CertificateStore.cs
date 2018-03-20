using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography.X509Certificates;
using System.Collections.Concurrent;
using System.Text.RegularExpressions;

namespace Shared.Components
{
    public static class CertificateStore
    {
        private static ConcurrentDictionary<string, X509Certificate2> certificates = null;
        public static ConcurrentDictionary<string, X509Certificate2> Certificates
        {
            get
            {
                if (certificates == null)
                    certificates = new ConcurrentDictionary<string, X509Certificate2>();

                return certificates;
            }
        }
        public static X509Certificate2 GetCertByThumbprint(string thumbprint)
        {
            X509Certificate2 cert = null;
           
            if (thumbprint.Length > 40)
                thumbprint = Regex.Replace(thumbprint, @"[^\da-fA-F]", string.Empty);

            if (Certificates.TryGetValue(thumbprint, out cert) == false)
            {


                X509Store store = new X509Store(StoreLocation.CurrentUser);
                store.Open(OpenFlags.ReadOnly);

                X509Certificate2Collection cers = store.Certificates.Find(X509FindType.FindByThumbprint, thumbprint, false);

                if (cers.Count == 0)
                {
                    store.Close();

                    store = new X509Store(StoreLocation.LocalMachine);
                    store.Open(OpenFlags.ReadOnly);

                    cers = store.Certificates.Find(X509FindType.FindByThumbprint, thumbprint, false);


                }

                if (cers.Count > 0)
                {
                    cert = cers[0];
                    Certificates.TryAdd(thumbprint, cert);
                };
                store.Close();
            }

            return cert;
        }
    }
}
