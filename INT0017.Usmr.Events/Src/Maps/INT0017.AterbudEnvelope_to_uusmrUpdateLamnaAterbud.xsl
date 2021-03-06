<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s4 s0 s1 s3 s5 s2 s6 userCSharp" version="1.0" xmlns:ns0="http://schemas.microsoft.com/Sql/2008/05/Procedures/dbo" xmlns:s4="http://schemas.ladok.se/events" xmlns:s0="http://schemas.ladok.se/studentinformation" xmlns:s1="http://schemas.ladok.se/utbildningsinformation" xmlns:s3="http://ladok.uu.envelope.schemas" xmlns:ns3="http://schemas.datacontract.org/2004/07/System.Data" xmlns:s5="http://schemas.ladok.se" xmlns:s2="http://schemas.ladok.se/studiedeltagande" xmlns:s6="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s3:AterbudEnvelope" />
  </xsl:template>
  <xsl:template match="/s3:AterbudEnvelope">
    <ns0:uusmrUpdateLamnaAterbud>
      <xsl:variable name="personnummer" select="userCSharp:pnrFormat(string(s0:Student/s0:Personnummer/text()))" />
      <ns0:PNR>
        <xsl:value-of select="$personnummer" />
      </ns0:PNR>
       
      <ns0:PROGR>NOTINUSE</ns0:PROGR>

      <xsl:variable name="kursUtbTillfalle" select=" /s3:AterbudEnvelope/s1:Utbildningstillfalle[s5:Uid/text()=/s3:AterbudEnvelope/s2:AterbudEvent/s2:UtbildningstillfalleUID/text()]" />
      <ns0:KURS>
        <xsl:value-of  select="/s3:AterbudEnvelope/s1:Utbildningsinstans[s5:Uid/text()=$kursUtbTillfalle/s1:UtbildningsinstansUID/text()]/s1:Utbildningskod/text()"/>
      </ns0:KURS>
 
      <xsl:variable name="MinDate">
        <xsl:for-each select="$kursUtbTillfalle/s1:Tillfallesperioder">
          <xsl:sort select="./s1:ForstaUndervisningsdatum/text()"  order="ascending"/>
          <xsl:choose>
            <xsl:when test="position() = 1">
              <xsl:value-of select="./s1:ForstaUndervisningsdatum/text()" />
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>
      </xsl:variable>
      
      <ns0:TERMIN>
        <xsl:value-of select="userCSharp:GetSemester($MinDate)" />
      </ns0:TERMIN>
   
    </ns0:uusmrUpdateLamnaAterbud>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp"><![CDATA[
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


]]></msxsl:script>
</xsl:stylesheet>