<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s7 s3 s4 s0 s5 s1 s6 s2 s8 s9 userCSharp ScriptNS0" version="1.0" xmlns:ns0="http://INT0011.VFU.Events.Schemas.VFU.Programdeltagande" xmlns:s7="http://schemas.ladok.se/dap" xmlns:s3="http://schemas.ladok.se/studentinformation" xmlns:s4="http://schemas.ladok.se/events" xmlns:s0="http://ladok.uu.envelope.vfu.schema" xmlns:s5="http://ladok.uu.envelope.schemas" xmlns:s1="http://schemas.microsoft.com/BizTalk/2003/aggschema" xmlns:s6="http://schemas.ladok.se" xmlns:s2="http://schemas.ladok.se/studiedeltagande" xmlns:s8="http://schemas.ladok.se/utbildningsinformation" xmlns:s9="http://UU.Integrations.Common.Schemas" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s1:Root" />
  </xsl:template>
  <xsl:template match="/s1:Root">
    <xsl:variable name="var:v7" select="userCSharp:StringTrimRight(&quot;Antagen&quot;)" />
    <xsl:variable name="var:v8" select="userCSharp:StringTrimRight(&quot;INT0011.VFU.Events&quot;)" />
    <xsl:variable name="var:v9" select="userCSharp:StringTrimRight(&quot;password&quot;)" />
    
    <xsl:variable name="forstaundervisningsdatum">

      <xsl:for-each select="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/s5:AterkalladOmregistreringEnvelope/s8:Utbildningstillfalle/s8:Tillfallesperioder">

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
      <xsl:for-each select="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/s5:AterkalladOmregistreringEnvelope/s3:Kontaktuppgifter/s3:Postadresser">
        <address>
          <xsl:if test="s3:Postort">
            <city>
              <xsl:value-of select="s3:Postort/text()" />
            </city>
          </xsl:if>
          <xsl:if test="s3:Postnummer">
            <zipcode>
              <xsl:value-of select="s3:Postnummer/text()" />
            </zipcode>
          </xsl:if>
          <xsl:if test="s3:Utdelningsadress">
            <zipcode>
              <xsl:value-of select="s3:Utdelningsadress/text()" />
            </zipcode>
          </xsl:if>
        </address>
      </xsl:for-each>
      <xsl:for-each select="InputMessagePart_0/ActiveDirectoryQueryResults/FilterMatch">
        <xsl:for-each select="Property">
          <xsl:variable name="var:v1" select="userCSharp:LogicalEq(string(@Name) , &quot;cn&quot;)" />
          <xsl:if test="string($var:v1)='true'">
            <xsl:variable name="var:v2" select="@Value" />
            <cas>
              <xsl:value-of select="$var:v2" />
            </cas>
          </xsl:if>
        </xsl:for-each>
      </xsl:for-each>
      <xsl:if test="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/s5:AterkalladOmregistreringEnvelope/s3:Kontaktuppgifter/s3:Telefonnummer">
        <cellular>
          <xsl:value-of select="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/s5:AterkalladOmregistreringEnvelope/s3:Kontaktuppgifter/s3:Telefonnummer/text()" />
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
      <xsl:if test="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/s5:AterkalladOmregistreringEnvelope/s3:Student/s3:Fornamn">
        <firstname>
          <xsl:value-of select="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/s5:AterkalladOmregistreringEnvelope/s3:Student/s3:Fornamn/text()" />
        </firstname>
      </xsl:if>
      <xsl:variable name="var:v6" select="userCSharp:kull(string($forstaundervisningsdatum))" />
      <kull>
        <xsl:value-of select="$var:v6" />
      </kull>
      <xsl:if test="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/s5:AterkalladOmregistreringEnvelope/s3:Kontaktuppgifter/s3:Telefonnummer">
        <phone>
          <xsl:value-of select="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/s5:AterkalladOmregistreringEnvelope/s3:Kontaktuppgifter/s3:Telefonnummer/text()" />
        </phone>
      </xsl:if>
      <xsl:if test="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/s5:AterkalladOmregistreringEnvelope/s3:Student/s3:Personnummer">
        <pnr>
          <xsl:value-of select="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/s5:AterkalladOmregistreringEnvelope/s3:Student/s3:Personnummer/text()" />
        </pnr>
      </xsl:if>
      <program>
        <xsl:value-of select="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/Utbildningskod/text()" />
      </program>
      <xsl:if test="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/s5:AterkalladOmregistreringEnvelope/s8:Utbildningsinstans/s8:Utbildningskod">
        <programdir>
          <xsl:value-of select="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/s5:AterkalladOmregistreringEnvelope/s8:Utbildningsinstans/s8:Utbildningskod/text()" />
        </programdir>
      </xsl:if>
      <xsl:if test="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/s5:AterkalladOmregistreringEnvelope/s3:Student/s3:Efternamn">
        <surname>
          <xsl:value-of select="InputMessagePart_1/s0:AterkalladOmregistreringEnvelope_VFU/s5:AterkalladOmregistreringEnvelope/s3:Student/s3:Efternamn/text()" />
        </surname>
      </xsl:if>
      <type>
        <xsl:value-of select="$var:v7" />
      </type>
      <xsl:variable name="var:v10" select="ScriptNS0:ReadValue(string($var:v8) , string($var:v9))" />
      <password>
        <xsl:value-of select="$var:v10" />
      </password>
      <xsl:variable name="var:v12" select="userCSharp:startsemester($var:v11)" />
      <startsemester>
        <xsl:value-of select="$var:v12" />
      </startsemester>
    </ns0:Root>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp"><![CDATA[
public string StringTrimRight(string str)
{
	if (str == null)
	{
		return "";
	}
	return str.TrimEnd(null);
}


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


///*Uncomment the following code for a sample Inline C# function
//that concatenates two inputs. Change the number of parameters of
//this function to be equal to the number of inputs connected to this functoid.*/

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