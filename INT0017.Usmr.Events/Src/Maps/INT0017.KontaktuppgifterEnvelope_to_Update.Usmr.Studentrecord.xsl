<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s4 s0 s1 s3 s5 s2 s6 userCSharp" version="1.0" xmlns:ns0="http://schemas.microsoft.com/Sql/2008/05/Procedures/dbo" xmlns:s4="http://schemas.ladok.se/events" xmlns:s0="http://schemas.ladok.se/studentinformation" xmlns:s1="http://schemas.ladok.se/utbildningsinformation" xmlns:s3="http://ladok.uu.envelope.schemas" xmlns:ns3="http://schemas.datacontract.org/2004/07/System.Data" xmlns:s5="http://schemas.ladok.se" xmlns:s2="http://schemas.ladok.se/studiedeltagande" xmlns:s6="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s3:KontaktuppgifterEnvelope" />
  </xsl:template>
  <xsl:template match="/s3:KontaktuppgifterEnvelope">
    <xsl:variable name="var:v2" select="userCSharp:DateCurrentDate()" />
    <ns0:uusmrUpdateStudentRecord>
      <xsl:variable name="var:v1" select="userCSharp:pnrFormat(string(s0:Student/s0:Personnummer/text()))" />
      <ns0:PNR>
        <xsl:value-of select="$var:v1" />
      </ns0:PNR>
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
      <ns0:INLDATUM_PERS>
        <xsl:value-of select="$var:v2" />
      </ns0:INLDATUM_PERS>
      <xsl:variable name="var:v400" select="s0:KontaktuppgifterEvent/s0:Postadresser[s0:PostadressTyp/text()='FOLKBOKFORINGSADRESS']" />
      <xsl:variable name="var:v500" select="s0:KontaktuppgifterEvent/s0:Postadresser" />
      <xsl:variable name="var:v600" select="s0:KontaktuppgifterEvent/s0:Postadresser[s0:PostadressTyp/text()='POSTADRESS']" />

      <ns0:COADRESS>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s0:CareOf/text()" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s0:CareOf/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s0:CareOf/text()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </ns0:COADRESS>

       
      <ns0:GATUADRESS>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s0:Utdelningsadress/text()" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s0:Utdelningsadress/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s0:Utdelningsadress/text()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>


      </ns0:GATUADRESS>
      
      <ns0:POSTNR>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s0:Postnummer/text()" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s0:Postnummer/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s0:Postnummer/text()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </ns0:POSTNR>
      
      <ns0:ORT>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s0:Postort/text()" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s0:Postort/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s0:Postort/text()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </ns0:ORT>

      <ns0:LAND>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s0:Land/text()" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s0:Land/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s0:Land/text()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </ns0:LAND>
      <ns0:INLDATUM_ADRESS>
        <xsl:value-of select="$var:v2" />
      </ns0:INLDATUM_ADRESS>
      <xsl:choose>
        <xsl:when test="s0:KontaktuppgifterEvent/s0:Telefonnummer">
          <ns0:TELNR>
            <xsl:value-of select="s0:KontaktuppgifterEvent/s0:Telefonnummer/text()" />
          </ns0:TELNR>
        </xsl:when>
        <xsl:otherwise>
          <ns0:TELNR> </ns0:TELNR>
        </xsl:otherwise>
      </xsl:choose>
         
      <ns0:INLDATUM_TELNR>
        <xsl:value-of select="$var:v2" />
      </ns0:INLDATUM_TELNR>
      <xsl:choose>
        <xsl:when test="s0:KontaktuppgifterEvent/s0:Epostadress/text()">
          <ns0:EPOSTADRESS>
            <xsl:value-of select="s0:KontaktuppgifterEvent/s0:Epostadress/text()" />
          </ns0:EPOSTADRESS>
        </xsl:when>
        <xsl:otherwise>
          <ns0:EPOSTADRESS> </ns0:EPOSTADRESS>
        </xsl:otherwise>
      </xsl:choose>
     
    </ns0:uusmrUpdateStudentRecord>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp">
  <![CDATA[
 //aaaammddxxxx  -> aaaammdd-xxxx
public string pnrFormat(string inPnr)
{
 return inPnr.Substring(0,8)+"-"+inPnr.Substring(8,4);
  
}

public string DateCurrentDate()
{
	DateTime dt = DateTime.Now;
	return dt.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
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



]]></msxsl:script>
</xsl:stylesheet>