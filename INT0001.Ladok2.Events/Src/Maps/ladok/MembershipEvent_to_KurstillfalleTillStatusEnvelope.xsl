<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" 
                exclude-result-prefixes="msxsl var s0 userCSharp ScriptNS0" version="1.0" xmlns:ns1="http://schemas.ladok.se/events" xmlns:si="http://schemas.ladok.se/studentinformation" 
                xmlns:ui="http://schemas.ladok.se/utbildningsinformation" xmlns:ns0="http://ladok.uu.envelope.schemas" xmlns:ns2="http://schemas.ladok.se"
  xmlns:sd="http://schemas.ladok.se/studiedeltagande" xmlns:s0="http://schemas.microsoft.com/Sql/2008/05/TypedPolling/ladokevents" xmlns:ns3="http://schemas.ladok.se/dap"
                xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp"
                 xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s0:TypedPollingResultSet0" />
  </xsl:template>
  <xsl:template match="/s0:TypedPollingResultSet0">
    <ns0:KurstillfalleTillStatusEnvelope>
      <ui:KurstillfalleTillStatusEvent>
        <ns1:EventContext>
          <ns1:Anvandarnamn>
            <xsl:text>uppdok</xsl:text>
          </ns1:Anvandarnamn>
          <ns1:LarosateID>0</ns1:LarosateID>
        </ns1:EventContext>
          <ns1:HandelseUID>
            <xsl:value-of select="s0:Id/text()" />
          </ns1:HandelseUID>
        <ui:Status>
          <xsl:text>2</xsl:text>
        </ui:Status>
          <ui:Utbildningstillfalleskod>
            <xsl:value-of select="s0:reportCode/text()" />
          </ui:Utbildningstillfalleskod>
        <ui:Kurstillfallesattribut>
          <ui:Finansieringsform>0</ui:Finansieringsform>
        </ui:Kurstillfallesattribut>
        <ui:Kurstillfallesperioder>
          <ui:ForstaUndervisningsdatum>
            <xsl:value-of select="userCSharp:SemesterToDate(string(s0:startSemester/text()))" />
          </ui:ForstaUndervisningsdatum>
          <ui:Omfattningsvarde>0</ui:Omfattningsvarde>
          <ui:SistaUndervisningsdatum>2999-01-01</ui:SistaUndervisningsdatum>
        </ui:Kurstillfallesperioder>
      </ui:KurstillfalleTillStatusEvent>
      <xsl:variable name="CourseDescriptions" select="ScriptNS0:GetCourseDescriptions(s0:courseCode/text())" />
      <ui:Utbildningsinstans>
        <ui:UtbildningsmallUID/>
        <ui:Avvecklad>false</ui:Avvecklad>
        <ui:Benamningar>
            <ns2:Benamning>
              <ns2:Sprakkod>
                <xsl:text>sv</xsl:text>
              </ns2:Sprakkod>
              <ns2:Text>
                <xsl:value-of select="substring-before($CourseDescriptions,'~')" />
              </ns2:Text>
            </ns2:Benamning>
            <ns2:Benamning>
              <ns2:Sprakkod>
                <xsl:text>en</xsl:text>
              </ns2:Sprakkod>
              <ns2:Text>
                <xsl:value-of select="substring-after($CourseDescriptions,'~')" />
              </ns2:Text>
            </ns2:Benamning>
          </ui:Benamningar>
            <ui:Utbildningskod>
              <xsl:value-of select="s0:courseCode/text()"/>
            </ui:Utbildningskod>
      </ui:Utbildningsinstans>
    </ns0:KurstillfalleTillStatusEnvelope>
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