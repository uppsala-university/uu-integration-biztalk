<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var userCSharp" version="1.0" xmlns:ns4="http://UU.Integrations.Common.Schemas" xmlns:ns1="http://schemas.ladok.se/events" xmlns:si="http://schemas.ladok.se/studentinformation" xmlns:ui="http://schemas.ladok.se/utbildningsinformation" xmlns:ns0="http://ladok.uu.envelope.vfu.schema" xmlns:en="http://ladok.uu.envelope.schemas" xmlns:ns2="http://schemas.ladok.se" xmlns:sd="http://schemas.ladok.se/studiedeltagande" xmlns:ns3="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/en:AterkalladRegistreringEnvelope" />
  </xsl:template>
  <xsl:template match="/en:AterkalladRegistreringEnvelope">
    <ns0:AterkalladRegistreringEnvelope_VFU>
      <en:AterkalladRegistreringEnvelope>
        <sd:AterkalladregistreringEvent>
          <xsl:copy-of select="sd:AterkalladregistreringEvent/@*" />
          <xsl:copy-of select="sd:AterkalladregistreringEvent/*" />
        </sd:AterkalladregistreringEvent>
        <ui:Utbildningstillfalle>
          <xsl:copy-of select="ui:Utbildningstillfalle/@*" />
          <xsl:copy-of select="ui:Utbildningstillfalle/*" />
        </ui:Utbildningstillfalle>
        <ui:Utbildningsinstans>
          <xsl:copy-of select="ui:Utbildningsinstans/@*" />
          <xsl:copy-of select="ui:Utbildningsinstans/*" />
        </ui:Utbildningsinstans>
        <si:Student>
          <xsl:copy-of select="si:Student/@*" />
          <xsl:copy-of select="si:Student/*" />
        </si:Student>
        <si:Kontaktuppgifter>
          <xsl:copy-of select="si:Kontaktuppgifter/@*" />
          <xsl:copy-of select="si:Kontaktuppgifter/*" />
        </si:Kontaktuppgifter>
        <ui:Markningsnycklar>
          <xsl:copy-of select="ui:Markningsnycklar/@*" />
          <xsl:copy-of select="ui:Markningsnycklar/*" />
        </ui:Markningsnycklar>
        <ns4:InternalMarkningsvarden>
          <xsl:copy-of select="ns4:InternalMarkningsvarden/@*" />
          <xsl:copy-of select="ns4:InternalMarkningsvarden/*" />
        </ns4:InternalMarkningsvarden>
      </en:AterkalladRegistreringEnvelope>

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
      
    </ns0:AterkalladRegistreringEnvelope_VFU>
  </xsl:template>
</xsl:stylesheet>