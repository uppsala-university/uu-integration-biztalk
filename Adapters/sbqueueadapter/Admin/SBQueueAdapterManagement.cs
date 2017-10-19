
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
using Microsoft.Samples.BizTalk.Adapter.Common;

namespace BizTalk.Adapter.SBQueueAdmin
{
	/// <summary>
	/// Summary description for AdapterManagement.
	/// </summary>
	[CLSCompliant(false)]
	public class SBQueueAdapterManagement :
		AdapterManagementBase,
		IAdapterConfig,
		IAdapterConfigValidation 
	{
		public SBQueueAdapterManagement()
		{
		}

		//  IAdapterConfig
		public string GetConfigSchema (ConfigType type)
		{
			switch (type)
			{

				case ConfigType.ReceiveHandler:
                    return GetSchemaFromResource("BizTalk.Adapter.SBQueueAdmin.ReceiveHandler.xsd");
				
				case ConfigType.ReceiveLocation:
                    return GetSchemaFromResource("BizTalk.Adapter.SBQueueAdmin.ReceiveLocation.xsd");
			}

			return String.Empty;
		}

		// used to get the WSDL file name for the selected WSDL.
		public string [] GetServiceDescription(string [] wsdls)
		{
			string []result = null;
			return result;
		}

		//used to acquire externally referenced xsd's
		public Result GetSchema( string xsdLocation, string xsdNamespace, out string xsdFileName)
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
		private string ValidateLocation (string config)
		{
           
            // Load up document
            XmlDocument document = new XmlDocument();
            document.LoadXml(config);

            XmlNode nodeQueue = document.SelectSingleNode("Config/queue");
            if (null == nodeQueue)
            {
                nodeQueue = document.CreateElement("queue");
                document.DocumentElement.AppendChild(nodeQueue);
            }

            XmlNode nodeEndpoint = document.SelectSingleNode("Config/endpoint");
            if (null == nodeEndpoint)
            {
                nodeEndpoint = document.CreateElement("queue");
                document.DocumentElement.AppendChild(nodeEndpoint);
            }

            var slash = nodeEndpoint.InnerText.EndsWith("/") ? String.Empty : "/";

           
            XmlNode uri = document.SelectSingleNode("Config/uri");
            if (null == uri)
            {
                uri = document.CreateElement("uri");
                document.DocumentElement.AppendChild(uri);
            }

            uri.InnerText = String.Format("{0}{1}{2}", nodeEndpoint.InnerText, slash, nodeQueue.InnerText);



            return document.OuterXml;
        }

	}
}
