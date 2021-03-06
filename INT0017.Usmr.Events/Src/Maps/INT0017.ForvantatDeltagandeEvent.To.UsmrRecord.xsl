<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s6 s8 s0 s1 s2 s3 s5 s7 s4 s9 userCSharp ScriptNS0" version="1.0" xmlns:s6="http://schemas.ladok.se/avisering" xmlns:ns0="http://schemas.microsoft.com/Sql/2008/05/Procedures/dbo" xmlns:s8="http://schemas.ladok.se" xmlns:s0="http://UU.Integrations.Common.Schemas" xmlns:s1="http://schemas.ladok.se/kataloginformation" xmlns:s2="http://schemas.ladok.se/studentinformation" xmlns:s3="http://schemas.ladok.se/utbildningsinformation" xmlns:s5="http://ladok.uu.envelope.schemas" xmlns:ns3="http://schemas.datacontract.org/2004/07/System.Data" xmlns:s7="http://schemas.ladok.se/events" xmlns:s4="http://schemas.ladok.se/studiedeltagande" xmlns:s9="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s5:ForvantatDeltagandeSkapadEnvelope" />
  </xsl:template>
  <xsl:template match="/s5:ForvantatDeltagandeSkapadEnvelope">
    <xsl:variable name="var:v2" select="userCSharp:StringTrimRight(&quot;&quot;)" />
    <ns0:uusmrCreateStudentRecord>
      <xsl:variable name="var:v1" select="userCSharp:pnrFormat(string(s2:Student/s2:Personnummer/text()))" />
      <ns0:PNR>
        <xsl:value-of select="$var:v1" />
      </ns0:PNR>
          <ns0:GPNR>
        <xsl:value-of select="$var:v2" />
      </ns0:GPNR>
      <xsl:if test="s2:Student/s2:Efternamn">
        <ns0:EFTERNAMN>
          <xsl:value-of select="s2:Student/s2:Efternamn/text()" />
        </ns0:EFTERNAMN>
      </xsl:if>
      <xsl:if test="s2:Student/s2:Fornamn">
        <ns0:FORNAMN>
          <xsl:value-of select="s2:Student/s2:Fornamn/text()" />
        </ns0:FORNAMN>
      </xsl:if>
       <xsl:variable name="senastSparad" select="userCSharp:FormatDate(string(s2:Student/s8:SenastSparad/text()))" />
      <ns0:INLDATUM_PERS>
        <xsl:value-of select="$senastSparad" />
      </ns0:INLDATUM_PERS>

      <xsl:variable name="var:v400" select="s2:Kontaktuppgifter/s2:Postadresser[s2:PostadressTyp/text()='FOLKBOKFORINGSADRESS']" />
      <xsl:variable name="var:v600" select="s2:Kontaktuppgifter/s2:Postadresser[s2:PostadressTyp/text()='POSTADRESS']" />
      <xsl:variable name="var:v500" select="s2:Kontaktuppgifter/s2:Postadresser" />

      <ns0:COADRESS>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s2:CareOf/text()" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s2:CareOf/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s2:CareOf/text()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
        
      </ns0:COADRESS>
      <ns0:GATUADRESS>
       
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s2:Utdelningsadress/text()" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s2:Utdelningsadress/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s2:Utdelningsadress/text()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>

      </ns0:GATUADRESS>
      <ns0:POSTNR>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s2:Postnummer/text()" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s2:Postnummer/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s2:Postnummer/text()" />
              </xsl:otherwise>
            </xsl:choose>
              </xsl:otherwise>
        </xsl:choose>
      </ns0:POSTNR>
      <ns0:ORT>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s2:Postort/text()" />
          </xsl:when>
          <xsl:otherwise>
             
            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s2:Postort/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s2:Postort/text()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </ns0:ORT>
      <ns0:LAND>
        <xsl:choose>
          <xsl:when test="$var:v600">
            <xsl:value-of select="$var:v600/s2:Land/text()" />
          </xsl:when>
          <xsl:otherwise>

            <xsl:choose>
              <xsl:when test="$var:v400">
                <xsl:value-of select="$var:v400/s2:Land/text()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$var:v500/s2:Land/text()" />
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
        <xsl:value-of select="s2:Kontaktuppgifter/s2:Telefonnummer/text()" />
      </ns0:TELNR>
      <xsl:variable name="var:v300" select="userCSharp:FormatDate(string(s2:Kontaktuppgifter/s2:TelefonnummerSenastAndrad/text()))" />
      <ns0:INLDATUM_TELNR>
        <xsl:value-of select="$var:v300" />
      </ns0:INLDATUM_TELNR>
      <xsl:choose>
        <xsl:when test="s2:Kontaktuppgifter/s2:Epostadress">
          <ns0:EPOSTADRESS>
            <xsl:value-of select="s2:Kontaktuppgifter/s2:Epostadress/text()" />
          </ns0:EPOSTADRESS>
        </xsl:when>
        <xsl:otherwise>
          <ns0:EPOSTADRESS> </ns0:EPOSTADRESS>
        </xsl:otherwise>
      </xsl:choose>
          
      <ns0:UPPEH>
        <xsl:value-of select="$var:v2" />
      </ns0:UPPEH>
      <xsl:variable name="instans" select="/s5:ForvantatDeltagandeSkapadEnvelope/s3:Utbildningstillfalle[s8:Uid/text()=/s5:ForvantatDeltagandeSkapadEnvelope/s4:ForvantatDeltagandeSkapadEvent/s4:UtbildningstillfalleUID/text()]/s3:UtbildningsinstansUID/text()" />

      <ns0:KURS>
        <xsl:value-of  select="/s5:ForvantatDeltagandeSkapadEnvelope/s3:Utbildningsinstans[s8:Uid=$instans]/s3:Utbildningskod/text()"/>
      </ns0:KURS>
      <ns0:INST>
        <xsl:value-of select="s1:Organisation/s1:Organisationskod/text()" />
      </ns0:INST>
      <ns0:POANG>
        <xsl:value-of select="/s5:ForvantatDeltagandeSkapadEnvelope/s3:Utbildningsinstans[s8:Uid=$instans]/s3:Omfattning/text()" />
      </ns0:POANG>
      <xsl:variable name="kurstaktId" select="/s5:ForvantatDeltagandeSkapadEnvelope/s3:Utbildningstillfalle[s8:Uid/text()=/s5:ForvantatDeltagandeSkapadEnvelope/s4:ForvantatDeltagandeSkapadEvent/s4:UtbildningstillfalleUID/text()]/s3:StudietaktID/text()"  />
      <ns0:KT>
        <xsl:value-of select="s3:Studietakter/s3:Studietakt[s8:ID/text()=$kurstaktId]/s3:Takt/text()" />
      </ns0:KT>
      <ns0:UF>
        <xsl:value-of select="$var:v2" />
      </ns0:UF>
      
      <xsl:variable name="ortsId" select="/s5:ForvantatDeltagandeSkapadEnvelope/s3:Utbildningstillfalle[s8:Uid/text()=/s5:ForvantatDeltagandeSkapadEnvelope/s4:ForvantatDeltagandeSkapadEvent/s4:UtbildningstillfalleUID/text()]/s3:StudielokaliseringID/text()"  />
      <ns0:KORT>
        <xsl:value-of select="s1:Studielokaliseringar/s1:Studielokalisering[s8:ID/text()=$ortsId]/s8:Kod/text()"  />
        </ns0:KORT>
      <xsl:variable name="finanskod" select="/s5:ForvantatDeltagandeSkapadEnvelope/s3:Utbildningstillfalle[s8:Uid/text()=/s5:ForvantatDeltagandeSkapadEnvelope/s4:ForvantatDeltagandeSkapadEvent/s4:UtbildningstillfalleUID/text()]/s3:Attributvarden[s3:Namn/text()='utbildning.attribut.finansieringsform']/s3:Varde/text()"/>
          <ns0:FIN>
         <xsl:value-of select="/s5:ForvantatDeltagandeSkapadEnvelope/s3:Finansieringsformer/s3:Finansieringsform[s8:ID/text()=$finanskod]/s8:Kod/text()" />
      </ns0:FIN>
       <xsl:variable name="programutbtillfalleId" select="/s5:ForvantatDeltagandeSkapadEnvelope/s4:ForvantatDeltagandeSkapadEvent/s4:PaketerandeUtbildningstillfalleUID/text()" />
       <xsl:variable name="programutbtillfalle" select="/s5:ForvantatDeltagandeSkapadEnvelope/s3:Utbildningstillfalle[s8:Uid/text()=$programutbtillfalleId]" />
    
      <ns0:PROGR>
        <xsl:choose>
          <xsl:when test="/s5:ForvantatDeltagandeSkapadEnvelope/s4:ForvantatDeltagandeSkapadEvent/s4:PaketerandeUtbildningstillfalleUID/text()">
            <xsl:variable name="programkod">
              <xsl:apply-templates select="/s5:ForvantatDeltagandeSkapadEnvelope/s3:Utbildningstillfalle[ScriptNS0:ListContainsValue('INT0017.Usmr.Events', 'Programtillfallestyper', s3:UtbildningstypID/text(), ',')]"/>
            </xsl:variable>
            <xsl:value-of select="$programkod" />
         </xsl:when>
          <xsl:otherwise>FRIST</xsl:otherwise>
        </xsl:choose>
      </ns0:PROGR>
     
      <ns0:AKT>
        <xsl:value-of select="$var:v2" />
      </ns0:AKT>
    
      <xsl:variable name="MinDate">
          <xsl:for-each select="/s5:ForvantatDeltagandeSkapadEnvelope/s3:Utbildningstillfalle[s8:Uid/text()=/s5:ForvantatDeltagandeSkapadEnvelope/s4:ForvantatDeltagandeSkapadEvent/s4:UtbildningstillfalleUID/text()]/s3:Tillfallesperioder">
          <xsl:sort select="./s3:ForstaUndervisningsdatum/text()"  order="ascending"/>
           <xsl:choose>
           <xsl:when test="position() = 1">
            <xsl:value-of select="./s3:ForstaUndervisningsdatum/text()" />
           </xsl:when>
          </xsl:choose>
         </xsl:for-each>
        </xsl:variable>
        
      <ns0:TERMIN>
         
          <xsl:value-of select="userCSharp:GetSemester($MinDate)" />
          
      </ns0:TERMIN>
      <ns0:PTAKT>
        <xsl:value-of select="$var:v2" />
      </ns0:PTAKT>
      <ns0:KAR>
        <xsl:value-of select="$var:v2" />
      </ns0:KAR>
      <ns0:TYP>
   
        <xsl:choose>
          <xsl:when test="/s5:ForvantatDeltagandeSkapadEnvelope/s4:ForvantatDeltagandeSkapadEvent/s4:PaketerandeUtbildningstillfalleUID/text()">P</xsl:when>
          <xsl:otherwise>J</xsl:otherwise>
        </xsl:choose>
      </ns0:TYP>
      <ns0:PLG>
        <xsl:value-of select="$var:v2" />
      </ns0:PLG>
    </ns0:uusmrCreateStudentRecord>
  


  </xsl:template>
  <xsl:template   match="s3:Utbildningstillfalle">
    <xsl:variable name="UtbildningsinstansUID" select="./s3:UtbildningsinstansUID/text()" />
    <xsl:apply-templates select="/s5:ForvantatDeltagandeSkapadEnvelope/s3:Utbildningsinstans[s8:Uid/text()=$UtbildningsinstansUID]"/>
  </xsl:template>

  <xsl:template match="s3:Utbildningsinstans">
    <xsl:variable name="prkod" select="./s3:Utbildningskod/text()"/>
      <xsl:value-of select="./s3:Utbildningskod/text()"/>
    
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp">
    <![CDATA[
 
 //aaaammddxxxx  -> aaaammdd-xxxx
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

public string StringTrimRight(string str)
{
	if (str == null)
	{
		return "";
	}
	return str.TrimEnd(null);
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
    
public string DateCurrentDate()
{
	DateTime dt = DateTime.Now;
	return dt.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
}

 



]]>
  </msxsl:script>
</xsl:stylesheet>