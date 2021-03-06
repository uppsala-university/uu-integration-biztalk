<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var userCSharp" version="1.0" xmlns:ns1="http://schemas.ladok.se/avisering" xmlns:ns6="http://UU.Integrations.Common.Schemas" xmlns:ns2="http://schemas.ladok.se/events" xmlns:ns3="http://schemas.ladok.se/kataloginformation" xmlns:si="http://schemas.ladok.se/studentinformation" xmlns:ui="http://schemas.ladok.se/utbildningsinformation" xmlns:ns0="http://ladok.uu.envelope.vfu.schema" xmlns:en="http://ladok.uu.envelope.schemas" xmlns:ns4="http://schemas.ladok.se" xmlns:sd="http://schemas.ladok.se/studiedeltagande" xmlns:ns5="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/en:RegistreringEnvelope" />
  </xsl:template>
  <xsl:template match="/en:RegistreringEnvelope">
    <ns0:RegistreringEnvelope_VFU>
      <en:RegistreringEnvelope>
        <xsl:copy-of select="./@*" />
        <xsl:copy-of select="./*" />
      </en:RegistreringEnvelope>
      <xsl:variable name="markningsnyckel" select="/en:RegistreringEnvelope/ui:Utbildningsinstans/ui:Attributvarden[ui:Varde/text()=/en:RegistreringEnvelope/ui:Markningsnycklar/ui:Markningsnyckel[*[local-name() = 'Kod']/text()='VFU']/*[local-name() = 'ID']/text()]/ui:Varde/text()" />

      
      <xsl:variable name="utbildningskodprogram">
        <xsl:apply-templates select="/en:RegistreringEnvelope/ui:Utbildningsinstans[ScriptNS0:ListContainsValue('INT0011.VFU.Events', 'Programtyper', ui:UtbildningstypID/text(), ',')]"/>
      </xsl:variable>
        
      <!--<xsl:variable name="utbildningskodprogram" select="/en:RegistreringEnvelope/ui:Utbildningsinstans[ui:UtbildningUID/text()=/en:RegistreringEnvelope/sd:RegistreringEvent/sd:InomKurspaketeringstillfalle/sd:KurspaketeringUID/text()]/ui:Utbildningskod/text()" />-->

      <xsl:variable name="utbildningskod" select="/en:RegistreringEnvelope/ui:Utbildningsinstans[ui:UtbildningUID/text()=/en:RegistreringEnvelope/sd:RegistreringEvent/sd:KursUID/text()]/ui:Utbildningskod/text()" />

      <Markningsnyckel>
        <xsl:choose>

          <xsl:when test="$markningsnyckel">

            <xsl:value-of select="'VFU'" />

          </xsl:when>

          <xsl:otherwise>

            <xsl:value-of select="'Not VFU'" />

          </xsl:otherwise>

        </xsl:choose>
      </Markningsnyckel>
      <Utbildningskod>
        <xsl:choose>

          <xsl:when test="$utbildningskodprogram != ''">

            <xsl:value-of select="$utbildningskodprogram" />

          </xsl:when>

          <xsl:otherwise>

            <xsl:value-of select="$utbildningskod" />

          </xsl:otherwise>

        </xsl:choose>
      </Utbildningskod>
    </ns0:RegistreringEnvelope_VFU>
  </xsl:template>
  
  <xsl:template match="ui:Utbildningsinstans">
    <xsl:value-of select="./ui:Utbildningskod/text()"/>
  </xsl:template>
</xsl:stylesheet>