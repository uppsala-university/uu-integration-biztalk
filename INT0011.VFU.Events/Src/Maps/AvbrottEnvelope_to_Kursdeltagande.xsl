<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s8 s5 s0 s1 s4 s2 s6 s3 s7 userCSharp ScriptNS0" version="1.0" xmlns:s8="http://UU.Integrations.Common.Schemas" xmlns:ns0="http://INT0011.VFU.Events.Schemas.VFU.Kursdeltagande" xmlns:s5="http://schemas.ladok.se/events" xmlns:s0="http://schemas.ladok.se/studentinformation" xmlns:s1="http://schemas.ladok.se/utbildningsinformation" xmlns:s4="http://ladok.uu.envelope.vfu.schema" xmlns:s2="http://ladok.uu.envelope.schemas" xmlns:s6="http://schemas.ladok.se" xmlns:s3="http://schemas.ladok.se/studiedeltagande" xmlns:s7="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s4:AvbrottEnvelope_VFU" />
  </xsl:template>
  <xsl:template match="/s4:AvbrottEnvelope_VFU">
    <xsl:variable name="UID" select="s2:AvbrottEnvelope/s3:AvbrottEvent/s3:UtbildningUID/text()" />
    <xsl:variable name="utbildningskod" select="s2:AvbrottEnvelope/s1:Utbildningsinstans[s1:UtbildningUID/text()=$UID]/s1:Utbildningskod/text()" />
    <xsl:variable name="UtbildningstillfalleUID" select="s2:AvbrottEnvelope/s3:AvbrottEvent/s3:UtbildningstillfalleUID/text()" />
    <xsl:variable name="tillfalleskod" select="s2:AvbrottEnvelope/s1:Utbildningstillfalle[*[local-name() = 'Uid']/text()=$UtbildningstillfalleUID]/s1:Tillfalleskod/text()" />
    <xsl:variable name="forstaundervisningsdatum">
      <xsl:for-each select="s2:AvbrottEnvelope/s1:Utbildningstillfalle[*[local-name() = 'Uid']/text()=$UtbildningstillfalleUID]/s1:Tillfallesperioder">
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
         <xsl:text>AvbrottEvent</xsl:text>
      </eventname>
      <eventuid>
        <xsl:value-of select="//s5:HandelseUID/text()" />
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
      <xsl:if test="s2:AvbrottEnvelope/s0:Student/s0:Personnummer">
        <pnr>
          <xsl:value-of select="s2:AvbrottEnvelope/s0:Student/s0:Personnummer/text()" />
        </pnr>
      </xsl:if>
      <registered>
        <xsl:text>Studieavbrott</xsl:text>
      </registered>
      <password>
        <xsl:value-of select="ScriptNS0:ReadValue('INT0011.VFU.Events' , 'password')" />
      </password>
    </ns0:Root>
  </xsl:template>
</xsl:stylesheet>