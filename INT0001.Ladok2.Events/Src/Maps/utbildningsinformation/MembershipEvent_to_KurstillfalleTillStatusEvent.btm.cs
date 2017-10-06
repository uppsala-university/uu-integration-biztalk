namespace INT0001.Ladok2.Events.Maps {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet", typeof(global::INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation+KurstillfalleTillStatusEvent", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation.KurstillfalleTillStatusEvent))]
    public sealed class MembershipEventSingle_to_KurstillfalleTillStatusEvent : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s0 userCSharp"" version=""1.0"" xmlns:events=""http://schemas.ladok.se/events"" xmlns:ns0=""http://schemas.ladok.se/utbildningsinformation"" xmlns:dap=""http://schemas.ladok.se/dap"" xmlns:base=""http://schemas.ladok.se"" xmlns:s0=""http://schemas.microsoft.com/Sql/2008/05/TypedPolling/ladokevents"" xmlns:userCSharp=""http://schemas.microsoft.com/BizTalk/2003/userCSharp"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s0:TypedPollingResultSet0"" />
  </xsl:template>
  <xsl:template match=""/s0:TypedPollingResultSet0"">
    <xsl:variable name=""var:v1"" select=""userCSharp:StringTrimLeft(&quot;2&quot;)"" />
    <ns0:KurstillfalleTillStatusEvent>
      <ns0:Status>
        <xsl:value-of select=""$var:v1"" />
      </ns0:Status>
      <xsl:if test=""s0:courseCode"">
        <ns0:UtbildningsinstansUID>
          <xsl:value-of select=""s0:courseCode/text()"" />
        </ns0:UtbildningsinstansUID>
      </xsl:if>
      <xsl:if test=""s0:startSemester"">
        <ns0:StartperiodID>
          <xsl:value-of select=""s0:startSemester/text()"" />
        </ns0:StartperiodID>
      </xsl:if>
      <xsl:if test=""s0:reportCode"">
        <ns0:Utbildningstillfalleskod>
          <xsl:value-of select=""s0:reportCode/text()"" />
        </ns0:Utbildningstillfalleskod>
      </xsl:if>
    </ns0:KurstillfalleTillStatusEvent>
  </xsl:template>
  <msxsl:script language=""C#"" implements-prefix=""userCSharp""><![CDATA[
public string StringTrimLeft(string str)
{
	if (str == null)
	{
		return """";
	}
	return str.TrimStart(null);
}



]]></msxsl:script>
</xsl:stylesheet>";
        
        private const int _useXSLTransform = 0;
        
        private const string _strArgList = @"<ExtensionObjects />";
        
        private const string _strSrcSchemasList0 = @"INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet";
        
        private const global::INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet _srcSchemaTypeReference0 = null;
        
        private const string _strTrgSchemasList0 = @"Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation+KurstillfalleTillStatusEvent";
        
        private const global::Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation.KurstillfalleTillStatusEvent _trgSchemaTypeReference0 = null;
        
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
                _SrcSchemas[0] = @"INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet";
                return _SrcSchemas;
            }
        }
        
        public override string[] TargetSchemas {
            get {
                string[] _TrgSchemas = new string [1];
                _TrgSchemas[0] = @"Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation+KurstillfalleTillStatusEvent";
                return _TrgSchemas;
            }
        }
    }
}
