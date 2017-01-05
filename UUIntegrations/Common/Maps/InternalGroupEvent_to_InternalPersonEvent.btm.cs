namespace UU.Integrations.Common.Maps {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"UU.Integrations.Common.Schemas.Internal.InternalGroupEvent", typeof(global::UU.Integrations.Common.Schemas.Internal.InternalGroupEvent))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"UU.Integrations.Common.Schemas.Internal.InternalPersonEvent", typeof(global::UU.Integrations.Common.Schemas.Internal.InternalPersonEvent))]
    public sealed class InternalGroupEvent_to_InternalPersonEvent : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s2 s1 s0 userCSharp"" version=""1.0"" xmlns:s0=""http://UU.Integrations.Common.Schemas.Internal.Identity"" xmlns:s2=""http://UU.Integrations.Common.Schemas.InternalGroupEvent"" xmlns:ns0=""http://UU.Integrations.Common.Schemas.InternalPersonEvent"" xmlns:s1=""http://UU.Integrations.Common.Schemas.Internal.Group"" xmlns:uuii=""http://UU.Integrations.Common.Schemas.Internal.Person"" xmlns:userCSharp=""http://schemas.microsoft.com/BizTalk/2003/userCSharp"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s2:GroupEvent"" />
  </xsl:template>
  <xsl:template match=""/s2:GroupEvent"">
    <xsl:variable name=""var:v1"" select=""userCSharp:StringTrimRight(&quot;PersonStudentAffiliationCreateRequestEvent&quot;)"" />
    <ns0:PersonEvent>
      <xsl:attribute name=""type"">
        <xsl:value-of select=""$var:v1"" />
      </xsl:attribute>
      <ns0:IssuedTime>
        <xsl:value-of select=""s2:IssuedTime/text()"" />
      </ns0:IssuedTime>
      <ns0:Producer>
        <xsl:value-of select=""s2:Producer/text()"" />
      </ns0:Producer>
      <ns0:ProducerReferenceId>
        <xsl:value-of select=""s2:ProducerReferenceId/text()"" />
      </ns0:ProducerReferenceId>
      <uuii:Person>
        <xsl:attribute name=""identifier"">
          <xsl:value-of select=""s2:GroupEventData/s0:NewMember/@identifier"" />
        </xsl:attribute>
        <uuii:PersonNumber>
          <xsl:value-of select=""s2:GroupEventData/s0:NewMember/s0:PersonNumber/text()"" />
        </uuii:PersonNumber>
      </uuii:Person>
    </ns0:PersonEvent>
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
        
        private const string _strArgList = @"<ExtensionObjects />";
        
        private const string _strSrcSchemasList0 = @"UU.Integrations.Common.Schemas.Internal.InternalGroupEvent";
        
        private const global::UU.Integrations.Common.Schemas.Internal.InternalGroupEvent _srcSchemaTypeReference0 = null;
        
        private const string _strTrgSchemasList0 = @"UU.Integrations.Common.Schemas.Internal.InternalPersonEvent";
        
        private const global::UU.Integrations.Common.Schemas.Internal.InternalPersonEvent _trgSchemaTypeReference0 = null;
        
        public override string XmlContent {
            get {
                return _strMap;
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
                _TrgSchemas[0] = @"UU.Integrations.Common.Schemas.Internal.InternalPersonEvent";
                return _TrgSchemas;
            }
        }
    }
}
