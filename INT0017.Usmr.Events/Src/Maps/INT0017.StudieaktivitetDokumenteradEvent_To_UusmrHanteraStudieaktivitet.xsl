<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s5 s6 s0 s1 s2 s4 s7 s3 s8 userCSharp" version="1.0" xmlns:s5="http://schemas.ladok.se/avisering" xmlns:ns0="http://schemas.microsoft.com/Sql/2008/05/Procedures/dbo" xmlns:s6="http://schemas.ladok.se/events" xmlns:s0="http://schemas.ladok.se/kataloginformation" xmlns:s1="http://schemas.ladok.se/studentinformation" xmlns:s2="http://schemas.ladok.se/utbildningsinformation" xmlns:s4="http://ladok.uu.envelope.schemas" xmlns:ns3="http://schemas.datacontract.org/2004/07/System.Data" xmlns:s7="http://schemas.ladok.se" xmlns:s3="http://schemas.ladok.se/studiedeltagande" xmlns:s8="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s4:StudieaktivitetDokumenteradEnvelope" />
  </xsl:template>
  <xsl:template match="/s4:StudieaktivitetDokumenteradEnvelope">
    <ns0:uusmrHanteraStudieaktivitet>
      <xsl:if test="s1:Student/s1:Personnummer">
        <xsl:variable name="var:v1" select="userCSharp:pnrFormat(string(s1:Student/s1:Personnummer/text()))" />
        <ns0:PNR>
          <xsl:value-of select="$var:v1" />
        </ns0:PNR>
      </xsl:if>
      <xsl:if test="s1:Student/s1:Efternamn">
        <ns0:EFTERNAMN>
          <xsl:value-of select="s1:Student/s1:Efternamn/text()" />
        </ns0:EFTERNAMN>
      </xsl:if>
      <xsl:if test="s1:Student/s1:Fornamn">
        <ns0:FORNAMN>
          <xsl:value-of select="s1:Student/s1:Fornamn/text()" />
        </ns0:FORNAMN>
      </xsl:if>
      <xsl:variable name="var:v2" select="userCSharp:FormatDate(string(s1:Student/s7:SenastSparad/text()))" />
      <ns0:INLDATUM_PERS>
        <xsl:value-of select="$var:v2" />
      </ns0:INLDATUM_PERS>
      <xsl:variable name="var:v400" select="s1:Kontaktuppgifter/s1:Postadresser[s1:PostadressTyp/text()='FOLKBOKFORINGSADRESS']" />
      <xsl:variable name="var:v500" select="s1:Kontaktuppgifter/s1:Postadresser" />
      <xsl:variable name="var:v600" select="s1:Kontaktuppgifter/s1:Postadresser[s1:PostadressTyp/text()='POSTADRESS']" />

      <ns0:COADRESS>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s1:CareOf/text()" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s1:CareOf/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s1:CareOf/text()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </ns0:COADRESS>
      <ns0:GATUADRESS>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s1:Utdelningsadress/text()" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s1:Utdelningsadress/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s1:Utdelningsadress/text()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>


      </ns0:GATUADRESS>
 
      <ns0:POSTNR>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s1:Postnummer/text()" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s1:Postnummer/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s1:Postnummer/text()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </ns0:POSTNR>
       
      <ns0:ORT>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s1:Postort/text()" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s1:Postort/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s1:Postort/text()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </ns0:ORT>

      <ns0:LAND>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s1:Land/text()" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s1:Land/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s1:Land/text()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </ns0:LAND>
    
      <ns0:INLDATUM_ADRESS>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="userCSharp:FormatDate(string($var:v600/@SenastAndrad))" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="userCSharp:FormatDate(string($var:v400/@SenastAndrad))" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="userCSharp:FormatDate(string($var:v500/@SenastAndrad))" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </ns0:INLDATUM_ADRESS>
      
        <ns0:TELNR>
          <xsl:value-of select="s1:Kontaktuppgifter/s1:Telefonnummer/text()" />
        </ns0:TELNR>
      
      <xsl:variable name="var:v4" select="userCSharp:FormatDate(string(s1:Kontaktuppgifter/s1:TelefonnummerSenastAndrad/text()))" />
      <ns0:INLDATUM_TELNR>
        <xsl:value-of select="$var:v4" />
      </ns0:INLDATUM_TELNR>
      
        <ns0:EPOSTADRESS>
          <xsl:value-of select="s1:Kontaktuppgifter/s1:Epostadress/text()" />
        </ns0:EPOSTADRESS>
      
      <ns0:TERMIN>
        
        <xsl:value-of select="userCSharp:FormatPeriodToSemester(s0:Perioder/s0:Perioder/s0:Period[s7:ID/text()=/s4:StudieaktivitetDokumenteradEnvelope/s3:StudieaktivitetDokumenteradEvent/s3:Studieaktivitet/s3:PeriodID/text()]/s7:Kod/text())" />
      </ns0:TERMIN>
      <ns0:INST>
        <xsl:value-of select="s0:Organisation/s0:Organisationskod/text()" />
      </ns0:INST>
      <ns0:AKT>
        <xsl:value-of select="s3:StudieaktivitetDokumenteradEvent/s3:Studieaktivitet/s3:Procent/text()" />
      </ns0:AKT>
      <ns0:EVENTTYP>
        <xsl:value-of select="s3:StudieaktivitetDokumenteradEvent/s3:Eventtyp/text()" />
      </ns0:EVENTTYP>
    </ns0:uusmrHanteraStudieaktivitet>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp">
  <![CDATA[
 //aa aammddxxxx 
public string pnrFormat(string inPnr)
{
 
return inPnr.Substring(0,8)+"-"+inPnr.Substring(8,4);
  
}



public string FormatDate(string inDate)
 {             
    if(!string.IsNullOrEmpty(inDate)) {
               if (inDate.Length  > 9) {
	return inDate.Substring(0,10);
              } else {
              return inDate;
              }
              }
              else
              {
              return " ";
              }
}

public string FormatPeriodToSemester(string inDate)
 {             
    if(!string.IsNullOrEmpty(inDate)) {
               if (inDate.Length  == 5) {
                	return inDate.Substring(4,1)+ inDate.Substring(2,2);
              } 
              }
              return " ";
}

]]></msxsl:script>
</xsl:stylesheet>