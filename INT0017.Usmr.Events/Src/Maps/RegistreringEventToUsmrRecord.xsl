<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s5 s0 s1 s4 s2 s3 s6 userCSharp" version="1.0" xmlns:ns0="http://schemas.microsoft.com/Sql/2008/05/Procedures/dbo" xmlns:s5="http://schemas.ladok.se/events" xmlns:s0="http://schemas.ladok.se/studentinformation" xmlns:s1="http://schemas.ladok.se/utbildningsinformation" xmlns:s4="http://ladok.uu.envelope.schemas" xmlns:ns3="http://schemas.datacontract.org/2004/07/System.Data" xmlns:s2="http://schemas.ladok.se" xmlns:s3="http://schemas.ladok.se/studiedeltagande" xmlns:s6="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s4:RegistreringEnvelope" />
  </xsl:template>
  <xsl:template match="/s4:RegistreringEnvelope">
    <xsl:variable name="var:v9" select="userCSharp:DateCurrentDate()" />
    <ns0:uusmrCreateStudentRecord>
      <xsl:variable name="var:v1" select="userCSharp:pnrFormat(string(s0:Student/s0:Personnummer/text()))" />
      <ns0:PNR>
        <xsl:value-of select="$var:v1" />
      </ns0:PNR>
      <xsl:variable name="var:v2" select="userCSharp:usmrBlankField()" />
      <ns0:GPNR>
        <xsl:value-of select="$var:v2" />
      </ns0:GPNR>
      <xsl:if test="s0:Student/s0:Efternamn">
        <ns0:EFTERNAMN>
          <xsl:value-of select="s0:Student/s0:Efternamn/text()" />
        </ns0:EFTERNAMN>
      </xsl:if>
      <xsl:if test="s0:Student/s0:Fornamn">
        <ns0:FORNAMN>
          <xsl:value-of select="s0:Student/s0:Fornamn/text()" />
        </ns0:FORNAMN>
      </xsl:if>
      <xsl:variable name="var:v3" select="userCSharp:FormatDate(string(s0:Student/s2:SenastSparad/text()))" />
      <ns0:INLDATUM_PERS>
        <xsl:value-of select="$var:v3" />
      </ns0:INLDATUM_PERS>
      <xsl:variable name="var:v4" select="userCSharp:usmrBlankField()" />
      <ns0:COADRESS>
        <xsl:value-of select="$var:v4" />
      </ns0:COADRESS>
      <xsl:variable name="var:v5" select="userCSharp:usmrBlankField()" />
      <ns0:GATUADRESS>
        <xsl:value-of select="$var:v5" />
      </ns0:GATUADRESS>
      <xsl:variable name="var:v6" select="userCSharp:usmrBlankField()" />
      <ns0:POSTNR>
        <xsl:value-of select="$var:v6" />
      </ns0:POSTNR>
      <xsl:variable name="var:v7" select="userCSharp:usmrBlankField()" />
      <ns0:ORT>
        <xsl:value-of select="$var:v7" />
      </ns0:ORT>
      <xsl:variable name="var:v8" select="userCSharp:usmrBlankField()" />
      <ns0:LAND>
        <xsl:value-of select="$var:v8" />
      </ns0:LAND>
      <ns0:INLDATUM_ADRESS>
        <xsl:value-of select="$var:v9" />
      </ns0:INLDATUM_ADRESS>
      <xsl:variable name="var:v10" select="userCSharp:usmrBlankField()" />
      <ns0:TELNR>
        <xsl:value-of select="$var:v10" />
      </ns0:TELNR>
      <ns0:INLDATUM_TELNR>
        <xsl:value-of select="$var:v9" />
      </ns0:INLDATUM_TELNR>
      <xsl:variable name="var:v11" select="userCSharp:usmrBlankField()" />
      <ns0:EPOSTADRESS>
        <xsl:value-of select="$var:v11" />
      </ns0:EPOSTADRESS>
      <xsl:variable name="var:v12" select="userCSharp:usmrBlankField()" />
      <ns0:UPPEH>
        <xsl:value-of select="$var:v12" />
      </ns0:UPPEH>

      <ns0:KURS>
        <!--
        <xsl:variable name="UtbildningsinstansUID" select="./s1:UtbildningsinstansUID/text()" />
        <xsl:value-of select="/s4:RegistreringEnvelope/s1:Utbildningsinstans[s2:Uid/text()=/s4:RegistreringEnvelope/s3:RegistreringEvent/s3:UtbildningsinstansUID/text()]@Utbildningskod"/>
     
        -->
        <xsl:value-of  select="/s4:RegistreringEnvelope/s1:Utbildningsinstans[s2:Uid/text()=/s4:RegistreringEnvelope/s3:RegistreringEvent/s3:UtbildningsinstansUID/text()]/s1:Utbildningskod/text()"/>
        <!--
        <xsl:apply-templates select="/s4:RegistreringEnvelope/s1:Utbildningsinstans[s2:Uid/text()=/s4:RegistreringEnvelope/s3:RegistreringEvent/s3:UtbildningsinstansUID/text()]/Utbildningskod"/>
     
         -->
      </ns0:KURS>

      <ns0:INST>
        <xsl:value-of select="s0:Organisation/s0:Organisationskod/text()" />
      </ns0:INST>
     
      <xsl:if test="s1:Utbildningsinstans/s1:Omfattning">
        <ns0:POANG>
          <xsl:value-of  select="/s4:RegistreringEnvelope/s1:Utbildningsinstans[s2:Uid/text()=/s4:RegistreringEnvelope/s3:RegistreringEvent/s3:UtbildningsinstansUID/text()]/s1:Omfattning/text()"/>
      <!--    <xsl:value-of select="s1:Utbildningsinstans/s1:Omfattning/text()" /> -->
        </ns0:POANG>
      </xsl:if>
      
      <ns0:KT>
          <xsl:value-of select="/s4:RegistreringEnvelope/s1:Utbildningstillfalle[s2:Uid/text()=/s4:RegistreringEnvelope/s3:RegistreringEvent/s3:KurstillfalleUID/text()]/s1:StudietaktID/text()"/>
       
      </ns0:KT>
      <xsl:variable name="var:v15" select="userCSharp:usmrBlankField()" />
      <ns0:UF>
        <xsl:value-of select="$var:v15" />
      </ns0:UF>
     
      <ns0:KORT>
         <xsl:value-of select="/s4:RegistreringEnvelope/s1:Utbildningstillfalle[s2:Uid/text()=/s4:RegistreringEnvelope/s3:RegistreringEvent/s3:KurstillfalleUID/text()]/s1:StudielokaliseringID/text()"/>
      </ns0:KORT>
      <xsl:variable name="var:v17" select="userCSharp:usmrBlankField()" />
      <ns0:FIN>
        <xsl:value-of select="$var:v17" />
      </ns0:FIN>
      <xsl:variable name="var:v18" select="userCSharp:usmrBlankField()" />
      <xsl:choose>
        <xsl:when test="s3:RegistreringEvent/s3:InomKurspaketeringstillfalle">
          <ns0:PROGR>
            <xsl:apply-templates select="/s4:RegistreringEnvelope/s1:Utbildningstillfalle[s2:Uid/text()=/s4:RegistreringEnvelope/s3:RegistreringEvent/s3:InomKurspaketeringstillfalle/s3:KurspaketeringstillfalleUID/text()]"/>
          </ns0:PROGR>
        </xsl:when>
        <xsl:otherwise>
          <ns0:PROGR>FRIST</ns0:PROGR>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="var:v19" select="userCSharp:usmrBlankField()" />
      <ns0:AKT>
        <xsl:value-of select="$var:v19" />
      </ns0:AKT>
     
      <ns0:TERMIN>
        <xsl:value-of select="userCSharp:GetSemester(/s4:RegistreringEnvelope/s3:RegistreringEvent/s3:StudieperiodStart/text())" />
      </ns0:TERMIN>
      <xsl:variable name="var:v21" select="userCSharp:usmrBlankField()" />
      <ns0:PTAKT>
        <xsl:value-of select="$var:v21" />
      </ns0:PTAKT>
      <xsl:variable name="var:v22" select="userCSharp:usmrBlankField()" />
      <ns0:KAR>
        <xsl:value-of select="$var:v22" />
      </ns0:KAR>
      <xsl:variable name="var:v23" select="userCSharp:usmrBlankField()" />
      <ns0:TYP>
        <xsl:value-of select="$var:v23" />
      </ns0:TYP>
      <xsl:variable name="var:v24" select="userCSharp:usmrBlankField()" />
      <ns0:PLG>
        <xsl:value-of select="$var:v24" />
      </ns0:PLG>
    </ns0:uusmrCreateStudentRecord>
  </xsl:template>



  <xsl:template match="s1:Utbildningstillfalle">
    <xsl:variable name="UtbildningsinstansUID" select="./s1:UtbildningsinstansUID/text()" />
    <xsl:apply-templates select="/s4:RegistreringEnvelope/s1:Utbildningsinstans[s2:Uid/text()=$UtbildningsinstansUID]"/>
  </xsl:template>


  <xsl:template match="s1:Utbildningsinstans">
    
    <xsl:value-of select="./s1:Utbildningskod/text()"/>  
  </xsl:template>

 
 
  <msxsl:script language="C#" implements-prefix="userCSharp">
    <![CDATA[
public string DateCurrentDate()
{
	DateTime dt = DateTime.Now;
	return dt.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
}
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

 //aa aammddxxxx 
public string pnrFormat(string inPnr)
{
 return inPnr.Substring(2,6)+"-"+inPnr.Substring(8,4);
  
}


 

public string usmrBlankField()
{
	return " ";
}


 
public string FormatDate(string inDate)
 {               
               if (inDate.Length  > 9) {
	return inDate.Substring(0,10);
              } else {
              return inDate;
              }
}



]]>
  </msxsl:script>
</xsl:stylesheet>