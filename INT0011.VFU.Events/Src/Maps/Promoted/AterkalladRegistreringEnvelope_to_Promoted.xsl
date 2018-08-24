<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var userCSharp" version="1.0" xmlns:ns4="http://schemas.ladok.se" xmlns:ns7="http://UU.Integrations.Common.Schemas" xmlns:ns6="http://schemas.ladok.se/studentinformation" xmlns:ns3="http://schemas.ladok.se/utbildningsinformation" xmlns:ns0="http://ladok.uu.envelope.schemas" xmlns:ns2="http://schemas.ladok.se/events" xmlns:ns1="http://schemas.ladok.se/studiedeltagande" xmlns:ns5="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/ns0:AterkalladRegistreringEnvelope" />
  </xsl:template>
  <xsl:template match="/ns0:AterkalladRegistreringEnvelope">
    <xsl:variable name="var:v1" select="userCSharp:StringTrimRight(&quot;VFU&quot;)" />
    <ns0:AterkalladRegistreringEnvelope>
      <ns1:AterkalladregistreringEvent>
        <xsl:copy-of select="ns1:AterkalladregistreringEvent/@*" />
        <xsl:copy-of select="ns1:AterkalladregistreringEvent/*" />
      </ns1:AterkalladregistreringEvent>
      <ns3:Utbildningstillfalle>
        <xsl:copy-of select="ns3:Utbildningstillfalle/@*" />
        <xsl:copy-of select="ns3:Utbildningstillfalle/*" />
      </ns3:Utbildningstillfalle>
      <ns3:Utbildningsinstans>
        <xsl:copy-of select="ns3:Utbildningsinstans/@*" />
        <xsl:copy-of select="ns3:Utbildningsinstans/*" />
      </ns3:Utbildningsinstans>
      <ns6:Student>
        <xsl:copy-of select="ns6:Student/@*" />
        <xsl:copy-of select="ns6:Student/*" />
      </ns6:Student>
      <ns6:Kontaktuppgifter>
        <xsl:copy-of select="ns6:Kontaktuppgifter/@*" />
        <xsl:copy-of select="ns6:Kontaktuppgifter/*" />
      </ns6:Kontaktuppgifter>
      <ns3:Markningsnycklar>
        <xsl:copy-of select="ns3:Markningsnycklar/@*" />
        <xsl:copy-of select="ns3:Markningsnycklar/*" />
      </ns3:Markningsnycklar>
      <ns7:InternalMarkningsvarden>
        <xsl:copy-of select="ns7:InternalMarkningsvarden/@*" />
        <xsl:copy-of select="ns7:InternalMarkningsvarden/*" />
      </ns7:InternalMarkningsvarden>
      <ns0:Lokalmarkning>
        <xsl:value-of select="$var:v1" />
      </ns0:Lokalmarkning>
    </ns0:AterkalladRegistreringEnvelope>
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