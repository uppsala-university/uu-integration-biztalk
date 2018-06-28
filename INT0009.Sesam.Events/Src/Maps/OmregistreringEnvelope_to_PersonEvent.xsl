<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s5 s0 s1 s4 s2 s3 s6 userCSharp" version="1.0" xmlns:s5="http://schemas.ladok.se/events" xmlns:s0="http://schemas.ladok.se/studentinformation" xmlns:s1="http://schemas.ladok.se/utbildningsinformation" xmlns:s4="http://ladok.uu.envelope.schemas" xmlns:s2="http://schemas.ladok.se" xmlns:ns0="http://INT0009.Sesam.Events.Schemas.Sesam.PersonEvent" xmlns:s3="http://schemas.ladok.se/studiedeltagande" xmlns:s6="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s4:OmregistreringEnvelope" />
  </xsl:template>
  <xsl:template match="/s4:OmregistreringEnvelope" >

  <ns0:Root>
    <PersonEvent>

      <Header>
        <xsl:text>R</xsl:text>
      </Header>

      <xsl:if test="s0:Student/s0:Personnummer">
        <Personnummer>
          <xsl:value-of select="s0:Student/s0:Personnummer/text()" />
        </Personnummer>
      </xsl:if>

      <xsl:if test="s0:Student/s0:Efternamn">
        <Efternamn>
          <xsl:value-of select="s0:Student/s0:Efternamn/text()" />
        </Efternamn>
      </xsl:if>

      <xsl:if test="s0:Student/s0:Fornamn">
        <Fornamn>
          <xsl:value-of select="s0:Student/s0:Fornamn/text()" />
        </Fornamn>
      </xsl:if>

      <xsl:if test="s2:Organisation/s2:Kod">
        <Organisationskod>
          <xsl:value-of select="s2:Organisation/s2:Kod/text()" />
        </Organisationskod>
      </xsl:if>

      <Kurskod>
        <xsl:apply-templates select="/s4:OmregistreringEnvelope/s1:Utbildningsinstans[s2:Uid/text()=/s4:OmregistreringEnvelope/s3:OmregistreringEvent/s3:UtbildningsinstansUID/text()]"/>
      </Kurskod>

      <Startdatum>
        <xsl:value-of select="/s4:OmregistreringEnvelope/s3:OmregistreringEvent/s3:StudieperiodStart/text()" />
      </Startdatum>

      <Slutdatum>
        <xsl:value-of select="/s4:OmregistreringEnvelope/s3:OmregistreringEvent/s3:StudieperiodSlut/text()" />
      </Slutdatum>

      <StartterminForKurs>
        <xsl:value-of select="userCSharp:GetSemester(/s4:OmregistreringEnvelope/s3:OmregistreringEvent/s3:StudieperiodStart/text())" />
      </StartterminForKurs>

      <xsl:if test="s3:OmregistreringEvent/s3:InomKurspaketeringstillfalle">
        <Programkod>
          <xsl:apply-templates select="/s4:OmregistreringEnvelope/s1:Utbildningstillfalle[s2:Uid/text()=/s4:OmregistreringEnvelope/s3:OmregistreringEvent/s3:InomKurspaketeringstillfalle/s3:KurspaketeringstillfalleUID/text()]"/>
        </Programkod>
      </xsl:if>

      <Programslut>
        <xsl:value-of select="/s4:OmregistreringEnvelope/s3:OmregistreringEvent/s3:StudieperiodSlut/text()" />
      </Programslut>

    </PersonEvent>
  </ns0:Root>
  </xsl:template>


  <xsl:template match="s1:Utbildningstillfalle">
    <xsl:variable name="UtbildningsinstansUID" select="./s1:UtbildningsinstansUID/text()" />
    <xsl:apply-templates select="/s4:OmregistreringEnvelope/s1:Utbildningsinstans[s2:Uid/text()=$UtbildningsinstansUID]"/>
  </xsl:template>


  <xsl:template match="s1:Utbildningsinstans">
    <xsl:value-of select="./s1:Utbildningskod/text()"/>
  </xsl:template>


  <msxsl:script language="C#" implements-prefix="userCSharp">
    <![CDATA[
    
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