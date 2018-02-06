
using System;
using System.Data.OleDb;
using System.IO;
using System.Xml;
using System.Xml.Schema;
using System.Text;
using System.Windows.Forms;
using System.Runtime.Serialization;
using System.Runtime.InteropServices;
using Microsoft.Win32;
using Microsoft.BizTalk.Adapter.Framework;
using Microsoft.BizTalk.Component.Interop;
using System.Reflection;

namespace BizTalk.Adapter.AtomAdmin
{
    /// <summary>
    /// Atom AdapterManagement.
    /// </summary>
    [CLSCompliant(false)]
    public class AtomAdapterManagement :
        IAdapterConfig,
        IStaticAdapterConfig,
        IAdapterConfigValidation
    {
        public AtomAdapterManagement()
        {
        }

        #region IStaticAdapterConfig Members

        public string GetServiceOrganization(IPropertyBag endPointConfiguration, string nodeIdentifier)
        {
            return null;
        }



        #endregion
        //  IAdapterConfig
        public string GetConfigSchema(ConfigType type)
        {
            switch (type)
            {

                case ConfigType.ReceiveHandler:
                    return GetSchemaFromResource("BizTalk.Adapter.AtomAdmin.ReceiveHandler.xsd");

                case ConfigType.ReceiveLocation:
                    return GetSchemaFromResource("BizTalk.Adapter.AtomAdmin.ReceiveLocation.xsd");
            }

            return String.Empty;
        }

        private string GetSchemaFromResource(string name)
        {
            Assembly assem = this.GetType().Assembly;
            using (Stream stream = assem.GetManifestResourceStream(name))
            {
                using (StreamReader reader = new StreamReader(stream))
                {
                    string schema = reader.ReadToEnd();
                    return schema;
                }
            }
        }
        // used to get the WSDL file name for the selected WSDL.
        public string[] GetServiceDescription(string[] wsdls)
        {
            string[] result = null;
            return result;
        }

        //used to acquire externally referenced xsd's
        public Result GetSchema(string xsdLocation, string xsdNamespace, out string xsdFileName)
        {
            xsdFileName = string.Empty;
            return Result.Continue;
        }

        public string ValidateConfiguration(ConfigType type, string config)
        {
            try
            {
                switch (type)
                {


                    case ConfigType.ReceiveHandler:
                        return config;

                    case ConfigType.ReceiveLocation:
                        return ValidateLocation(config);

                }
            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message);
            }
            return String.Empty;
        }

        /// <summary>
        /// Generate uri entry based on directory and fileMask values
        /// </summary>
        /// <param name="config">Instance value to be validated</param>
        /// <returns>Validated configuration.</returns>
        private string ValidateLocation(string config)
        {

            // Load up document
            XmlDocument document = new XmlDocument();
            document.LoadXml(config);

            XmlNode address = document.SelectSingleNode("Config/address");

            //check uri?
        
            XmlNode uri = document.SelectSingleNode("Config/uri");
            if (null == uri)
            {
                uri = document.CreateElement("uri");
                document.DocumentElement.AppendChild(uri);
            }

            uri.InnerText = address.InnerText;



            return document.OuterXml;
        }

    }
}
