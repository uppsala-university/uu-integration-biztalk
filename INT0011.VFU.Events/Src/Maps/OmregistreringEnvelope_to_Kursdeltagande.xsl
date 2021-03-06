<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s5 s10 s6 s7 s0 s1 s4 s2 s8 s3 s9 userCSharp ScriptNS0" version="1.0" xmlns:s5="http://schemas.ladok.se/avisering" xmlns:s10="http://UU.Integrations.Common.Schemas" xmlns:ns0="http://INT0011.VFU.Events.Schemas.VFU.Kursdeltagande" xmlns:s6="http://schemas.ladok.se/events" xmlns:s7="http://schemas.ladok.se/kataloginformation" xmlns:s0="http://schemas.ladok.se/studentinformation" xmlns:s1="http://schemas.ladok.se/utbildningsinformation" xmlns:s4="http://ladok.uu.envelope.vfu.schema" xmlns:s2="http://ladok.uu.envelope.schemas" xmlns:s8="http://schemas.ladok.se" xmlns:s3="http://schemas.ladok.se/studiedeltagande" xmlns:s9="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s4:OmregistreringEnvelope_VFU" />
  </xsl:template>
  <xsl:template match="/s4:OmregistreringEnvelope_VFU">
    <xsl:variable name="UID" select="s2:OmregistreringEnvelope/s3:OmregistreringEvent/s3:UtbildningsinstansUID/text()" />
    <xsl:variable name="KursUID" select="s2:OmregistreringEnvelope/s3:OmregistreringEvent/s3:KursUID/text()" />
    <xsl:variable name="tillfalleskod" select="s2:OmregistreringEnvelope/s1:Utbildningstillfalle[s1:UtbildningsinstansUID/text()=$UID]/s1:Tillfalleskod/text()" />
    <xsl:variable name="utbildningskod" select="s2:OmregistreringEnvelope/s1:Utbildningsinstans[s1:UtbildningUID/text()=$KursUID]/s1:Utbildningskod/text()" />
    <xsl:variable name="forstaundervisningsdatum">
      <xsl:for-each select="s2:OmregistreringEnvelope/s1:Utbildningstillfalle[s1:UtbildningsinstansUID/text()=$UID]/s1:Tillfallesperioder">
        <xsl:sort select="./s1:ForstaUndervisningsdatum/text()"  order="ascending"/>
        <xsl:choose>
          <xsl:when test="position() = 1">
            <xsl:value-of select="./s1:ForstaUndervisningsdatum/text()" />
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
    </xsl:variable>
    
    <ns0:Root>
      <eventname>
         <xsl:text>OmregistreringEvent</xsl:text>
      </eventname>
      <eventuid>
        <xsl:value-of select="//s6:HandelseUID/text()" />
      </eventuid>
      <anmkod>
        <xsl:value-of select="$tillfalleskod" />
      </anmkod>
      <course>
        <xsl:value-of select="$utbildningskod" />
      </course>
      <startdate>
        <xsl:value-of select="$forstaundervisningsdatum" />
      </startdate>
      <vilkor>
        <xsl:text>false</xsl:text>
      </vilkor>
      <xsl:if test="s2:OmregistreringEnvelope/s0:Student/s0:Personnummer">
        <pnr>
          <xsl:value-of select="s2:OmregistreringEnvelope/s0:Student/s0:Personnummer/text()" />
        </pnr>
      </xsl:if>
      <registered>
        <xsl:text>reregistered</xsl:text>
      </registered>
      <password>
        <xsl:value-of select="ScriptNS0:ReadValue('INT0011.VFU.Events' , 'password')" />
      </password>
    </ns0:Root>
  </xsl:template>
</xsl:stylesheet>