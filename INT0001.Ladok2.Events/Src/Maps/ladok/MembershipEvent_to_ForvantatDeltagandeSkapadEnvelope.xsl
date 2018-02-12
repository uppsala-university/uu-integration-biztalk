<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" 
                exclude-result-prefixes="msxsl var s0 userCSharp ScriptNS0" version="1.0" xmlns:ns1="http://schemas.ladok.se/events" 
  xmlns:si="http://schemas.ladok.se/studentinformation" xmlns:ui="http://schemas.ladok.se/utbildningsinformation" xmlns:ns0="http://ladok.uu.envelope.schemas"
                xmlns:ns2="http://schemas.ladok.se" xmlns:sd="http://schemas.ladok.se/studiedeltagande" 
                xmlns:s0="http://schemas.microsoft.com/Sql/2008/05/TypedPolling/ladokevents" xmlns:ns3="http://schemas.ladok.se/dap" 
                xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                 xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s0:TypedPollingResultSet0" />
  </xsl:template>
  <xsl:template match="/s0:TypedPollingResultSet0">
    <ns0:ForvantatDeltagandeSkapadEnvelope>
      <sd:ForvantatDeltagandeSkapadEvent>
        <ns1:EventContext>
          <ns1:Anvandarnamn>
            <xsl:text>uppdok</xsl:text>
          </ns1:Anvandarnamn>
          <ns1:LarosateID>0</ns1:LarosateID>
        </ns1:EventContext>
          <ns1:HandelseUID>
            <xsl:value-of select="s0:Id/text()" />
          </ns1:HandelseUID>
        <sd:Senaredelmarkering>false</sd:Senaredelmarkering>
        <sd:StudentUID/>
        <sd:TillfallesantagningUID/>
        <sd:UtbildningstillfalleUID/>
      </sd:ForvantatDeltagandeSkapadEvent>
      <ui:Utbildningstillfalle>
        <ui:UtbildningsmallUID/>
        <ui:Installt>false</ui:Installt>
        <ui:Tillfallesperioder>
          <ui:ForstaUndervisningsdatum>
            <xsl:value-of select="userCSharp:SemesterToDate(string(s0:startSemester/text()))" />
          </ui:ForstaUndervisningsdatum>
        <ui:Omfattningsvarde>0</ui:Omfattningsvarde>
        <ui:SistaUndervisningsdatum>2999-01-01</ui:SistaUndervisningsdatum>
        </ui:Tillfallesperioder>
          <ui:Tillfalleskod>
            <xsl:value-of select="s0:reportCode/text()" />
          </ui:Tillfalleskod>
      </ui:Utbildningstillfalle>
      <ui:Utbildningsinstans>
        <ui:UtbildningsmallUID/>
        <ui:Avvecklad>false</ui:Avvecklad>
          <ui:Utbildningskod>
            <xsl:value-of select="s0:courseCode/text()" />
          </ui:Utbildningskod>
      </ui:Utbildningsinstans>
      <si:Student>
        <xsl:attribute name="xsi:type">
          <xsl:value-of select="'si:Student'" />
        </xsl:attribute>
        <si:Avliden>false</si:Avliden>
        <xsl:variable name="fullname" select="ScriptNS0:GetFullname(string(s0:pnr/text()))" />
        <si:Efternamn>
          <xsl:value-of select="substring-before($fullname,',')" />
        </si:Efternamn>
        <si:FelVidEtableringExternt>false</si:FelVidEtableringExternt>
        <si:Fornamn>
          <xsl:value-of select="substring-before($fullname,',')" />
        </si:Fornamn>
          <si:Personnummer>
            <xsl:value-of select="s0:pnr/text()" />
          </si:Personnummer>
      </si:Student>
    </ns0:ForvantatDeltagandeSkapadEnvelope>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp">
    <![CDATA[
public string SemesterToDate(string semester)
{
  return DateTime.ParseExact(semester, "yyyyM", null).ToString("yyyy-MM-dd");
}

]]></msxsl:script>
</xsl:stylesheet>