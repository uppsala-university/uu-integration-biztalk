<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var" version="1.0" xmlns:ns1="http://schemas.ladok.se/avisering" xmlns:ns6="http://UU.Integrations.Common.Schemas" xmlns:ns2="http://schemas.ladok.se/events" xmlns:ns3="http://schemas.ladok.se/kataloginformation" xmlns:si="http://schemas.ladok.se/studentinformation" xmlns:ui="http://schemas.ladok.se/utbildningsinformation" xmlns:ns0="http://ladok.uu.envelope.vfu.schema" xmlns:en="http://ladok.uu.envelope.schemas" xmlns:ns4="http://schemas.ladok.se" xmlns:sd="http://schemas.ladok.se/studiedeltagande" xmlns:ns5="http://schemas.ladok.se/dap">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/en:KurstillfalleTillStatusEnvelope" />
  </xsl:template>
  <xsl:template match="/en:KurstillfalleTillStatusEnvelope">
    <ns0:KurstillfalleTillStatusEnvelope_VFU>
      <en:KurstillfalleTillStatusEnvelope>
        <xsl:copy-of select="./@*" />
        <xsl:copy-of select="./*" />
        
      </en:KurstillfalleTillStatusEnvelope>
      <xsl:variable name="markningsnyckel" select="/en:KurstillfalleTillStatusEnvelope/ui:Utbildningsinstans/ui:Attributvarden[ui:Varde/text()=/en:KurstillfalleTillStatusEnvelope/ui:Markningsnycklar/ui:Markningsnyckel[*[local-name() = 'Kod']/text()='VFU']/*[local-name() = 'ID']/text()]/ui:Varde/text()" />

      <xsl:variable name="utbildningskod" select="/en:KurstillfalleTillStatusEnvelope/ui:Utbildningsinstans/ui:Utbildningskod/text()" />

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
        <xsl:value-of select="$utbildningskod" />
      </Utbildningskod>
    </ns0:KurstillfalleTillStatusEnvelope_VFU>
  </xsl:template>
</xsl:stylesheet>