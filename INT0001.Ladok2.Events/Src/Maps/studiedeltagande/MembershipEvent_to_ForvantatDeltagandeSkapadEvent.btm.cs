namespace INT0001.Ladok2.Events.Maps {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet", typeof(global::INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"INT0001.Ladok2.Events.Schemas.Ladok.schemas_ladok_se_studiedeltagande+ForvantatDeltagandeSkapadEvent", typeof(global::INT0001.Ladok2.Events.Schemas.Ladok.schemas_ladok_se_studiedeltagande.ForvantatDeltagandeSkapadEvent))]
    public sealed class MembershipEvent_to_ForvantatDeltagandeSkapadEvent : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s0 userCSharp"" version=""1.0"" xmlns:ns0=""http://schemas.ladok.se/studiedeltagande"" xmlns:events=""http://schemas.ladok.se/events"" xmlns:s0=""http://schemas.microsoft.com/Sql/2008/05/TypedPolling/ladokevents"" xmlns:dap=""http://schemas.ladok.se/dap"" xmlns:base=""http://schemas.ladok.se"" xmlns:userCSharp=""http://schemas.microsoft.com/BizTalk/2003/userCSharp"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s0:TypedPollingResultSet0"" />
  </xsl:template>
  <xsl:template match=""/s0:TypedPollingResultSet0"">
    <xsl:variable name=""var:v1"" select=""userCSharp:StringConcat(string(s0:startSemester/text()) , &quot;_&quot; , string(s0:reportCode/text()))"" />
    <ns0:ForvantatDeltagandeSkapadEvent>
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
      <ns0:Senaredelmarkering>
        <xsl:text>false</xsl:text>
      </ns0:Senaredelmarkering>
      <xsl:if test=""s0:pnr"">
        <ns0:StudentUID>
          <xsl:value-of select=""s0:pnr/text()"" />
        </ns0:StudentUID>
      </xsl:if>
      <ns0:Studieavgiftsbetalning>
        <xsl:text>studiedeltagande.domain.studieavgiftsbetalningsvarde.ej_aktuell</xsl:text>
      </ns0:Studieavgiftsbetalning>
      <ns0:TillfallesantagningUID>
        <xsl:text />
      </ns0:TillfallesantagningUID>
      <ns0:UtbildningstillfalleUID>
        <xsl:value-of select=""$var:v1"" />
      </ns0:UtbildningstillfalleUID>
    </ns0:ForvantatDeltagandeSkapadEvent>
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
        
        private const string _strTrgSchemasList0 = @"INT0001.Ladok2.Events.Schemas.Ladok.schemas_ladok_se_studiedeltagande+ForvantatDeltagandeSkapadEvent";
        
        private const global::INT0001.Ladok2.Events.Schemas.Ladok.schemas_ladok_se_studiedeltagande.ForvantatDeltagandeSkapadEvent _trgSchemaTypeReference0 = null;
        
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
                _TrgSchemas[0] = @"INT0001.Ladok2.Events.Schemas.Ladok.schemas_ladok_se_studiedeltagande+ForvantatDeltagandeSkapadEvent";
                return _TrgSchemas;
            }
        }
    }
}
