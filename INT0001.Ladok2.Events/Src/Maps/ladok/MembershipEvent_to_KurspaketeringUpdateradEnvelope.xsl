<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" 
                exclude-result-prefixes="msxsl var s0 userCSharp ScriptNS0" version="1.0" xmlns:ns1="http://schemas.ladok.se/events" xmlns:si="http://schemas.ladok.se/studentinformation" 
                xmlns:ui="http://schemas.ladok.se/utbildningsinformation" xmlns:ns0="http://ladok.uu.envelope.schemas" 
  xmlns:sd="http://schemas.ladok.se/studiedeltagande" xmlns:s0="http://schemas.microsoft.com/Sql/2008/05/TypedPolling/ladokevents" xmlns:ns3="http://schemas.ladok.se/dap"
                xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp"
                 xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0"
                xmlns:base="http://schemas.ladok.se"
               >
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s0:TypedPollingResultSet0" />
  </xsl:template>
  <xsl:template match="/s0:TypedPollingResultSet0">
    <xsl:variable name="ProgramDescriptions">
      <xsl:call-template name="CheckReturnText">
        <xsl:with-param name="errorMessage">
          <xsl:value-of select="concat('Program descriptions for  code ',s0:program/text(),' could not be found in Ladok!')"/>
        </xsl:with-param>
        <xsl:with-param name="returnText" select="ScriptNS0:GetProgramDescriptions(s0:program/text())"/>
      </xsl:call-template>
    </xsl:variable>
    <ns0:KurspaketeringUppdateradEnvelope>
      <ui:KurspaketeringUppdateradEvent>
        <ui:Benamningar>
          <base:Benamning>
              <base:Sprakkod>
                 <xsl:text>sv</xsl:text>
              </base:Sprakkod>
            <base:Text>
              <xsl:value-of select="$ProgramDescriptions" />
            </base:Text>
          </base:Benamning>
        </ui:Benamningar>
          <ui:Utbildningskod>
            <xsl:value-of select="s0:program/text()" />
          </ui:Utbildningskod>
      </ui:KurspaketeringUppdateradEvent>
    </ns0:KurspaketeringUppdateradEnvelope>  
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