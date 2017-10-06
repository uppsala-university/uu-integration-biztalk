namespace INT0003.AD.Distribution {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.GroupEvents.InternalGroupEvent", typeof(global::Shared.Schemas.GroupEvents.InternalGroupEvent))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.GroupEvents.ADNewIndividual", typeof(global::Shared.Schemas.GroupEvents.ADNewIndividual))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.ADEvents.ADSendAdapterOneWayUpdate", typeof(global::Shared.Schemas.ADEvents.ADSendAdapterOneWayUpdate))]
    public sealed class InternalGroupEvent_to_ADSendAdapterOneWayUpdate : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s0 s2 s3 s1 s4 userCSharp"" version=""1.0"" xmlns:s0=""http://UU.Integrations.Common.ADChange.NewIndividual"" xmlns:s2=""http://schemas.microsoft.com/BizTalk/2003/aggschema"" xmlns:s3=""http://UU.Integrations.Common.Schemas.Internal.Identity"" xmlns:s1=""http://UU.Integrations.Common.Schemas.InternalGroupEvent"" xmlns:s4=""http://UU.Integrations.Common.Schemas.Internal.Group"" xmlns:userCSharp=""http://schemas.microsoft.com/BizTalk/2003/userCSharp"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s2:Root"" />
  </xsl:template>
  <xsl:template match=""/s2:Root"">
    <xsl:variable name=""var:v1"" select=""userCSharp:StringTrimLeft(&quot;LDAP://exchange-test.its.uu.se:389/OU=Courses,OU=Student,OU=Akka,DC=exchange-test,DC=its,DC=uu,DC=se&quot;)"" />
    <xsl:variable name=""var:v2"" select=""userCSharp:StringTrimRight(&quot;onelevel&quot;)"" />
    <xsl:variable name=""var:v3"" select=""userCSharp:StringTrimRight(&quot;(objectclass=group)&quot;)"" />
    <xsl:variable name=""var:v4"" select=""userCSharp:StringTrimRight(&quot;1&quot;)"" />
    <xsl:variable name=""var:v5"" select=""userCSharp:StringTrimRight(&quot;cn&quot;)"" />
    <xsl:variable name=""var:v7"" select=""userCSharp:StringConcat(&quot;LDAP://exchange-test.its.uu.se:389/CN=&quot; , string(InputMessagePart_1/s0:ADNewIndividual/cn/text()) , &quot;,OU=Users,OU=Student,OU=Akka,DC=exchange-test,DC=its,DC=uu,DC=se&quot;)"" />
    <xsl:variable name=""var:v8"" select=""userCSharp:StringTrimRight(&quot;invoke&quot;)"" />
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
      </Target>
      <Change>
        <xsl:variable name=""var:v6"" select=""userCSharp:SetPropertyNamet(string(InputMessagePart_0/s1:GroupEvent/@type))"" />
        <xsl:attribute name=""PropertyName"">
          <xsl:value-of select=""$var:v6"" />
        </xsl:attribute>
        <xsl:attribute name=""ChangeToValue"">
          <xsl:value-of select=""$var:v7"" />
        </xsl:attribute>
        <xsl:attribute name=""ChangeType"">
          <xsl:value-of select=""$var:v8"" />
        </xsl:attribute>
      </Change>
    </ActiveDirectoryUpdate>
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


public string SetPropertyNamet(string type)
{
    if(type == ""GroupMembershipCreateRequestEvent"")
        return ""Add"";
    else if (type == ""GroupMembershipDeleteRequestEvent"")
        return ""Remove"";
    else
        return """";
}

public string StringConcat(string param0, string param1, string param2)
{
   return param0 + param1 + param2;
}


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
        
        private const string _strSrcSchemasList0 = @"Shared.Schemas.GroupEvents.InternalGroupEvent";
        
        private const global::Shared.Schemas.GroupEvents.InternalGroupEvent _srcSchemaTypeReference0 = null;
        
        private const string _strSrcSchemasList1 = @"Shared.Schemas.GroupEvents.ADNewIndividual";
        
        private const global::Shared.Schemas.GroupEvents.ADNewIndividual _srcSchemaTypeReference1 = null;
        
        private const string _strTrgSchemasList0 = @"Shared.Schemas.ADEvents.ADSendAdapterOneWayUpdate";
        
        private const global::Shared.Schemas.ADEvents.ADSendAdapterOneWayUpdate _trgSchemaTypeReference0 = null;
        
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
                string[] _SrcSchemas = new string [2];
                _SrcSchemas[0] = @"Shared.Schemas.GroupEvents.InternalGroupEvent";
                _SrcSchemas[1] = @"Shared.Schemas.GroupEvents.ADNewIndividual";
                return _SrcSchemas;
            }
        }
        
        public override string[] TargetSchemas {
            get {
                string[] _TrgSchemas = new string [1];
                _TrgSchemas[0] = @"Shared.Schemas.ADEvents.ADSendAdapterOneWayUpdate";
                return _TrgSchemas;
            }
        }
    }
}
