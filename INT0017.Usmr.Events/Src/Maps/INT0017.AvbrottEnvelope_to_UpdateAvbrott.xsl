<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
                xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s6 s0 s1 s2 s4 s5 s3 s7 userCSharp" version="1.0" 
                xmlns:s6="http://schemas.ladok.se" xmlns:s0="http://UU.Integrations.Common.Schemas" 
                xmlns:ns0="http://schemas.microsoft.com/Sql/2008/05/TypedProcedures/dbo" 
                xmlns:s2="http://schemas.ladok.se/utbildningsinformation" 
                xmlns:s1="http://schemas.ladok.se/studentinformation" 
                xmlns:s4="http://ladok.uu.envelope.schemas" 
                xmlns:s5="http://schemas.ladok.se/events" 
                xmlns:s3="http://schemas.ladok.se/studiedeltagande" 
                xmlns:s7="http://schemas.ladok.se/dap"
                xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s4:AvbrottEnvelope" />
  </xsl:template>
  <xsl:template match="/s4:AvbrottEnvelope">
    <ns0:INT0017.UpdateAvbrott>
      <xsl:if test="s1:Student/s1:Personnummer">
        <ns0:PNR>          
          <xsl:value-of select="userCSharp:pnrFormat(string(s1:Student/s1:Personnummer/text()))" />
        </ns0:PNR>
      </xsl:if>
      <xsl:if test="s3:AvbrottEvent/s3:Avbrottsdatum">
        <ns0:AVBROTT>
          <xsl:value-of select="userCSharp:DateToDateTime(s3:AvbrottEvent/s3:Avbrottsdatum/text())" />
        </ns0:AVBROTT>
        
        <xsl:variable name="MinDate">
          <xsl:for-each select="/s4:ForvantatDeltagandeSkapadEnvelope/s2:Utbildningstillfalle[s6:Uid/text()=/s4:ForvantatDeltagandeSkapadEnvelope/s3:ForvantatDeltagandeSkapadEvent/s3:UtbildningstillfalleUID/text()]/s2:Tillfallesperioder">
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
        
        <ns0:KURS>
          <xsl:value-of  select="/s4:OmregistreringEnvelope/s2:Utbildningsinstans[s6:Uid/text()=/s4:OmregistreringEnvelope/s3:OmregistreringEvent/s3:UtbildningsinstansUID/text()]/s2:Utbildningskod/text()"/>
        </ns0:KURS>
        
        
      </xsl:if>
    </ns0:INT0017.UpdateAvbrott>
  </xsl:template>

  <msxsl:script language="C#" implements-prefix="userCSharp">
    <![CDATA[

 public string GetSemester(string date)
    {
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
    
    public string DateToDateTime(string Date)
    {
      try
      {
       return DateTime.Parse(Date).ToString("s");
       }
       catch(Exception)
       {
          return "Could not convert to date in INT0017.AvbrottEnvelope_to_UpdateAvbrott mapping.";
       }
    }
    
   //aaaammddxxxx  -> aaaammdd-xxxx
public string pnrFormat(string inPnr)
{
 return inPnr.Substring(0,8)+"-"+inPnr.Substring(8,4);
  
}
    
]]>
  </msxsl:script>
  
</xsl:stylesheet>