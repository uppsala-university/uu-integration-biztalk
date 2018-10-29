<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s8 s5 s0 s1 s4 s2 s6 s3 s7 userCSharp ScriptNS0" version="1.0" xmlns:s8="http://UU.Integrations.Common.Schemas" xmlns:ns0="http://INT0011.VFU.Events.Schemas.VFU.Kursdeltagande" xmlns:s5="http://schemas.ladok.se/events" xmlns:s0="http://schemas.ladok.se/studentinformation" xmlns:s1="http://schemas.ladok.se/utbildningsinformation" xmlns:s4="http://ladok.uu.envelope.vfu.schema" xmlns:s2="http://ladok.uu.envelope.schemas" xmlns:s6="http://schemas.ladok.se" xmlns:s3="http://schemas.ladok.se/studiedeltagande" xmlns:s7="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s4:AvbrottBorttagetEnvelope_VFU" />
  </xsl:template>
  <xsl:template match="/s4:AvbrottBorttagetEnvelope_VFU">
    <xsl:variable name="var:v1" select="userCSharp:StringTrimRight(&quot;false&quot;)" />
    <xsl:variable name="var:v2" select="userCSharp:StringTrimRight(&quot;Aktiv&quot;)" />
    <xsl:variable name="var:v3" select="userCSharp:StringTrimRight(&quot;INT0011.VFU.Events&quot;)" />
    <xsl:variable name="var:v4" select="userCSharp:StringTrimRight(&quot;password&quot;)" />
    <ns0:Root>
      <xsl:if test="s2:AvbrottBorttagetEnvelope/s1:Utbildningstillfalle/s1:Tillfalleskod">
        <anmkod>
          <xsl:value-of select="s2:AvbrottBorttagetEnvelope/s1:Utbildningstillfalle/s1:Tillfalleskod/text()" />
        </anmkod>
      </xsl:if>
      <course>
        <xsl:value-of select="Utbildningskod/text()" />
      </course>
      <startdate>
        <xsl:value-of select="s2:AvbrottBorttagetEnvelope/s1:Utbildningstillfalle/s1:Tillfallesperioder/s1:ForstaUndervisningsdatum/text()" />
      </startdate>
      <vilkor>
        <xsl:value-of select="$var:v1" />
      </vilkor>
      <xsl:if test="s2:AvbrottBorttagetEnvelope/s0:Student/s0:Personnummer">
        <pnr>
          <xsl:value-of select="s2:AvbrottBorttagetEnvelope/s0:Student/s0:Personnummer/text()" />
        </pnr>
      </xsl:if>
      <registered>
        <xsl:value-of select="$var:v2" />
      </registered>
      <xsl:variable name="var:v5" select="ScriptNS0:ReadValue(string($var:v3) , string($var:v4))" />
      <password>
        <xsl:value-of select="$var:v5" />
      </password>
    </ns0:Root>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp"><![CDATA[
public string StringTrimRight(string str)
{
	if (str == null)
	{
		return "";
	}
	return str.TrimEnd(null);
}



]]></msxsl:script>
</xsl:stylesheet>