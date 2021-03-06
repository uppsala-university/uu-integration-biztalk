<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s6 s0 s1 s2 s4 s5 s3 s7 userCSharp ScriptNS0" version="1.0" xmlns:s6="http://schemas.ladok.se" xmlns:ns0="http://schemas.microsoft.com/Sql/2008/05/Procedures/dbo" xmlns:s0="http://UU.Integrations.Common.Schemas" xmlns:s1="http://schemas.ladok.se/studentinformation" xmlns:s2="http://schemas.ladok.se/utbildningsinformation" xmlns:s4="http://ladok.uu.envelope.schemas" xmlns:ns3="http://schemas.datacontract.org/2004/07/System.Data" xmlns:s5="http://schemas.ladok.se/events" xmlns:s3="http://schemas.ladok.se/studiedeltagande" xmlns:s7="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s4:AvbrottEnvelope" />
  </xsl:template>
  <xsl:template match="/s4:AvbrottEnvelope">
    <xsl:variable name="var:v2" select="userCSharp:StringTrimLeft(&quot;noop.&quot;)" />
    <ns0:uusmrUpdateStudieavbrott>
      <xsl:variable name="var:v1" select="userCSharp:formatPersonnummer(string(s1:Student/s1:Personnummer/text()))" />
      <ns0:PNR>
        <xsl:value-of select="$var:v1" />
      </ns0:PNR>
   
      <xsl:variable name="programkod">
        <xsl:apply-templates select="/s4:AvbrottEnvelope/s2:Utbildningstillfalle[ScriptNS0:ListContainsValue('INT0017.Usmr.Events', 'Programtillfallestyper', s2:UtbildningstypID/text(), ',')]"/>
      </xsl:variable>
  
          <ns0:PROGR>
            <xsl:choose>
              <xsl:when test="$programkod !=''">
                <xsl:value-of select="$programkod" />
              </xsl:when>
              <xsl:otherwise>FRIST</xsl:otherwise>
            </xsl:choose>
          </ns0:PROGR>
      
              
      <xsl:variable name="utbInstansid">
        <xsl:value-of select="/s4:AvbrottEnvelope/s2:Utbildningstillfalle[s6:Uid/text()=/s4:AvbrottEnvelope/s3:AvbrottEvent/s3:UtbildningstillfalleUID/text()]/s2:UtbildningsinstansUID/text()" />
      </xsl:variable>
    
          <ns0:KURS>
            <xsl:choose>
              <xsl:when test="$programkod !=''"></xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="/s4:AvbrottEnvelope/s2:Utbildningsinstans[s6:Uid/text()=$utbInstansid]/s2:Utbildningskod/text()" />
              </xsl:otherwise>
            </xsl:choose>
          </ns0:KURS>
         

      <xsl:variable name="MinDate">
        <xsl:for-each select="/s4:AvbrottEnvelope/s2:Utbildningstillfalle[s6:Uid/text()=/s4:AvbrottEnvelope/s3:AvbrottEvent/s3:UtbildningstillfalleUID/text()]/s2:Tillfallesperioder">
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
      <xsl:if test="s3:AvbrottEvent/s3:Avbrottsdatum">
        <ns0:AVBROTTSDATUM>
          <xsl:value-of select="s3:AvbrottEvent/s3:Avbrottsdatum/text()" />
        </ns0:AVBROTTSDATUM>
      </xsl:if>
    </ns0:uusmrUpdateStudieavbrott>
  </xsl:template>

  
  <xsl:template   match="s2:Utbildningstillfalle">
    <xsl:variable name="UtbildningsinstansUID" select="./s2:UtbildningsinstansUID/text()" />
    <xsl:apply-templates select="/s4:AvbrottEnvelope/s2:Utbildningsinstans[s6:Uid/text()=$UtbildningsinstansUID]"/>
  </xsl:template>

  <xsl:template match="s2:Utbildningsinstans">
    <xsl:variable name="prkod" select="./s2:Utbildningskod/text()"/>
    <xsl:value-of select="./s2:Utbildningskod/text()"/>

  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp">
  <![CDATA[

 //aaaammddxxxx  -> aaaammdd-xxxx
public string formatPersonnummer(string inPnr)
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
            return "V"+year;
          else
            return "H"+year;                  
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
    
public string StringTrimLeft(string str)
{
	if (str == null)
	{
		return "";
	}
	return str.TrimStart(null);
}



]]></msxsl:script>
</xsl:stylesheet>