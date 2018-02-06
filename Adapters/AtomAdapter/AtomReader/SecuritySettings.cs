using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Security.Cryptography.X509Certificates;

namespace Shared.Components
{
    public class SecuritySettings
    {
        public NetworkCredential Credentials { get; set; }
        public X509Certificate2 ClientCertificate { get; set; }
    }
}
