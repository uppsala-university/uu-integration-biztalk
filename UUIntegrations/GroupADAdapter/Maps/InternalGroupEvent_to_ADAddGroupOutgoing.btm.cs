namespace GroupADAdapter {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"UU.Integrations.Common.Schemas.Internal.InternalGroupEvent", typeof(global::UU.Integrations.Common.Schemas.Internal.InternalGroupEvent))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"UU.Integrations.Common.Schemas.ActiveAdapter.ADSendAdapterOneWayUpdate", typeof(global::UU.Integrations.Common.Schemas.ActiveAdapter.ADSendAdapterOneWayUpdate))]
    public sealed class InternalGroupEvent_to_ADAddGroupOutgoing : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s2 s1 s0 userCSharp"" version=""1.0"" xmlns:s2=""http://UU.Integrations.Common.Schemas.InternalGroupEvent"" xmlns:s1=""http://UU.Integrations.Common.Schemas.Internal.Group"" xmlns:s0=""http://UU.Integrations.Common.Schemas.Internal.Identity"" xmlns:userCSharp=""http://schemas.microsoft.com/BizTalk/2003/userCSharp"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s2:GroupEvent"" />
  </xsl:template>
  <xsl:template match=""/s2:GroupEvent"">
    <xsl:variable name=""var:v1"" select=""userCSharp:StringTrimLeft(&quot;LDAP://exchange-test.its.uu.se:389/OU=Courses,OU=Student,OU=Akka,DC=exchange-test,DC=its,DC=uu,DC=se&quot;)"" />
    <xsl:variable name=""var:v2"" select=""userCSharp:StringTrimLeft(&quot;subtree&quot;)"" />
    <xsl:variable name=""var:v3"" select=""userCSharp:StringTrimLeft(&quot;(objectClass=*)&quot;)"" />
    <xsl:variable name=""var:v4"" select=""userCSharp:StringTrimLeft(&quot;1&quot;)"" />
    <xsl:variable name=""var:v5"" select=""userCSharp:StringTrimLeft(&quot;distinguishedName&quot;)"" />
    <xsl:variable name=""var:v6"" select=""userCSharp:StringTrimLeft(&quot;OU=Courses,OU=Student,OU=AKKA,DC=exchange-test,DC=its,DC=uu,DC=se&quot;)"" />
    <xsl:variable name=""var:v7"" select=""userCSharp:StringConcat(&quot;CN=&quot; , string(s1:Group/s1:Id/text()))"" />
    <xsl:variable name=""var:v8"" select=""$var:v7"" />
    <xsl:variable name=""var:v9"" select=""'group'"" />
    <xsl:variable name=""var:v10"" select=""'createobject'"" />
    <xsl:variable name=""var:v11"" select=""string(s1:Group/s1:Id/text())"" />
    <xsl:variable name=""var:v12"" select=""userCSharp:StringConcat(&quot;CN=&quot; , $var:v11)"" />
    <xsl:variable name=""var:v13"" select=""'sAMAccountName'"" />
    <xsl:variable name=""var:v14"" select=""s1:Group/s1:Id"" />
    <xsl:variable name=""var:v15"" select=""'update'"" />
    <ActiveDirectoryUpdate>
      <Directives>
        <xsl:attribute name=""WhereToBind"">
          <xsl:value-of select=""$var:v1"" />
        </xsl:attribute>
        <xsl:attribute name=""SearchScope"">
          <xsl:value-of select=""$var:v2"" />
        </xsl:attribute>
        <xsl:attribute name=""ObjectTypeFilter"">
          <xsl:value-of select=""$var:v3"" />
        </xsl:attribute>
        <xsl:attribute name=""MaxObjects"">
          <xsl:value-of select=""$var:v4"" />
        </xsl:attribute>
      </Directives>
      <Target>
        <xsl:attribute name=""PropertyName"">
          <xsl:value-of select=""$var:v5"" />
        </xsl:attribute>
        <xsl:attribute name=""EqualToValue"">
          <xsl:value-of select=""$var:v6"" />
        </xsl:attribute>
      </Target>
      <Change>
        <xsl:attribute name=""PropertyName"">
          <xsl:value-of select=""$var:v8"" />
        </xsl:attribute>
        <xsl:attribute name=""ChangeToValue"">
          <xsl:value-of select=""$var:v9"" />
        </xsl:attribute>
        <xsl:attribute name=""ChangeType"">
          <xsl:value-of select=""$var:v10"" />
        </xsl:attribute>
      </Change>
      <Change>
        <xsl:attribute name=""PropertyName"">
          <xsl:value-of select=""$var:v13"" />
        </xsl:attribute>
        <xsl:attribute name=""ChangeToValue"">
          <xsl:value-of select=""$var:v14"" />
        </xsl:attribute>
        <xsl:attribute name=""ChangeType"">
          <xsl:value-of select=""$var:v15"" />
        </xsl:attribute>
      </Change>
    </ActiveDirectoryUpdate>
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


public string StringConcat(string param0, string param1)
{
   return param0 + param1;
}



]]></msxsl:script>
</xsl:stylesheet>";
        
        private const int _useXSLTransform = 0;
        
        private const string _strArgList = @"<ExtensionObjects />";
        
        private const string _strSrcSchemasList0 = @"UU.Integrations.Common.Schemas.Internal.InternalGroupEvent";
        
        private const global::UU.Integrations.Common.Schemas.Internal.InternalGroupEvent _srcSchemaTypeReference0 = null;
        
        private const string _strTrgSchemasList0 = @"UU.Integrations.Common.Schemas.ActiveAdapter.ADSendAdapterOneWayUpdate";
        
        private const global::UU.Integrations.Common.Schemas.ActiveAdapter.ADSendAdapterOneWayUpdate _trgSchemaTypeReference0 = null;
        
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
                _TrgSchemas[0] = @"UU.Integrations.Common.Schemas.ActiveAdapter.ADSendAdapterOneWayUpdate";
                return _TrgSchemas;
            }
        }
    }
}
