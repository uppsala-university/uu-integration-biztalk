using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSOUrlHelper
{
    public class MyClass : BehaviorExtensionElement, IEndpointBehavior
    {
        [ConfigurationProperty("Username", DefaultValue = "xxx")]
        public string Username
        {
            get { return (string)base["Username"]; }
            set { base["Username"] = value; }
        }

        [ConfigurationProperty("Password", DefaultValue = "xxx")]
        public string Password
        {
            get { return (string)base["Password"]; }
            set { base["Password"] = value; }
        }

        [ConfigurationProperty("Domain", DefaultValue = "xxx")]
        public string Domain
        {
            get { return (string)base["Domain"]; }
            set { base["Domain"] = value; }
        }

        public void AddBindingParameters(ServiceEndpoint endpoint, System.ServiceModel.Channels.BindingParameterCollection bindingParameters)
        {
            if (bindingParameters != null)
            {
                SecurityCredentialsManager manager = bindingParameters.Find<ClientCredentials>();

                var cc = endpoint.Behaviors.Find<ClientCredentials>();
                cc.UserName.UserName = this.Domain + @"\" + this.Username;
                cc.UserName.Password = this.Password;
                cc.Windows.ClientCredential.UserName = this.Username;
                cc.Windows.ClientCredential.Password = this.Password;
                cc.Windows.ClientCredential.Domain = this.Domain;

                if (manager == null)
                    bindingParameters.Add(this);
            }
            else
            {
                throw new ArgumentNullException("bindingParameters cannot be null.");
            }
        }
    }
}
