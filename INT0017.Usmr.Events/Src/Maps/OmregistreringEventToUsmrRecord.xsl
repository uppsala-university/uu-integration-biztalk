<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s6 s7 s0 s1 s2 s5 s3 s4 s8 userCSharp ScriptNS0" version="1.0" xmlns:s6="http://schemas.ladok.se/avisering" xmlns:ns0="http://schemas.microsoft.com/Sql/2008/05/Procedures/dbo" xmlns:s7="http://schemas.ladok.se/events" xmlns:s0="http://schemas.ladok.se/kataloginformation" xmlns:s1="http://schemas.ladok.se/studentinformation" xmlns:s2="http://schemas.ladok.se/utbildningsinformation" xmlns:s5="http://ladok.uu.envelope.schemas" xmlns:ns3="http://schemas.datacontract.org/2004/07/System.Data" xmlns:s3="http://schemas.ladok.se" xmlns:s4="http://schemas.ladok.se/studiedeltagande" xmlns:s8="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0" >
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s5:OmregistreringEnvelope" />
  </xsl:template>
  <xsl:template match="/s5:OmregistreringEnvelope">
    <xsl:variable name="var:v9" select="userCSharp:DateCurrentDate()" />
    <ns0:uusmrCreateStudentRecord>
      <xsl:variable name="var:v1" select="userCSharp:pnrFormat(string(s1:Student/s1:Personnummer/text()))" />
      <ns0:PNR>
        <xsl:value-of select="$var:v1" />
      </ns0:PNR>
      <xsl:variable name="var:v2" select="userCSharp:usmrBlankField()" />
      <ns0:GPNR>
        <xsl:value-of select="$var:v2" />
      </ns0:GPNR>
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
      <xsl:variable name="var:v3" select="userCSharp:FormatDate(string(s1:Student/s3:SenastSparad/text()))" />
      <ns0:INLDATUM_PERS>
        <xsl:value-of select="$var:v3" />
      </ns0:INLDATUM_PERS>

      <xsl:variable name="var:v400" select="/s5:OmregistreringEnvelope/s1:Kontaktuppgifter/s1:Postadresser[s1:PostadressTyp/text()='FOLKBOKFORINGSADRESS']" />
      <xsl:variable name="var:v500" select="/s5:OmregistreringEnvelope/s1:Kontaktuppgifter/s1:Postadresser" />
      <xsl:variable name="var:v600" select="/s5:OmregistreringEnvelope/s1:Kontaktuppgifter/s1:Postadresser[s1:PostadressTyp/text()='POSTADRESS']" />


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

      <xsl:variable name="var:v5" select="userCSharp:usmrBlankField()" />
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
      <xsl:variable name="var:v6" select="userCSharp:usmrBlankField()" />
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
      <xsl:variable name="var:v7" select="userCSharp:usmrBlankField()" />
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
      <xsl:variable name="var:v300" select="userCSharp:FormatDate(string(s1:Kontaktuppgifter/s1:TelefonnummerSenastAndrad/text()))" />
      <ns0:INLDATUM_TELNR>

        <xsl:value-of select="$var:v300" />
      </ns0:INLDATUM_TELNR>
      <xsl:choose>
        <xsl:when test="s1:Kontaktuppgifter/s1:Epostadress">
          <ns0:EPOSTADRESS>
            <xsl:value-of select="s1:Kontaktuppgifter/s1:Epostadress/text()" />
          </ns0:EPOSTADRESS>
        </xsl:when>
        <xsl:otherwise>
          <ns0:EPOSTADRESS> </ns0:EPOSTADRESS>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="var:v11" select="userCSharp:usmrBlankField()" />
      <ns0:UPPEH>
        <xsl:value-of select="$var:v11" />
      </ns0:UPPEH>
      <ns0:KURS>
        <xsl:value-of  select="/s5:OmregistreringEnvelope/s2:Utbildningsinstans[s3:Uid/text()=/s5:OmregistreringEnvelope/s4:OmregistreringEvent/s4:UtbildningsinstansUID/text()]/s2:Utbildningskod/text()"/>
      </ns0:KURS>
      <ns0:INST>
        <xsl:value-of select="s0:Organisation/s0:Organisationskod/text()" />
      </ns0:INST>

      <ns0:POANG>
        <xsl:value-of  select="/s5:OmregistreringEnvelope/s2:Utbildningsinstans[s3:Uid/text()=/s5:OmregistreringEnvelope/s4:OmregistreringEvent/s4:UtbildningsinstansUID/text()]/s2:Omfattning/text()"/>
      </ns0:POANG>
      <xsl:variable name="kurstaktId" select="/s5:OmregistreringEnvelope/s2:Utbildningstillfalle[s3:Uid/text()=/s5:OmregistreringEnvelope/s4:OmregistreringEvent/s4:KurstillfalleUID/text()]/s2:StudietaktID/text()"  />
      <xsl:variable name="ortsId" select="/s5:OmregistreringEnvelope/s2:Utbildningstillfalle[s3:Uid/text()=/s5:OmregistreringEnvelope/s4:OmregistreringEvent/s4:KurstillfalleUID/text()]/s2:StudielokaliseringID/text()"  />
      <ns0:KT>
        <xsl:value-of select="s2:Studietakter/s2:Studietakt[s3:ID/text()=$kurstaktId]/s2:Takt/text()" />
      </ns0:KT>
      <xsl:variable name="var:v12" select="userCSharp:usmrBlankField()" />
      <ns0:UF>
        <xsl:value-of select="$var:v12" />
      </ns0:UF>
      <ns0:KORT>
        <xsl:value-of select="s0:Studielokaliseringar/s0:Studielokalisering[s3:ID/text()=$ortsId]/s3:Kod/text()"/>
      </ns0:KORT>
      
      <xsl:variable name="finanskod" select="/s5:OmregistreringEnvelope/s2:Utbildningstillfalle[s3:Uid/text()=/s5:OmregistreringEnvelope/s4:OmregistreringEvent/s4:KurstillfalleUID/text()]/s2:Attributvarden[s2:Namn/text()='utbildning.attribut.finansieringsform']/s2:Varde/text()"/>
      <ns0:FIN>
        <xsl:value-of select="/s5:OmregistreringEnvelope/s2:Finansieringsformer/s2:Finansieringsform[s3:ID/text()=$finanskod]/s3:Kod/text()" />
      </ns0:FIN>
 
      <xsl:variable name="var:v15" select="userCSharp:usmrBlankField()" />

      <xsl:choose>
        <xsl:when test="s4:OmregistreringEvent/s4:InomKurspaketeringstillfalle">
          <ns0:PROGR>
            <xsl:variable name="programkod">
              <xsl:apply-templates select="/s5:OmregistreringEnvelope/s2:Utbildningstillfalle[ScriptNS0:ListContainsValue('INT0017.Usmr.Events', 'Programtillfallestyper', s2:UtbildningstypID/text(), ',')]"/>
            </xsl:variable>
            <xsl:value-of select="$programkod" />
          </ns0:PROGR>
        </xsl:when>
        <xsl:otherwise>
          <ns0:PROGR>FRIST</ns0:PROGR>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="var:v16" select="userCSharp:usmrBlankField()" />
      <ns0:AKT>
        <xsl:value-of select="$var:v16" />
      </ns0:AKT>
      <ns0:TERMIN>
        <xsl:value-of select="userCSharp:GetSemester(/s5:OmregistreringEnvelope/s4:OmregistreringEvent/s4:StudieperiodStart/text())" />
      </ns0:TERMIN>
      <xsl:variable name="var:v18" select="userCSharp:usmrBlankField()" />
      <ns0:PTAKT>
        <xsl:value-of select="$var:v18" />
      </ns0:PTAKT>
      <xsl:variable name="var:v19" select="userCSharp:usmrBlankField()" />
      <ns0:KAR>
        <xsl:value-of select="$var:v19" />
      </ns0:KAR>
      <xsl:variable name="var:v20" select="userCSharp:usmrBlankField()" />
      <ns0:TYP>
        <xsl:value-of select="$var:v20" />
      </ns0:TYP>
      <xsl:variable name="var:v21" select="userCSharp:usmrBlankField()" />
      <ns0:PLG>
        <xsl:value-of select="$var:v21" />
      </ns0:PLG>
    </ns0:uusmrCreateStudentRecord>
  </xsl:template>
  <xsl:template match="s2:Utbildningstillfalle">
    <xsl:variable name="UtbildningsinstansUID" select="./s2:UtbildningsinstansUID/text()" />
    <xsl:apply-templates select="/s5:OmregistreringEnvelope/s2:Utbildningsinstans[s3:Uid/text()=$UtbildningsinstansUID]"/>
  </xsl:template>


  <xsl:template match="s2:Utbildningsinstans">
    <xsl:value-of select="./s2:Utbildningskod/text()"/>
  </xsl:template>

 
  <msxsl:script language="C#" implements-prefix="userCSharp">
    <![CDATA[
   
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
          return " ";
        }
        } 
        else {
        return " ";
        }
    }
    
    
public string DateCurrentDate()
{
	DateTime dt = DateTime.Now;
	return dt.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
}


 //aaaammddxxxx  -> aaaammdd-xxxx
public string pnrFormat(string inPnr)
{
 return inPnr.Substring(0,8)+"-"+inPnr.Substring(8,4);
  
}


 

public string usmrBlankField()
{
	return " ";
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



]]>
  </msxsl:script>
</xsl:stylesheet>