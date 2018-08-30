<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var userCSharp" version="1.0" xmlns:ns1="http://schemas.ladok.se/avisering" xmlns:ns6="http://UU.Integrations.Common.Schemas" xmlns:ns2="http://schemas.ladok.se/events" xmlns:ns3="http://schemas.ladok.se/kataloginformation" xmlns:si="http://schemas.ladok.se/studentinformation" xmlns:ui="http://schemas.ladok.se/utbildningsinformation" xmlns:ns0="http://ladok.uu.envelope.vfu.schema" xmlns:en="http://ladok.uu.envelope.schemas" xmlns:ns4="http://schemas.ladok.se" xmlns:sd="http://schemas.ladok.se/studiedeltagande" xmlns:ns5="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/en:RegistreringEnvelope" />
  </xsl:template>
  <xsl:template match="/en:RegistreringEnvelope">
    <ns0:RegistreringEnvelope_VFU>
      <en:RegistreringEnvelope>
        <sd:RegistreringEvent>
          <xsl:copy-of select="sd:RegistreringEvent/@*" />
          <xsl:copy-of select="sd:RegistreringEvent/*" />
        </sd:RegistreringEvent>
        <xsl:for-each select="ui:Utbildningstillfalle">
          <ui:Utbildningstillfalle>
            <xsl:copy-of select="ui:Utbildningstillfalle/@*" />
            <xsl:copy-of select="ui:Utbildningstillfalle/*" />
          </ui:Utbildningstillfalle>
        </xsl:for-each>
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
        <ns3:Organisation>
          <xsl:copy-of select="ns3:Organisation/@*" />
          <xsl:copy-of select="ns3:Organisation/*" />
        </ns3:Organisation>
        <ui:Markningsnycklar>
          <xsl:copy-of select="ui:Markningsnycklar/@*" />
          <xsl:copy-of select="ui:Markningsnycklar/*" />
        </ui:Markningsnycklar>
        <ns6:InternalMarkningsvarden>
          <xsl:copy-of select="ns6:InternalMarkningsvarden/@*" />
          <xsl:copy-of select="ns6:InternalMarkningsvarden/*" />
        </ns6:InternalMarkningsvarden>
        <ui:Finansieringsformer>
          <xsl:copy-of select="ui:Finansieringsformer/@*" />
          <xsl:copy-of select="ui:Finansieringsformer/*" />
        </ui:Finansieringsformer>
        <ui:Studietakter>
          <xsl:copy-of select="ui:Studietakter/@*" />
          <xsl:copy-of select="ui:Studietakter/*" />
        </ui:Studietakter>
        <ns3:Studielokaliseringar>
          <xsl:copy-of select="ns3:Studielokaliseringar/@*" />
          <xsl:copy-of select="ns3:Studielokaliseringar/*" />
        </ns3:Studielokaliseringar>
      </en:RegistreringEnvelope>
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
    </ns0:RegistreringEnvelope_VFU>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp"><![CDATA[
public string StringTrimRight(string str)
{
	if (str == null)
	{
		return "";
	}
	return str.TrimEnd(null);
}



]]></msxsl:script>
</xsl:stylesheet>