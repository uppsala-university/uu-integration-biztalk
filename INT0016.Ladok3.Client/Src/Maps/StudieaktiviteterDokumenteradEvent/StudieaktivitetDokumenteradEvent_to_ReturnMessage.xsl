<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s6 s7 s0 s1 s2 s5 s3 s4 s8" version="1.0" xmlns:s6="http://schemas.ladok.se/avisering" xmlns:s7="http://schemas.ladok.se/events" xmlns:s0="http://schemas.ladok.se/kataloginformation" xmlns:s1="http://schemas.ladok.se/studentinformation" xmlns:s2="http://schemas.ladok.se/utbildningsinformation" xmlns:s5="http://ladok.uu.envelope.schemas" xmlns:ns0="http://Shared.Schemas.SdEvents.InternalReturnMessage" xmlns:s3="http://schemas.ladok.se" xmlns:s4="http://schemas.ladok.se/studiedeltagande" xmlns:s8="http://schemas.ladok.se/dap">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s5:StudieaktivitetDokumenteradEnvelope" />
  </xsl:template>
  <xsl:template match="/s5:StudieaktivitetDokumenteradEnvelope">
    <ns0:InternalReturnMessage>
      <Ack>
        true
      </Ack>
      <AckMessage>
        OK
      </AckMessage>
      <ReturnMessage>
        <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
        <xsl:copy-of select="/s5:StudieaktivitetDokumenteradEnvelope"/>
        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
      </ReturnMessage>
    </ns0:InternalReturnMessage>
  </xsl:template>
</xsl:stylesheet>