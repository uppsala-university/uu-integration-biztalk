namespace INT0003.AD.Distribution.Maps {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.GroupEvents.InternalGroupEvent", typeof(global::Shared.Schemas.GroupEvents.InternalGroupEvent))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.ADEvents.ADSendAdapterSolicitResponseGroupQuery", typeof(global::Shared.Schemas.ADEvents.ADSendAdapterSolicitResponseGroupQuery))]
    public sealed class InternalGroupEvent_to_ADQueryGroup : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s2 s1 s0 userCSharp"" version=""1.0"" xmlns:s0=""http://UU.Integrations.Common.Schemas.Internal.Identity"" xmlns:s2=""http://UU.Integrations.Common.Schemas.InternalGroupEvent"" xmlns:s1=""http://UU.Integrations.Common.Schemas.Internal.Group"" xmlns:ns0=""http://UU.Integrations.Common.Schemas.ADSendAdapterSolicitResponseGroupQuery"" xmlns:userCSharp=""http://schemas.microsoft.com/BizTalk/2003/userCSharp"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s2:GroupEvent"" />
  </xsl:template>
  <xsl:template match=""/s2:GroupEvent"">
    <xsl:variable name=""var:v1"" select=""userCSharp:StringTrimRight(&quot;LDAP://exchange-test.its.uu.se:389/OU=Courses,OU=Student,OU=Akka,DC=exchange-test,DC=its,DC=uu,DC=se&quot;)"" />
    <xsl:variable name=""var:v2"" select=""userCSharp:StringConcat(&quot;(&amp;(objectCategory=group)(cn=&quot; , string(s1:Group/s1:Id/text()) , &quot;))&quot;)"" />
    <xsl:variable name=""var:v3"" select=""userCSharp:StringTrimRight(&quot;onelevel&quot;)"" />
    <xsl:variable name=""var:v4"" select=""userCSharp:StringTrimRight(&quot;cn&quot;)"" />
    <ns0:ActiveDirectoryQuery>
      <ns0:Directives>
        <xsl:attribute name=""WhereToBind"">
          <xsl:value-of select=""$var:v1"" />
        </xsl:attribute>
        <xsl:attribute name=""Filter"">
          <xsl:value-of select=""$var:v2"" />
        </xsl:attribute>
        <xsl:attribute name=""SearchScope"">
          <xsl:value-of select=""$var:v3"" />
        </xsl:attribute>
        <xsl:attribute name=""PropertiesToReturn"">
          <xsl:value-of select=""$var:v4"" />
        </xsl:attribute>
      </ns0:Directives>
    </ns0:ActiveDirectoryQuery>
  </xsl:template>
  <msxsl:script language=""C#"" implements-prefix=""userCSharp""><![CDATA[
public string StringConcat(string param0, string param1, string param2)
{
   return param0 + param1 + param2;
}


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
        
        private const string _strSrcSchemasList0 = @"Shared.Schemas.GroupEvents.InternalGroupEvent";
        
        private const global::Shared.Schemas.GroupEvents.InternalGroupEvent _srcSchemaTypeReference0 = null;
        
        private const string _strTrgSchemasList0 = @"Shared.Schemas.ADEvents.ADSendAdapterSolicitResponseGroupQuery";
        
        private const global::Shared.Schemas.ADEvents.ADSendAdapterSolicitResponseGroupQuery _trgSchemaTypeReference0 = null;
        
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
                _SrcSchemas[0] = @"Shared.Schemas.GroupEvents.InternalGroupEvent";
                return _SrcSchemas;
            }
        }
        
        public override string[] TargetSchemas {
            get {
                string[] _TrgSchemas = new string [1];
                _TrgSchemas[0] = @"Shared.Schemas.ADEvents.ADSendAdapterSolicitResponseGroupQuery";
                return _TrgSchemas;
            }
        }
    }
}
