<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var" version="1.0" xmlns:ns4="http://UU.Integrations.Common.Schemas" xmlns:ns1="http://schemas.ladok.se/events" xmlns:si="http://schemas.ladok.se/studentinformation" xmlns:ui="http://schemas.ladok.se/utbildningsinformation" xmlns:ns0="http://ladok.uu.envelope.vfu.schema" xmlns:en="http://ladok.uu.envelope.schemas" xmlns:ns2="http://schemas.ladok.se" xmlns:sd="http://schemas.ladok.se/studiedeltagande" xmlns:ns3="http://schemas.ladok.se/dap">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/en:DelayedUppehallStartEnvelope" />
  </xsl:template>
  <xsl:template match="/en:DelayedUppehallStartEnvelope">
    <ns0:DelayedUppehallStartEnvelope_VFU>
      <en:DelayedUppehallStartEnvelope>
        <sd:UppehallEvent>
          <xsl:copy-of select="sd:UppehallEvent/@*" />
          <xsl:copy-of select="sd:UppehallEvent/*" />
        </sd:UppehallEvent>
        <si:Student>
          <xsl:copy-of select="si:Student/@*" />
          <xsl:copy-of select="si:Student/*" />
        </si:Student>
        <si:Kontaktuppgifter>
          <xsl:copy-of select="si:Kontaktuppgifter/@*" />
          <xsl:copy-of select="si:Kontaktuppgifter/*" />
        </si:Kontaktuppgifter>
      </en:DelayedUppehallStartEnvelope>
      <xsl:variable name="markningsnyckel" select="/en:AterkalladRegistreringEnvelope/ui:Utbildningsinstans/ui:Attributvarden[ui:Varde/text()=/en:AterkalladRegistreringEnvelope/ui:Markningsnycklar/ui:Markningsnyckel[*[local-name() = 'Kod']/text()='VFU']/*[local-name() = 'ID']/text()]/ui:Varde/text()" />

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
    </ns0:DelayedUppehallStartEnvelope_VFU>
  </xsl:template>
</xsl:stylesheet>