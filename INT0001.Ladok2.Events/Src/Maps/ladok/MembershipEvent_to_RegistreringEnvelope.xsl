<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var"
                 xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0"
                exclude-result-prefixes="msxsl var s0 userCSharp ScriptNS0" version="1.0" xmlns:ns1="http://schemas.ladok.se/events" xmlns:si="http://schemas.ladok.se/studentinformation"
  xmlns:ui="http://schemas.ladok.se/utbildningsinformation" xmlns:ns0="http://ladok.uu.envelope.schemas" xmlns:base="http://schemas.ladok.se" xmlns:sd="http://schemas.ladok.se/studiedeltagande"
  xmlns:s0="http://schemas.microsoft.com/Sql/2008/05/TypedPolling/ladokevents" xmlns:ns3="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s0:TypedPollingResultSet0" />
  </xsl:template>
  <xsl:template match="/s0:TypedPollingResultSet0">
    <xsl:variable name="startSemester" select="userCSharp:SemesterToDate(string(s0:startSemester/text()))" />
    <ns0:RegistreringEnvelope>
      <sd:RegistreringEvent>
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
        <xsl:if test="s0:program">
          <sd:InomKurspaketeringstillfalle>
            <sd:KurspaketeringUID>
              <xsl:text />
            </sd:KurspaketeringUID>
            <sd:KurspaketeringstillfalleUID>
              <xsl:value-of select="userCSharp:ToGuid(2001)"/>
            </sd:KurspaketeringstillfalleUID>
            <sd:UtbildningstypID>0</sd:UtbildningstypID>
          </sd:InomKurspaketeringstillfalle>
        </xsl:if>
        <sd:KursUID>
          <xsl:text />
        </sd:KursUID>
        <sd:KurstillfalleUID>
          <xsl:value-of select="userCSharp:ToGuid(number(s0:Id/text()))"/>
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
          <xsl:value-of select="userCSharp:ToGuid(1001)"/>
        </sd:UtbildningsinstansUID>
        <sd:Omfattningsvarde>
          <xsl:text>0</xsl:text>
        </sd:Omfattningsvarde>
         <sd:Studieavgiftsbetalning>studiedeltagande.domain.studieavgiftsbetalningsvarde.ej_aktuell</sd:Studieavgiftsbetalning>
        <sd:StudieperiodSlut>
          <xsl:text>2999-01-01</xsl:text>
        </sd:StudieperiodSlut>
        <sd:StudieperiodStart>
          <xsl:value-of select="$startSemester" />
        </sd:StudieperiodStart>
        <sd:ArAnpassad>
          <xsl:text>false</xsl:text>
        </sd:ArAnpassad>
      </sd:RegistreringEvent>
      <xsl:call-template name="Utbildningstillfalle">
        <xsl:with-param name="code" select="s0:reportCode/text()" />
        <xsl:with-param name="startSemester" select="$startSemester" />
        <xsl:with-param name="uid" select="userCSharp:ToGuid(number(s0:Id/text()))"/>
        <xsl:with-param name="instansuid" select="userCSharp:ToGuid(1001)"/>
      </xsl:call-template>
      <xsl:if test="s0:program">
        <xsl:call-template name="Utbildningstillfalle">
          <xsl:with-param name="code">
            <xsl:text>XXXX</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="startSemester" select="$startSemester" />
          <xsl:with-param name="uid" select="userCSharp:ToGuid(2001)"/>
          <xsl:with-param name="instansuid" select="userCSharp:ToGuid(1002)"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="Utbildningsinstans">
        <xsl:with-param name="code" select="s0:courseCode/text()" />
        <xsl:with-param name="uid" select="userCSharp:ToGuid(1001)"/>
      </xsl:call-template>
      <xsl:if test="s0:program">
        <xsl:call-template name="Utbildningsinstans">
          <xsl:with-param name="code" select="s0:program/text()" />
          <xsl:with-param name="uid" select="userCSharp:ToGuid(1002)"/>
        </xsl:call-template>
      </xsl:if>

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
          <xsl:value-of select="normalize-space(substring-after($fullname,','))" />
        </si:Efternamn>
        <si:FelVidEtableringExternt>false</si:FelVidEtableringExternt>
        <si:Fornamn>
          <xsl:value-of select="normalize-space(substring-before($fullname,','))" />
        </si:Fornamn>
        <si:Personnummer>
          <xsl:value-of select="s0:pnr/text()" />
        </si:Personnummer>
      </si:Student>
    </ns0:RegistreringEnvelope>
  </xsl:template>

  <xsl:template name="Utbildningsinstans">
    <xsl:param name="code"/>
    <xsl:param name="uid"/>

    <ui:Utbildningsinstans>
      <base:Uid>
        <xsl:value-of select="$uid"/>
      </base:Uid>
      <ui:UtbildningsmallUID>
        <xsl:text />
      </ui:UtbildningsmallUID>
      <ui:Avvecklad>
        <xsl:text>false</xsl:text>
      </ui:Avvecklad>
      <ui:Utbildningskod>
        <xsl:value-of select="$code" />
      </ui:Utbildningskod>
    </ui:Utbildningsinstans>
  </xsl:template>

  <xsl:template name="Utbildningstillfalle">
    <xsl:param name="startSemester"/>
    <xsl:param name="code"/>
    <xsl:param name="uid"/>
    <xsl:param name="instansuid"/>

    <ui:Utbildningstillfalle>
      <base:Uid>
        <xsl:value-of select="$uid"/>
      </base:Uid>
      <ui:UtbildningsmallUID>
        <xsl:text />
      </ui:UtbildningsmallUID>
      <ui:Installt>
        <xsl:text>false</xsl:text>
      </ui:Installt>
      <ui:Tillfallesperioder>
        <ui:ForstaUndervisningsdatum>
          <xsl:value-of select="$startSemester" />
        </ui:ForstaUndervisningsdatum>
        <ui:Omfattningsvarde>
          <xsl:text>0</xsl:text>
        </ui:Omfattningsvarde>
        <ui:SistaUndervisningsdatum>
          <xsl:text>2999-01-01</xsl:text>
        </ui:SistaUndervisningsdatum>
      </ui:Tillfallesperioder>
      <ui:UtbildningsinstansUID>
        <xsl:value-of select="$instansuid"/>
      </ui:UtbildningsinstansUID>
      <ui:Tillfalleskod>
        <xsl:value-of select="$code" />
      </ui:Tillfalleskod>
    </ui:Utbildningstillfalle>
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
    
   public string ToGuid(UInt64 value)
        {
            byte[] bytes = new byte[16];
            BitConverter.GetBytes(value).CopyTo(bytes, 0);
            return new Guid(bytes).ToString();
        }
        
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
]]>
  </msxsl:script>
</xsl:stylesheet>