<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s10 s7 s3 s4 s0 s5 s1 s6 s2 s8 s9 userCSharp ScriptNS0" version="1.0" xmlns:ns0="http://INT0011.VFU.Events.Schemas.VFU.Programdeltagande" xmlns:s10="http://cxf.akkaappl.akka.its.uu.se/" xmlns:s7="http://schemas.ladok.se/dap" xmlns:s3="http://schemas.ladok.se/studentinformation" xmlns:s4="http://schemas.ladok.se/events" xmlns:s0="http://ladok.uu.envelope.vfu.schema" xmlns:s5="http://ladok.uu.envelope.schemas" xmlns:s1="http://schemas.microsoft.com/BizTalk/2003/aggschema" xmlns:s6="http://schemas.ladok.se" xmlns:s2="http://schemas.ladok.se/studiedeltagande" xmlns:s8="http://schemas.ladok.se/utbildningsinformation" xmlns:s9="http://UU.Integrations.Common.Schemas" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s1:Root" />
  </xsl:template>
  <xsl:template match="/s1:Root">
    <xsl:variable name="KurspaketeringUID" select="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s2:AvbrottEvent/s2:InomKurspaketeringstillfalle/s2:KurspaketeringUID/text()" />
    <xsl:variable name="UtbildningsinstansUID" select="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s2:AvbrottEvent/s2:UtbildningsinstansUID/text()" />
    <xsl:variable name="programinriktning">
      <xsl:apply-templates select="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s7:AvbrottEnvelope/s10:Utbildningsinstans[ScriptNS0:ListContainsValue('INT0011.VFU.Events', 'Programinriktningstyper', s10:UtbildningstypID/text(), ',')]"/>
    </xsl:variable>    
    <!--<xsl:variable name="programinriktning" select="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s8:Utbildningsinstans[s8:UtbildningUID/text()=$KurspaketeringUID]/s8:Utbildningskod/text()" />-->
    <xsl:variable name="forstaundervisningsdatum">
      <xsl:for-each select="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s8:Utbildningstillfalle/s8:Tillfallesperioder">
        <xsl:sort select="./s8:ForstaUndervisningsdatum/text()"  order="ascending"/>
        <xsl:choose>
          <xsl:when test="position() = 1">
            <xsl:value-of select="./s8:ForstaUndervisningsdatum/text()" />
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>      
      </xsl:variable>
      <xsl:variable name="var:v11" select="string($forstaundervisningsdatum)" />
    
    <ns0:Root>
      <eventname>
         <xsl:text>AvbrottEvent</xsl:text>
      </eventname>
      <eventuid>
        <xsl:value-of select="//s4:HandelseUID/text()" />
      </eventuid>
        <address>
            <city>
              <xsl:value-of select="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s3:Kontaktuppgifter/s3:Postadresser/s3:Postort/text()" />
            </city>
            <street>
              <xsl:value-of select="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s3:Kontaktuppgifter/s3:Postadresser/s3:Utdelningsadress/text()" />
            </street>
            <zipcode>
              <xsl:value-of select="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s3:Kontaktuppgifter/s3:Postadresser/s3:Postnummer/text()" />
            </zipcode>
        </address>
      <cas>
        <xsl:value-of select="string(InputMessagePart_2/s10:getSenastEtableradeKontokatalogResponse/return/anvid/text())" />
      </cas>
      <xsl:if test="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s3:Kontaktuppgifter/s3:Telefonnummer">
        <cellular>
          <xsl:value-of select="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s3:Kontaktuppgifter/s3:Telefonnummer/text()" />
        </cellular>
      </xsl:if>
      <xsl:for-each select="InputMessagePart_0/ActiveDirectoryQueryResults/FilterMatch">
        <xsl:for-each select="Property">
          <xsl:variable name="var:v3" select="string(@Name)" />
          <xsl:variable name="var:v4" select="userCSharp:LogicalEq($var:v3 , &quot;mail&quot;)" />
          <xsl:if test="string($var:v4)='true'">
            <xsl:variable name="var:v5" select="@Value" />
            <email>
              <xsl:value-of select="$var:v5" />
            </email>
          </xsl:if>
        </xsl:for-each>
      </xsl:for-each>
      <xsl:if test="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s3:Student/s3:Fornamn">
        <firstname>
          <xsl:value-of select="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s3:Student/s3:Fornamn/text()" />
        </firstname>
      </xsl:if>
      <kull>
        <xsl:value-of select="userCSharp:kull($forstaundervisningsdatum)" />
      </kull>
      <xsl:if test="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s3:Kontaktuppgifter/s3:Telefonnummer">
        <phone>
          <xsl:value-of select="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s3:Kontaktuppgifter/s3:Telefonnummer/text()" />
        </phone>
      </xsl:if>
      <xsl:if test="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s3:Student/s3:Personnummer">
        <pnr>
          <xsl:value-of select="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s3:Student/s3:Personnummer/text()" />
        </pnr>
      </xsl:if>
      <program>
        <xsl:value-of select="InputMessagePart_1/s0:AvbrottEnvelope_VFU/Utbildningskod/text()" />
      </program>
      <xsl:if test="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s8:Utbildningsinstans/s8:Utbildningskod">
        <programdir>
          <xsl:choose>
            <xsl:when test="$programinriktning != ''">
              <xsl:value-of select="$programinriktning" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="' '" />
            </xsl:otherwise>
          </xsl:choose>
        </programdir>
      </xsl:if>
      <xsl:if test="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s3:Student/s3:Efternamn">
        <surname>
          <xsl:value-of select="InputMessagePart_1/s0:AvbrottEnvelope_VFU/s5:AvbrottEnvelope/s3:Student/s3:Efternamn/text()" />
        </surname>
      </xsl:if>
      <type>
        <xsl:text>Studieavbrott</xsl:text>
      </type>
      <password>
        <xsl:value-of select="ScriptNS0:ReadValue('INT0011.VFU.Events' , 'password')" />
      </password>
      <startsemester>
        <xsl:value-of select="userCSharp:startsemester($var:v11)" />
      </startsemester>
    </ns0:Root>
  </xsl:template>
  <xsl:template match="s10:Utbildningsinstans">
    <xsl:value-of select="./s10:Utbildningskod/text()"/>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp">
  <![CDATA[
public bool LogicalEq(string val1, string val2)
{
	bool ret = false;
	double d1 = 0;
	double d2 = 0;
	if (IsNumeric(val1, ref d1) && IsNumeric(val2, ref d2))
	{
		ret = d1 == d2;
	}
	else
	{
		ret = String.Compare(val1, val2, StringComparison.Ordinal) == 0;
	}
	return ret;
}

public string startsemester(string param1)
{
            string semester = "";
            string yr = DateTime.Parse(param1).Year.ToString();
            int mm = DateTime.Parse(param1).Month;
            if (mm < 7)
            {
                semester = yr + "1";
            }
            else
            {
                semester = yr + "2";
            }   
return semester;
}

public string kull(string param1)
{
            string semester = "";
            string yr = DateTime.Parse(param1).Year.ToString();
            int mm = DateTime.Parse(param1).Month;
            if (mm < 7)
            {
                semester = "VT" + yr;
            }
            else
            {
                semester = "HT" + yr;
            }   
return semester;
}

public bool IsNumeric(string val)
{
	if (val == null)
	{
		return false;
	}
	double d = 0;
	return Double.TryParse(val, System.Globalization.NumberStyles.AllowThousands | System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out d);
}

public bool IsNumeric(string val, ref double d)
{
	if (val == null)
	{
		return false;
	}
	return Double.TryParse(val, System.Globalization.NumberStyles.AllowThousands | System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out d);
}


]]></msxsl:script>
</xsl:stylesheet>