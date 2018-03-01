<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" 
                 xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0"
                exclude-result-prefixes="msxsl var s0 userCSharp ScriptNS0" version="1.0" xmlns:ns1="http://schemas.ladok.se/events" xmlns:si="http://schemas.ladok.se/studentinformation" 
  xmlns:ui="http://schemas.ladok.se/utbildningsinformation" xmlns:ns0="http://ladok.uu.envelope.schemas" xmlns:ns2="http://schemas.ladok.se" xmlns:sd="http://schemas.ladok.se/studiedeltagande" 
  xmlns:s0="http://schemas.microsoft.com/Sql/2008/05/TypedPolling/ladokevents" xmlns:ns3="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s0:TypedPollingResultSet0" />
  </xsl:template>
  <xsl:template match="/s0:TypedPollingResultSet0">
    <ns0:OmregistreringEnvelope>
      <sd:OmregistreringEvent>
        <ns1:EventContext>
          <ns1:Anvandarnamn>
            <xsl:text>uppdok</xsl:text>
          </ns1:Anvandarnamn>
           <ns1:LarosateID>
            <xsl:text>0</xsl:text>
          </ns1:LarosateID>
        </ns1:EventContext>
          <ns1:HandelseUID>
            <xsl:value-of select="s0:Id/text()" />
          </ns1:HandelseUID>
        <sd:KursUID>
          <xsl:text />
        </sd:KursUID>
        <sd:KurstillfalleUID>
          <xsl:text />
        </sd:KurstillfalleUID>
        <sd:Period>
          <xsl:text>0</xsl:text>
        </sd:Period>
        <sd:RegistreringUID>
          <xsl:text />
        </sd:RegistreringUID>
        <sd:StudentUID>
          <xsl:text />
        </sd:StudentUID>
        <sd:TillfallesantagningUID>
          <xsl:text />
        </sd:TillfallesantagningUID>
        <sd:UtbildningsinstansUID>
          <xsl:text />
        </sd:UtbildningsinstansUID>
          <sd:Omfattningsvarde>
            <xsl:text>0</xsl:text>
          </sd:Omfattningsvarde>
        <sd:StudieperiodSlut>
          <xsl:text>2999-01-01</xsl:text>
        </sd:StudieperiodSlut>
        <xsl:variable name="var:v1" select="userCSharp:SemesterToDate(string(s0:startSemester/text()))" />
        <sd:StudieperiodStart>
          <xsl:value-of select="$var:v1" />
        </sd:StudieperiodStart>
        <sd:ArAnpassad>
          <xsl:text>false</xsl:text>
        </sd:ArAnpassad>
      </sd:OmregistreringEvent>
      <ui:Utbildningstillfalle>
        <ui:UtbildningsmallUID>
          <xsl:text />
        </ui:UtbildningsmallUID>
        <ui:Installt>
          <xsl:text>false</xsl:text>
        </ui:Installt>
        <ui:Tillfallesperioder>
          <ui:ForstaUndervisningsdatum>
            <xsl:value-of select="userCSharp:SemesterToDate(string(s0:startSemester/text()))" />
          </ui:ForstaUndervisningsdatum>
          <ui:Omfattningsvarde>
            <xsl:text>0</xsl:text>
          </ui:Omfattningsvarde>
          <ui:SistaUndervisningsdatum>
            <xsl:text>2999-01-01</xsl:text>
          </ui:SistaUndervisningsdatum>
        </ui:Tillfallesperioder>
          <ui:Tillfalleskod>
            <xsl:value-of select="s0:reportCode/text()" />
          </ui:Tillfalleskod>
      </ui:Utbildningstillfalle>
      <ui:Utbildningsinstans>
        <ui:UtbildningsmallUID>
          <xsl:text />
        </ui:UtbildningsmallUID>
        <ui:Avvecklad>
          <xsl:text>false</xsl:text>
        </ui:Avvecklad>
          <ui:Utbildningskod>
            <xsl:value-of select="s0:courseCode/text()" />
          </ui:Utbildningskod>
      </ui:Utbildningsinstans>
      <si:Student>
        <xsl:attribute name="xsi:type">
          <xsl:value-of select="'si:Student'" />
        </xsl:attribute>
        <si:Avliden>
          <xsl:text>false</xsl:text>
        </si:Avliden>
        <xsl:variable name="fullname">
          <xsl:call-template name="CheckReturnText">
            <xsl:with-param name="errorMessage" select="concat('Person with pnr ',s0:pnr/text(),' could not be found in Ladok!')"/>
            <xsl:with-param name="returnText" select="ScriptNS0:GetFullname(string(s0:pnr/text()))" />
          </xsl:call-template>
        </xsl:variable>
        <si:Efternamn>
          <xsl:value-of select="substring-after($fullname,',')" />
        </si:Efternamn>
        <si:FelVidEtableringExternt>false</si:FelVidEtableringExternt>
        <si:Fornamn>
          <xsl:value-of select="substring-before($fullname,',')" />
        </si:Fornamn>
          <si:Personnummer>
            <xsl:value-of select="s0:pnr/text()" />
          </si:Personnummer>
      </si:Student>
    </ns0:OmregistreringEnvelope>
  </xsl:template>

  <xsl:template name="CheckReturnText">
    <xsl:param name="returnText" />
    <xsl:param name="errorMessage" />

    <xsl:choose>
      <xsl:when test="not($returnText)">
        <xsl:message terminate="yes">
          <xsl:value-of select="$errorMessage"/>
        </xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$returnText"/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
  
  <msxsl:script language="C#" implements-prefix="userCSharp">
    <![CDATA[
public string SemesterToDate(string semester)
        {
            DateTime calcDate = DateTime.ParseExact(semester, "yyyyM", null);

            //Mån 1 - 6(HT) eller mån 7-12(VT)
            if (calcDate.Month > 1)
            {
                calcDate = new DateTime(calcDate.Year, 7, 1);
            }
            return calcDate.ToString("yyyy-MM-dd");
        }
]]></msxsl:script>
</xsl:stylesheet>