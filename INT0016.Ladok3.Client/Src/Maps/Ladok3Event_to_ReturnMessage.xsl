<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s0 s3 s2 s1" version="1.0" xmlns:s3="http://schemas.ladok.se/utbildningsinformation" xmlns:s0="http://schemas.ladok.se/events" xmlns:ns0="http://Shared.Schemas.SdEvents.InternalReturnMessage" xmlns:s2="http://schemas.ladok.se/dap" xmlns:s1="http://schemas.ladok.se" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s3:KurstillfalleTillStatusEvent" />
  </xsl:template>
  <xsl:template match="/s3:KurstillfalleTillStatusEvent">
    <xsl:variable name="var:v2" select="userCSharp:StringConcat(&quot;OK&quot;)" />
    <ns0:InternalReturnMessage>
      <Ack>
        true
      </Ack>
      <AckMessage>
        <xsl:value-of select="$var:v2" />
      </AckMessage>
      <ReturnMessage>
        <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
        <xsl:copy-of select="/s3:KurstillfalleTillStatusEvent"/>
        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
      </ReturnMessage>
    </ns0:InternalReturnMessage>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp">
    <![CDATA[
public string StringConcat(string param0)
{
   return param0;
}



]]>
  </msxsl:script>
</xsl:stylesheet>