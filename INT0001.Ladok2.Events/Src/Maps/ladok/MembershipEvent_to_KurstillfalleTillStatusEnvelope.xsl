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
        <xsl:call-template name="AddTerms">
          <xsl:with-param name="terms">
           <xsl:value-of select="ScriptNS0:GetSemesters(s0:startSemester/text(),s0:reportCode/text())" />
            <!--<xsl:text>20142~20151~20152~</xsl:text>-->
        </xsl:with-param>
        </xsl:call-template>
      </ui:KurstillfalleTillStatusEvent>
      <!-- <xsl:text>Fördjupningskurs inom intensivvård för intensivvårdssjuksköterskor ke= Postgraduate Course in Intensive Care Medicine is= Institutionen för kirurgiska vetenskaper ie= Department of Surgical Sciences in= 4630</xsl:text>-->
      <xsl:variable name="CourseDescriptions">
        <xsl:call-template name="CheckReturnText">
          <xsl:with-param name="errorMessage">
            <xsl:value-of select="concat('Course descriptions for course code ',s0:courseCode/text(),' could not be found in Ladok!')"/>
          </xsl:with-param>
          <xsl:with-param name="returnText" select="ScriptNS0:GetCourseDescriptions(s0:courseCode/text())"/>
        </xsl:call-template>
      </xsl:variable>
      
        <ui:Utbildningsinstans>
        <ui:UtbildningsmallUID/>
        <ui:Avvecklad>false</ui:Avvecklad>
        <ui:Benamningar>
            <base:Benamning>
              <base:Sprakkod>
                <xsl:text>sv</xsl:text>
              </base:Sprakkod>
              <base:Text>
                <xsl:value-of select="substring-before($CourseDescriptions,' ke= ')" />
              </base:Text>
            </base:Benamning>
          <base:Benamning>
            <base:Sprakkod>
                <xsl:text>en</xsl:text>
              </base:Sprakkod>
            <base:Text>
                <xsl:value-of select="substring-before(substring-after($CourseDescriptions,' ke= '),' is= ')" />
              </base:Text>
            </base:Benamning>
          </ui:Benamningar>
            <ui:Utbildningskod>
              <xsl:value-of select="s0:courseCode/text()"/>
            </ui:Utbildningskod>
      </ui:Utbildningsinstans>
      <base:Organisation>
        <base:Benamningar>
          <base:Benamning>
            <base:Sprakkod>
              <xsl:text>sv</xsl:text>
            </base:Sprakkod>
            <base:Text>
              <xsl:value-of select="substring-before(substring-after($CourseDescriptions,' is= '),' ie= ')" />
            </base:Text>
          </base:Benamning>
          <base:Benamning>
            <base:Sprakkod>
              <xsl:text>en</xsl:text>
            </base:Sprakkod>
            <base:Text>
              <xsl:value-of select="substring-before(substring-after($CourseDescriptions,' ie= '),' in= ')" />
            </base:Text>
          </base:Benamning>
        </base:Benamningar>
        <base:Kod>
          <xsl:value-of select="substring-after($CourseDescriptions,' in= ')" />
        </base:Kod>
      </base:Organisation>
    </ns0:KurstillfalleTillStatusEnvelope>
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

  <xsl:template name="AddTerms">
    <xsl:param name="terms"/>
    <!--20142~20151~20152~-->
     <ui:Kurstillfallesperioder>
          <ui:ForstaUndervisningsdatum>
           <xsl:value-of select="userCSharp:SemesterToDate(substring-before($terms,'~'))"/>
          </ui:ForstaUndervisningsdatum>
          <ui:Omfattningsvarde>0</ui:Omfattningsvarde>
          <ui:SistaUndervisningsdatum>2999-01-01</ui:SistaUndervisningsdatum>
        </ui:Kurstillfallesperioder>
    <xsl:if test="substring-after($terms,'~')">
      <xsl:call-template name="AddTerms">
        <xsl:with-param name="terms" select="substring-after($terms,'~')"/>
      </xsl:call-template>
    </xsl:if>
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