namespace INT0004.AKKA.Identity.Maps {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"INT0004.AKKA.Identity.Schemas.PersonEvents.InternalPersonEvent", typeof(global::INT0004.AKKA.Identity.Schemas.PersonEvents.InternalPersonEvent))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"INT0004.AKKA.Identity.Schemas.cxf_akkaappl_akka_its_uu_se+etableraEjAktiveratStudentkontoMedNamn", typeof(global::INT0004.AKKA.Identity.Schemas.cxf_akkaappl_akka_its_uu_se.etableraEjAktiveratStudentkontoMedNamn))]
    public sealed class InternalPersonEvent_To_AkkaStudentAccount : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s0 s1 userCSharp ScriptNS0"" version=""1.0"" xmlns:ns0=""http://call.authsrv.its.uu.se/"" xmlns:s1=""http://UU.Integrations.Common.Schemas.InternalPersonEvent"" xmlns:ns1=""http://cxf.akkaappl.akka.its.uu.se/"" xmlns:s0=""http://UU.Integrations.Common.Schemas.Internal.Person"" xmlns:userCSharp=""http://schemas.microsoft.com/BizTalk/2003/userCSharp"" xmlns:ScriptNS0=""http://schemas.microsoft.com/BizTalk/2003/ScriptNS0"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s1:PersonEvent"" />
  </xsl:template>
  <xsl:template match=""/s1:PersonEvent"">
    <xsl:variable name=""var:v1"" select=""userCSharp:StringTrimRight(&quot;ESB&quot;)"" />
    <ns1:etableraEjAktiveratStudentkontoMedNamn>
      <applikation>
        <xsl:value-of select=""$var:v1"" />
      </applikation>
      <pnr>
        <xsl:value-of select=""s0:Person/s0:PersonNumber/text()"" />
      </pnr>
      <xsl:variable name=""var:v2"" select=""ScriptNS0:GetFullname(string(s0:Person/s0:PersonNumber/text()))"" />
      <xsl:call-template name=""AddNamn"">
        <xsl:with-param name=""fullname"" select=""string($var:v2)"" />
      </xsl:call-template>
    </ns1:etableraEjAktiveratStudentkontoMedNamn>
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
  <xsl:template name=""AddNamn"">
<xsl:param name=""fullname"" />
  
  <fornamn>
    <xsl:value-of select=""substring-before($fullname,',')"" />
</fornamn>
<efternamn>
  <xsl:value-of select=""substring-after($fullname,',')"" />
</efternamn>

</xsl:template>
</xsl:stylesheet>";
        
        private const int _useXSLTransform = 0;
        
        private const string _strArgList = @"<ExtensionObjects>
  <ExtensionObject Namespace=""http://schemas.microsoft.com/BizTalk/2003/ScriptNS0"" AssemblyName=""Shared.Utilities.MySQLClientHelper, Version=1.0.0.0, Culture=neutral, PublicKeyToken=b64e3957dd28061a"" ClassName=""Shared.Utilities.MySQLClientHelper.MySQLConnect"" />
</ExtensionObjects>";
        
        private const string _strSrcSchemasList0 = @"INT0004.AKKA.Identity.Schemas.PersonEvents.InternalPersonEvent";
        
        private const global::INT0004.AKKA.Identity.Schemas.PersonEvents.InternalPersonEvent _srcSchemaTypeReference0 = null;
        
        private const string _strTrgSchemasList0 = @"INT0004.AKKA.Identity.Schemas.cxf_akkaappl_akka_its_uu_se+etableraEjAktiveratStudentkontoMedNamn";
        
        private const global::INT0004.AKKA.Identity.Schemas.cxf_akkaappl_akka_its_uu_se.etableraEjAktiveratStudentkontoMedNamn _trgSchemaTypeReference0 = null;
        
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
                _SrcSchemas[0] = @"INT0004.AKKA.Identity.Schemas.PersonEvents.InternalPersonEvent";
                return _SrcSchemas;
            }
        }
        
        public override string[] TargetSchemas {
            get {
                string[] _TrgSchemas = new string [1];
                _TrgSchemas[0] = @"INT0004.AKKA.Identity.Schemas.cxf_akkaappl_akka_its_uu_se+etableraEjAktiveratStudentkontoMedNamn";
                return _TrgSchemas;
            }
        }
    }
}
