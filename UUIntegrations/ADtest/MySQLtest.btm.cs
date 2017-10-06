namespace ADtest {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"UU.Integrations.Common.Schemas.Internal.InternalGroupEvent", typeof(global::UU.Integrations.Common.Schemas.Internal.InternalGroupEvent))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"UU.Integrations.Common.Schemas.Internal.InternalGroup", typeof(global::UU.Integrations.Common.Schemas.Internal.InternalGroup))]
    public sealed class MySQLtest : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s1 s0 ScriptNS0 ScriptNS1"" version=""1.0"" xmlns:s1=""http://UU.Integrations.Common.Schemas.InternalGroupEvent"" xmlns:ns0=""http://UU.Integrations.Common.Schemas.Internal.Group"" xmlns:s0=""http://UU.Integrations.Common.Schemas.Internal.Identity"" xmlns:ScriptNS0=""http://schemas.microsoft.com/BizTalk/2003/ScriptNS0"" xmlns:ScriptNS1=""http://schemas.microsoft.com/BizTalk/2003/ScriptNS1"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s1:GroupEvent"" />
  </xsl:template>
  <xsl:template match=""/s1:GroupEvent"">
    <ns0:Group>
      <xsl:variable name=""var:v1"" select=""ScriptNS0:Select()"" />
      <xsl:attribute name=""type"">
        <xsl:value-of select=""$var:v1"" />
      </xsl:attribute>
      <xsl:variable name=""var:v2"" select=""ScriptNS1:DBLookup(0 , &quot;1AS001&quot; , &quot;DRIVER={MySQL ODBC 5.3 Unicode Driver};SERVER=ladoktestdb-uu.its.uu.se;DATABASE=uu;UID=l2adapter;PASSWORD=Gx8!SU4b;OPTION=3&quot; , &quot;kurs&quot; , &quot;kod&quot;)"" />
      <xsl:variable name=""var:v3"" select=""ScriptNS1:DBErrorExtract(string($var:v2))"" />
      <ns0:Description>
        <xsl:value-of select=""$var:v3"" />
      </ns0:Description>
    </ns0:Group>
    <xsl:variable name=""var:v4"" select=""ScriptNS1:DBLookupShutdown()"" />
  </xsl:template>
</xsl:stylesheet>";
        
        private const int _useXSLTransform = 0;
        
        private const string _strArgList = @"<ExtensionObjects>
  <ExtensionObject Namespace=""http://schemas.microsoft.com/BizTalk/2003/ScriptNS0"" AssemblyName=""UU.Integrations.Helper, Version=1.0.0.0, Culture=neutral, PublicKeyToken=b64e3957dd28061a"" ClassName=""Helper.MySQLConnect"" />
  <ExtensionObject Namespace=""http://schemas.microsoft.com/BizTalk/2003/ScriptNS1"" AssemblyName=""Microsoft.BizTalk.BaseFunctoids, Version=3.0.1.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"" ClassName=""Microsoft.BizTalk.BaseFunctoids.FunctoidScripts"" />
</ExtensionObjects>";
        
        private const string _strSrcSchemasList0 = @"UU.Integrations.Common.Schemas.Internal.InternalGroupEvent";
        
        private const global::UU.Integrations.Common.Schemas.Internal.InternalGroupEvent _srcSchemaTypeReference0 = null;
        
        private const string _strTrgSchemasList0 = @"UU.Integrations.Common.Schemas.Internal.InternalGroup";
        
        private const global::UU.Integrations.Common.Schemas.Internal.InternalGroup _trgSchemaTypeReference0 = null;
        
        public override string XmlContent {
            get {
                return _strMap;
            }
        }
        
        public override int UseXSLTransform {
            get {
                return _useXSLTransform;
            }
        }
        
        public override string XsltArgumentListContent {
            get {
                return _strArgList;
            }
        }
        
        public override string[] SourceSchemas {
            get {
                string[] _SrcSchemas = new string [1];
                _SrcSchemas[0] = @"UU.Integrations.Common.Schemas.Internal.InternalGroupEvent";
                return _SrcSchemas;
            }
        }
        
        public override string[] TargetSchemas {
            get {
                string[] _TrgSchemas = new string [1];
                _TrgSchemas[0] = @"UU.Integrations.Common.Schemas.Internal.InternalGroup";
                return _TrgSchemas;
            }
        }
    }
}
