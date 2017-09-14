namespace INT0002.Ladok3.Maps {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande+ForvantatDeltagandeSkapadEvent", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande.ForvantatDeltagandeSkapadEvent))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.GroupEvents.InternalGroupEvent", typeof(global::Shared.Schemas.GroupEvents.InternalGroupEvent))]
    public sealed class ForvantatDeltagandeSkapadEvent_to_InternalGroupEvent : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s3 s0 s2 s1 userCSharp"" version=""1.0"" xmlns:uuii=""http://UU.Integrations.Common.Schemas.Internal.Identity"" xmlns:uuig=""http://UU.Integrations.Common.Schemas.Internal.Group"" xmlns:s3=""http://schemas.ladok.se/studiedeltagande"" xmlns:s0=""http://schemas.ladok.se/events"" xmlns:s2=""http://schemas.ladok.se/dap"" xmlns:ns0=""http://UU.Integrations.Common.Schemas.InternalGroupEvent"" xmlns:s1=""http://schemas.ladok.se"" xmlns:userCSharp=""http://schemas.microsoft.com/BizTalk/2003/userCSharp"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s3:ForvantatDeltagandeSkapadEvent"" />
  </xsl:template>
  <xsl:template match=""/s3:ForvantatDeltagandeSkapadEvent"">
    <xsl:variable name=""var:v1"" select=""userCSharp:StringTrimRight(&quot;GroupMembershipCreateRequestEvent&quot;)"" />
    <xsl:variable name=""var:v2"" select=""userCSharp:StringTrimRight(&quot;ForvantatDeltagande&quot;)"" />
    <ns0:GroupEvent>
      <xsl:attribute name=""type"">
        <xsl:value-of select=""$var:v1"" />
      </xsl:attribute>
      <uuig:Group>
        <xsl:attribute name=""type"">
          <xsl:value-of select=""$var:v2"" />
        </xsl:attribute>
        <uuig:Names>
          <uuig:Name>
            <xsl:value-of select=""s3:UtbildningstillfalleUID/text()"" />
          </uuig:Name>
        </uuig:Names>
      </uuig:Group>
      <ns0:GroupEventData>
        <uuii:NewMember>
          <xsl:attribute name=""identifier"">
            <xsl:value-of select=""s3:StudentUID/text()"" />
          </xsl:attribute>
          <uuii:PersonNumber>
            <xsl:value-of select=""s3:StudentUID/text()"" />
          </uuii:PersonNumber>
        </uuii:NewMember>
      </ns0:GroupEventData>
    </ns0:GroupEvent>
  </xsl:template>
  <msxsl:script language=""C#"" implements-prefix=""userCSharp""><![CDATA[
public string StringTrimRight(string str)
{
	if (str == null)
	{
		return """";
	}
	return str.TrimEnd(null);
}



]]></msxsl:script>
</xsl:stylesheet>";
        
        private const int _useXSLTransform = 0;
        
        private const string _strArgList = @"<ExtensionObjects />";
        
        private const string _strSrcSchemasList0 = @"Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande+ForvantatDeltagandeSkapadEvent";
        
        private const global::Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande.ForvantatDeltagandeSkapadEvent _srcSchemaTypeReference0 = null;
        
        private const string _strTrgSchemasList0 = @"Shared.Schemas.GroupEvents.InternalGroupEvent";
        
        private const global::Shared.Schemas.GroupEvents.InternalGroupEvent _trgSchemaTypeReference0 = null;
        
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
                _SrcSchemas[0] = @"Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande+ForvantatDeltagandeSkapadEvent";
                return _SrcSchemas;
            }
        }
        
        public override string[] TargetSchemas {
            get {
                string[] _TrgSchemas = new string [1];
                _TrgSchemas[0] = @"Shared.Schemas.GroupEvents.InternalGroupEvent";
                return _TrgSchemas;
            }
        }
    }
}
