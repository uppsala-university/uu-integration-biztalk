namespace INT0003.AD.Distribution.Maps {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.GroupEvents.InternalGroupEvent", typeof(global::Shared.Schemas.GroupEvents.InternalGroupEvent))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.ADEvents.ADSendAdapterOneWayUpdate", typeof(global::Shared.Schemas.ADEvents.ADSendAdapterOneWayUpdate))]
    public sealed class InternalGroupEvent_to_ADAddIndividualToGroup : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s2 s1 s0 userCSharp"" version=""1.0"" xmlns:s2=""http://UU.Integrations.Common.Schemas.InternalGroupEvent"" xmlns:ns0=""http://UU.Integrations.Common.Schemas.ADSendAdapterOneWayUpdate"" xmlns:s1=""http://UU.Integrations.Common.Schemas.Internal.Group"" xmlns:s0=""http://UU.Integrations.Common.Schemas.Internal.Identity"" xmlns:userCSharp=""http://schemas.microsoft.com/BizTalk/2003/userCSharp"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:param name=""groupSuffix"" select=""'accepted'""/>
  <xsl:param name=""URI"" select=""'exchange-test.its.uu.se:389'""/>
  <xsl:param name=""path""  select=""'OU EQ Users,OU EQ Student,OU EQ Akka,DC EQ exchange-test,DC EQ its,DC EQ uu,DC EQ se'""/>
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s2:GroupEvent"" />
  </xsl:template>
  <xsl:template match=""/s2:GroupEvent"">
    <ns0:ActiveDirectoryUpdate>
      <ns0:Directives>
        <xsl:attribute name=""WhereToBind"">
          <xsl:text>Configured in send port</xsl:text>
        </xsl:attribute>
        <xsl:attribute name=""SearchScope"">
          <xsl:text>onelevel</xsl:text>
        </xsl:attribute>
        <xsl:attribute name=""ObjectTypeFilter"">
          <xsl:text>(objectclass=group)</xsl:text>
        </xsl:attribute>
        <xsl:attribute name=""MaxObjects"">
          <xsl:text>1</xsl:text>
        </xsl:attribute>
      </ns0:Directives>
      <ns0:Target>
        <xsl:attribute name=""PropertyName"">
          <xsl:text>cn</xsl:text>
        </xsl:attribute>
        <xsl:attribute name=""EqualToValue"">
          <xsl:value-of select=""concat(s1:Group/s1:Id/text(), '_' , $groupSuffix)"" />
        </xsl:attribute>
      </ns0:Target>
      <ns0:Change>
        <xsl:attribute name=""PropertyName"">

          <xsl:choose>
            <xsl:when test=""@type='GroupMembershipCreateRequestEvent'"">
              <xsl:text>Add</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>Remove</xsl:text>
            </xsl:otherwise>
          </xsl:choose>

        </xsl:attribute>
        <xsl:attribute name=""ChangeToValue"">
           <xsl:value-of select=""concat('LDAP://', userCSharp:ReplacePlaceholders($URI), '/cn=', string(/*[local-name()='GroupEvent' and namespace-uri()='http://UU.Integrations.Common.Schemas.InternalGroupEvent']/*[local-name()='GroupEventData' and namespace-uri()='http://UU.Integrations.Common.Schemas.InternalGroupEvent']/*[local-name()='NewMember' and namespace-uri()='http://UU.Integrations.Common.Schemas.Internal.Identity']/@*[local-name()='identifier' and namespace-uri()='']), ',', userCSharp:ReplacePlaceholders($path))"" />
        </xsl:attribute>
        <xsl:attribute name=""ChangeType"">
          <xsl:text>invoke</xsl:text>
        </xsl:attribute>
      </ns0:Change>
    </ns0:ActiveDirectoryUpdate>
  </xsl:template>
  <msxsl:script language=""C#"" implements-prefix=""userCSharp"">
  <![CDATA[

public string ReplacePlaceholders(string input)
        {
            string output = input.Replace("" EQ "", ""="");
            output = output.Replace("" NE "", ""!="");
            output = output.Replace("" NQ "", "">="");
            return output.Replace("" LE "", ""<="");
        }



]]></msxsl:script>
</xsl:stylesheet>";
        
        private const int _useXSLTransform = 0;
        
        private const string _strArgList = @"<ExtensionObjects />";
        
        private const string _strSrcSchemasList0 = @"Shared.Schemas.GroupEvents.InternalGroupEvent";
        
        private const global::Shared.Schemas.GroupEvents.InternalGroupEvent _srcSchemaTypeReference0 = null;
        
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
                string[] _SrcSchemas = new string [1];
                _SrcSchemas[0] = @"Shared.Schemas.GroupEvents.InternalGroupEvent";
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
