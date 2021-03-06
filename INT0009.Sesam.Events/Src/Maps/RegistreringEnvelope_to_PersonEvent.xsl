<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var"
                exclude-result-prefixes="msxsl var s7 s8 s0 s1 s2 s3 s6 s4 s5 s9 userCSharp ScriptNS0" version="1.0"
                xmlns:s7="http://schemas.ladok.se/avisering"
                xmlns:s8="http://schemas.ladok.se/events"
                xmlns:s0="http://UU.Integrations.Common.Schemas"
                xmlns:s1="http://schemas.ladok.se/kataloginformation"
                xmlns:s2="http://schemas.ladok.se/studentinformation"
                xmlns:s3="http://schemas.ladok.se/utbildningsinformation"
                xmlns:s6="http://ladok.uu.envelope.schemas"
                xmlns:s4="http://schemas.ladok.se"
                xmlns:ns0="http://INT0009.Sesam.Events.Schemas.Sesam.PersonEvent"
                xmlns:s5="http://schemas.ladok.se/studiedeltagande"
                xmlns:s9="http://schemas.ladok.se/dap"
                xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp"
                xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s6:RegistreringEnvelope" />
  </xsl:template>
  <xsl:template match="/s6:RegistreringEnvelope">

    <ns0:Root>
      <PersonEvent>

        <Header>
          <xsl:text>R</xsl:text>
        </Header>

        <xsl:if test="s2:Student/s2:Personnummer">
          <Personnummer>
            <xsl:value-of select="s2:Student/s2:Personnummer/text()" />
          </Personnummer>
        </xsl:if>

        <xsl:if test="s2:Student/s2:Efternamn">
          <Efternamn>
            <xsl:value-of select="userCSharp:Truncate(s2:Student/s2:Efternamn/text(), 25)" />
          </Efternamn>
        </xsl:if>

        <xsl:if test="s2:Student/s2:Fornamn">
          <Fornamn>
            <xsl:value-of select="userCSharp:Truncate(s2:Student/s2:Fornamn/text(), 25)" />
          </Fornamn>
        </xsl:if>

        <xsl:if test="s1:Organisation/s1:Organisationskod">
          <Organisationskod>
            <xsl:value-of select="s1:Organisation/s1:Organisationskod/text()" />
          </Organisationskod>
        </xsl:if>

        <xsl:variable name="kod">
          <xsl:apply-templates select="/s6:RegistreringEnvelope/s3:Utbildningsinstans[s4:Uid/text()=/s6:RegistreringEnvelope/s5:RegistreringEvent/s5:UtbildningsinstansUID/text()]"/>
        </xsl:variable>

        <xsl:choose>
          <xsl:when test="string-length($kod) > 6">
            <Kurskod>REMOVE</Kurskod>
          </xsl:when>
          <xsl:otherwise>
            <Kurskod>
              <xsl:apply-templates select="/s6:RegistreringEnvelope/s3:Utbildningsinstans[s4:Uid/text()=/s6:RegistreringEnvelope/s5:RegistreringEvent/s5:UtbildningsinstansUID/text()]"/>
            </Kurskod>
          </xsl:otherwise>
        </xsl:choose>

        <Startdatum>
          <xsl:value-of select="/s6:RegistreringEnvelope/s5:RegistreringEvent/s5:StudieperiodStart/text()" />
        </Startdatum>

        <Slutdatum>
          <xsl:value-of select="/s6:RegistreringEnvelope/s5:RegistreringEvent/s5:StudieperiodSlut/text()" />
        </Slutdatum>

        <StartterminForKurs>
          <xsl:value-of select="userCSharp:GetSemester(/s6:RegistreringEnvelope/s5:RegistreringEvent/s5:StudieperiodStart/text())" />
        </StartterminForKurs>

        <xsl:if test="s5:RegistreringEvent/s5:InomKurspaketeringstillfalle">
          

          <xsl:variable name="programkod">
            <xsl:apply-templates select="/s6:RegistreringEnvelope/s3:Utbildningstillfalle[ScriptNS0:ListContainsValue('INT0009.Sesam.Events', 'Programtillfallestyper', s3:UtbildningstypID/text(), ',')]"/>
          </xsl:variable>

          <xsl:choose>
            <xsl:when test="string-length($programkod) > 5">
              <Programkod>  
              </Programkod>
            </xsl:when>
            <xsl:otherwise>
              <Programkod>
                <xsl:value-of select="$programkod"/>
             </Programkod>
            </xsl:otherwise>
          </xsl:choose>

        </xsl:if>

          
        <Programslut>
          <xsl:value-of select="/s6:RegistreringEnvelope/s5:RegistreringEvent/s5:StudieperiodSlut/text()" />
        </Programslut>

      </PersonEvent>
    </ns0:Root>
  </xsl:template>

  <xsl:template match="s3:Utbildningstillfalle">
    <xsl:variable name="UtbildningsinstansUID" select="./s3:UtbildningsinstansUID/text()" />
    <xsl:apply-templates select="/s6:RegistreringEnvelope/s3:Utbildningsinstans[s4:Uid/text()=$UtbildningsinstansUID]"/>
  </xsl:template>

  <xsl:template match="s3:Utbildningsinstans">
    <xsl:value-of select="./s3:Utbildningskod/text()"/>
  </xsl:template>

  <msxsl:script language="C#" implements-prefix="userCSharp">
    <![CDATA[
    
    public string Truncate(string value, int maxLength )
    {
        try 
        {
          if (string.IsNullOrEmpty(value)) { return ""; }
          return value.Substring(0, Math.Min(value.Length, maxLength));
        }
        catch(Exception)
        {
          return "";
        }
    }
    
    public string GetSemester(string date)
    {
        try 
        {
          string year = date.Substring(0,4);        
          int month = Convert.ToInt32(date.Substring(5,2));
            
          if(month < 7)
            return year + "1";
          else
            return year + "2";                  
        }
        catch(Exception)
        {
          return "";
        }
    }
    

]]>
  </msxsl:script>
</xsl:stylesheet>