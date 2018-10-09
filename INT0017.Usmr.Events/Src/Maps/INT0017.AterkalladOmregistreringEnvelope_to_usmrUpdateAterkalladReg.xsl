<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s6 s0 s1 s2 s4 s5 s3 s7 userCSharp" version="1.0" xmlns:s6="http://schemas.ladok.se" xmlns:ns0="http://schemas.microsoft.com/Sql/2008/05/Procedures/dbo" xmlns:s0="http://UU.Integrations.Common.Schemas" xmlns:s1="http://schemas.ladok.se/studentinformation" xmlns:s2="http://schemas.ladok.se/utbildningsinformation" xmlns:s4="http://ladok.uu.envelope.schemas" xmlns:ns3="http://schemas.datacontract.org/2004/07/System.Data" xmlns:s5="http://schemas.ladok.se/events" xmlns:s3="http://schemas.ladok.se/studiedeltagande" xmlns:s7="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s4:AterkalladOmregistreringEnvelope" />
  </xsl:template>
  <xsl:template match="/s4:AterkalladOmregistreringEnvelope">
    <ns0:uusmrUpdateAterkalladRegistrering>
      <xsl:variable name="var:v1" select="userCSharp:pnrFormat(string(s1:Student/s1:Personnummer/text()))" />
      <ns0:PNR>
        <xsl:value-of select="$var:v1" />
      </ns0:PNR>
      
       <xsl:choose>
        <xsl:when test="s3:AterkalladOmregistreringEvent/s3:InomKurspaketeringstillfalle">
          <ns0:PROGR>
            <xsl:variable name="progtillf" select="/s4:AterkalladOmregistreringEnvelope/s2:Utbildningstillfalle[s6:Uid/text()=/s4:AterkalladOmregistreringEnvelope/s3:AterkalladOmregistreringEvent/s3:InomKurspaketeringstillfalle/s3:KurspaketeringstillfalleUID/text()]"/>
            <xsl:variable name="proginstans" select="/s4:AterkalladOmregistreringEnvelope/s2:Utbildningsinstans[s6:Uid/text()=$progtillf/s2:UtbildningsinstansUID/text()]"/>
            <xsl:variable name="progkod" select="$proginstans/s2:Utbildningskod/text()" />
            <xsl:value-of select="$proginstans/s2:Utbildningskod/text()" />
          </ns0:PROGR>
        </xsl:when>
        <xsl:otherwise>
          <ns0:PROGR>FRIST</ns0:PROGR>
        </xsl:otherwise>
      </xsl:choose>
       
     <ns0:KURS>
        <xsl:value-of  select="/s4:AterkalladOmregistreringEnvelope/s2:Utbildningsinstans[s6:Uid/text()=/s4:AterkalladOmregistreringEnvelope/s3:AterkalladOmregistreringEvent/s3:UtbildningsinstansUID/text()]/s2:Utbildningskod/text()"/>
      </ns0:KURS>
 
      <xsl:variable name="MinDate">
        <xsl:for-each select="/s4:AterkalladOmregistreringEnvelope/s2:Utbildningstillfalle[s6:Uid/text()=/s4:AterkalladOmregistreringEnvelope/s3:AterkalladOmregistreringEvent/s3:KurstillfalleUID/text()]/s2:Tillfallesperioder">
          <xsl:sort select="./s2:ForstaUndervisningsdatum/text()"  order="ascending"/>
          <xsl:choose>
            <xsl:when test="position() = 1">
              <xsl:value-of select="./s2:ForstaUndervisningsdatum/text()" />
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>
      </xsl:variable>
      
      <ns0:TERMIN>
        <xsl:value-of select="userCSharp:GetSemester($MinDate)" />
      </ns0:TERMIN>
  
      
      
    </ns0:uusmrUpdateAterkalladRegistrering>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp">
  <![CDATA[
//aaaammddxxxx  -> aaaammdd-xxxx
public string pnrFormat(string inPnr)
{
 return inPnr.Substring(0,8)+"-"+inPnr.Substring(8,4);
  
}


 public string GetSemester(string date)
    {   
    if(!string.IsNullOrEmpty(date)) {
        try 
        {
          string year = date.Substring(2,2);        
          int month = Convert.ToInt32(date.Substring(5,2));
            
          if(month < 7)
            return "VT"+year;
          else
            return "HT"+year;                  
        }
        catch(Exception)
        {
          return "";
        }
        } 
        else {
        return " ";
        }
    }

]]></msxsl:script>
</xsl:stylesheet>