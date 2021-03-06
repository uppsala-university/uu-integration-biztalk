<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var" version="1.0" xmlns:ns1="http://schemas.ladok.se/avisering" xmlns:ns6="http://UU.Integrations.Common.Schemas" xmlns:ns2="http://schemas.ladok.se/events" xmlns:ns3="http://schemas.ladok.se/kataloginformation" xmlns:si="http://schemas.ladok.se/studentinformation" xmlns:ui="http://schemas.ladok.se/utbildningsinformation" xmlns:ns0="http://ladok.uu.envelope.vfu.schema" xmlns:en="http://ladok.uu.envelope.schemas" xmlns:ns4="http://schemas.ladok.se" xmlns:sd="http://schemas.ladok.se/studiedeltagande" xmlns:ns5="http://schemas.ladok.se/dap" xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/en:ForvantatDeltagandeSkapadEnvelope" />
  </xsl:template>
  <xsl:template match="/en:ForvantatDeltagandeSkapadEnvelope">
    <ns0:ForvantatDeltagandeSkapadEnvelope_VFU>
      <en:ForvantatDeltagandeSkapadEnvelope>
        <xsl:copy-of select="./@*" />
        <xsl:copy-of select="./*" />  
      </en:ForvantatDeltagandeSkapadEnvelope>

      <!--<xsl:variable name="UtbildningsinstansUID" select="/en:ForvantatDeltagandeSkapadEnvelope/ui:Utbildningstillfalle/ui:UtbildningsinstansUID/text()[1]" />-->
                    
      <xsl:variable name="markningsnyckel" select="/en:ForvantatDeltagandeSkapadEnvelope/ui:Utbildningsinstans/ui:Attributvarden[ui:Varde/text()=/en:ForvantatDeltagandeSkapadEnvelope/ui:Markningsnycklar/ui:Markningsnyckel[*[local-name() = 'Kod']/text()='VFU']/*[local-name() = 'ID']/text()]/ui:Varde/text()" />

      <!--<xsl:variable name="utbildningskod" select="/en:ForvantatDeltagandeSkapadEnvelope/ui:Utbildningsinstans[*[local-name() = 'Uid']=$UtbildningsinstansUID]/ui:Utbildningskod/text()" />-->
      
      <xsl:variable name="utbildningskodprogram">
        <xsl:apply-templates select="/en:ForvantatDeltagandeSkapadEnvelope/ui:Utbildningsinstans[ScriptNS0:ListContainsValue('INT0011.VFU.Events', 'Programtyper', ui:UtbildningstypID/text(), ',')]"/>
      </xsl:variable>
      
      <xsl:variable name="utbildningskodkurstillfalle">
        <xsl:apply-templates select="/en:ForvantatDeltagandeSkapadEnvelope/ui:Utbildningstillfalle[ScriptNS0:ListContainsValue('INT0011.VFU.Events', 'Kurstillfallestyper', ui:UtbildningstypID/text(), ',')]"/>
      </xsl:variable>
      
      

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

          <xsl:when test="$utbildningskodkurstillfalle != ''">

            <xsl:value-of select="$utbildningskodkurstillfalle" />

          </xsl:when>

          <xsl:otherwise>

            <xsl:value-of select="$utbildningskodprogram" />

          </xsl:otherwise>

        </xsl:choose>
      </Utbildningskod>
      
    </ns0:ForvantatDeltagandeSkapadEnvelope_VFU>
  </xsl:template>
 
  <xsl:template match="ui:Utbildningstillfalle">
    <xsl:variable name="UtbildningsinstansUID" select="./ui:UtbildningsinstansUID/text()" />
    <xsl:apply-templates select="/en:ForvantatDeltagandeSkapadEnvelope/ui:Utbildningsinstans[*[local-name() = 'Uid']=$UtbildningsinstansUID]"/>
  </xsl:template>

  <xsl:template match="ui:Utbildningsinstans">
    <xsl:value-of select="./ui:Utbildningskod/text()"/>
  </xsl:template>
  
</xsl:stylesheet>