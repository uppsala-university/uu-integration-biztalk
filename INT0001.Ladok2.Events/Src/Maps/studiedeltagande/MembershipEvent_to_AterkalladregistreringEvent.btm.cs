namespace INT0001.Ladok2.Events.Maps {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet", typeof(global::INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande+AterkalladregistreringEvent", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande.AterkalladregistreringEvent))]
    public sealed class MembershipEvent_to_AterkalladregistreringEvent : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s0 userCSharp"" version=""1.0"" xmlns:ns0=""http://schemas.ladok.se/studiedeltagande"" xmlns:events=""http://schemas.ladok.se/events"" xmlns:s0=""http://schemas.microsoft.com/Sql/2008/05/TypedPolling/ladokevents"" xmlns:dap=""http://schemas.ladok.se/dap"" xmlns:base=""http://schemas.ladok.se"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:userCSharp=""http://schemas.microsoft.com/BizTalk/2003/userCSharp"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s0:TypedPollingResultSet0"" />
  </xsl:template>
  <xsl:template match=""/s0:TypedPollingResultSet0"">
    <xsl:variable name=""var:v1"" select=""userCSharp:StringConcat(string(s0:startSemester/text()) , &quot;_&quot; , string(s0:reportCode/text()))"" />
    <ns0:AterkalladregistreringEvent>
      <xsl:attribute name=""xsi:type"">
        <xsl:value-of select=""'ns0:AterkalladOmregistreringEvent'"" />
      </xsl:attribute>
      <events:EventContext>
        <events:Anvandarnamn>
          <xsl:text>ladok</xsl:text>
        </events:Anvandarnamn>
        <events:LarosateID>
          <xsl:text>0</xsl:text>
        </events:LarosateID>
      </events:EventContext>
      <xsl:if test=""s0:Id"">
        <events:HandelseUID>
          <xsl:value-of select=""s0:Id/text()"" />
        </events:HandelseUID>
      </xsl:if>
      <xsl:if test=""s0:courseCode"">
        <ns0:KursUID>
          <xsl:value-of select=""s0:courseCode/text()"" />
        </ns0:KursUID>
      </xsl:if>
      <ns0:KurstillfalleUID>
        <xsl:value-of select=""$var:v1"" />
      </ns0:KurstillfalleUID>
      <ns0:Period>
        <xsl:text>0</xsl:text>
      </ns0:Period>
      <ns0:RegistreringUID>
        <xsl:text />
      </ns0:RegistreringUID>
      <xsl:if test=""s0:pnr"">
        <ns0:StudentUID>
          <xsl:value-of select=""s0:pnr/text()"" />
        </ns0:StudentUID>
      </xsl:if>
      <ns0:TillfallesantagningUID>
        <xsl:text />
      </ns0:TillfallesantagningUID>
      <ns0:UtbildningsinstansUID>
        <xsl:text />
      </ns0:UtbildningsinstansUID>
      <ns0:Orsak>
        <xsl:text>studiedeltagande.domain.aterkalla.orsak.borttagen_registrering</xsl:text>
      </ns0:Orsak>
    </ns0:AterkalladregistreringEvent>
  </xsl:template>
  <msxsl:script language=""C#"" implements-prefix=""userCSharp""><![CDATA[
public string StringConcat(string param0, string param1, string param2)
{
   return param0 + param1 + param2;
}



]]></msxsl:script>
</xsl:stylesheet>";
        
        private const int _useXSLTransform = 0;
        
        private const string _strArgList = @"<ExtensionObjects />";
        
        private const string _strSrcSchemasList0 = @"INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet";
        
        private const global::INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet _srcSchemaTypeReference0 = null;
        
        private const string _strTrgSchemasList0 = @"Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande+AterkalladregistreringEvent";
        
        private const global::Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande.AterkalladregistreringEvent _trgSchemaTypeReference0 = null;
        
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
                _TrgSchemas[0] = @"Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande+AterkalladregistreringEvent";
                return _TrgSchemas;
            }
        }
    }
}
