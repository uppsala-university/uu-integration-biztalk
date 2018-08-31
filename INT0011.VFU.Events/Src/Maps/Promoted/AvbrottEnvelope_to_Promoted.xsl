<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var" version="1.0" xmlns:ns4="http://UU.Integrations.Common.Schemas" xmlns:ns1="http://schemas.ladok.se/events" xmlns:si="http://schemas.ladok.se/studentinformation" xmlns:ui="http://schemas.ladok.se/utbildningsinformation" xmlns:ns0="http://ladok.uu.envelope.vfu.schema" xmlns:en="http://ladok.uu.envelope.schemas" xmlns:ns2="http://schemas.ladok.se" xmlns:sd="http://schemas.ladok.se/studiedeltagande" xmlns:ns3="http://schemas.ladok.se/dap">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/en:AvbrottEnvelope" />
  </xsl:template>
  <xsl:template match="/en:AvbrottEnvelope">
    <ns0:AvbrottEnvelope_VFU>
      <en:AvbrottEnvelope>
        <sd:AvbrottEvent>
          <xsl:copy-of select="sd:AvbrottEvent/@*" />
          <xsl:copy-of select="sd:AvbrottEvent/*" />
        </sd:AvbrottEvent>
        <xsl:variable name="programinriktning" select="/en:AvbrottEnvelope/ui:Utbildningsinstans[ui:UtbildningUID/text()=/en:AvbrottEnvelope/sd:AvbrottEvent/sd:InomKurspaketeringstillfalle/sd:KurspaketeringUID/text()]/ui:Utbildningskod/text()" />

        <xsl:variable name="tillfalleskod" select="/en:AvbrottEnvelope/ui:Utbildningstillfalle[ui:UtbildningsinstansUID/text()=/en:AvbrottEnvelope/sd:AvbrottEvent/sd:UtbildningsinstansUID/text()]/ui:Tillfalleskod/text()" />

        <xsl:variable name="forstaundervisningsdatum">

          <xsl:for-each select="/en:RegistreringEnvelope/ui:Utbildningstillfalle[ui:UtbildningsinstansUID/text()=/en:RegistreringEnvelope/sd:RegistreringEvent/sd:UtbildningsinstansUID/text()]/ui:Tillfallesperioder">

            <xsl:sort select="./ui:ForstaUndervisningsdatum/text()"  order="ascending"/>

            <xsl:choose>

              <xsl:when test="position() = 1">

                <xsl:value-of select="./ui:ForstaUndervisningsdatum/text()" />

              </xsl:when>

            </xsl:choose>

          </xsl:for-each>

        </xsl:variable>

        -       <ui:Utbildningstillfalle>
          -<ui:Tillfallesperioder>
            <ui:ForstaUndervisningsdatum>
              <xsl:value-of select="$forstaundervisningsdatum"/>
            </ui:ForstaUndervisningsdatum>
          </ui:Tillfallesperioder>
          -<ui:Tillfalleskod>
            <xsl:value-of select="$tillfalleskod"/>
          </ui:Tillfalleskod>
        </ui:Utbildningstillfalle>
        -<ui:Utbildningsinstans>
          -<ui:Utbildningskod>
            <xsl:value-of select="$programinriktning"/>
          </ui:Utbildningskod>
        </ui:Utbildningsinstans>
        <si:Student>
          <xsl:copy-of select="si:Student/@*" />
          <xsl:copy-of select="si:Student/*" />
        </si:Student>
        <si:Kontaktuppgifter>
          <xsl:copy-of select="si:Kontaktuppgifter/@*" />
          <xsl:copy-of select="si:Kontaktuppgifter/*" />
        </si:Kontaktuppgifter>
      </en:AvbrottEnvelope>
      <xsl:variable name="markningsnyckel" select="/en:AvbrottEnvelope/ui:Utbildningsinstans/ui:Attributvarden[ui:Varde/text()=/en:AvbrottEnvelope/ui:Markningsnycklar/ui:Markningsnyckel[*[local-name() = 'Kod']/text()='VFU']/*[local-name() = 'ID']/text()]/ui:Varde/text()" />

      <xsl:variable name="utbildningskod" select="/en:AvbrottEnvelope/ui:Utbildningsinstans[ui:UtbildningUID/text()=/en:AvbrottEnvelope/sd:AvbrottEvent/sd:KursUID/text()]/ui:Utbildningskod/text()" />

      <Markningsnyckel>
        <xsl:choose>

          <xsl:when test="$markningsnyckel">

            <xsl:value-of select="'VFU'" />

          </xsl:when>

          <xsl:otherwise>

            <xsl:value-of select="''" />

          </xsl:otherwise>

        </xsl:choose>
      </Markningsnyckel>
      <Utbildningskod>
        <xsl:value-of select="$utbildningskod" />
      </Utbildningskod>
    </ns0:AvbrottEnvelope_VFU>
  </xsl:template>
</xsl:stylesheet>