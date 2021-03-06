<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" 
                exclude-result-prefixes="msxsl var s4 s0 s1 s3 base s2 s6 userCSharp ScriptNS0" version="1.0" xmlns:base="http://schemas.ladok.se" 
                xmlns:uuii="http://UU.Integrations.Common.Schemas.Internal.Identity" xmlns:uuig="http://UU.Integrations.Common.Schemas.Internal.Group" 
  xmlns:s4="http://schemas.ladok.se/events" xmlns:s0="http://schemas.ladok.se/studentinformation" xmlns:s1="http://schemas.ladok.se/utbildningsinformation" 
                xmlns:s3="http://ladok.uu.envelope.schemas" xmlns:ns0="http://UU.Integrations.Common.Schemas.InternalGroupEvent" 
                xmlns:s2="http://schemas.ladok.se/studiedeltagande" xmlns:s6="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" 
                xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s3:OmregistreringEnvelope" />
  </xsl:template>
  <xsl:template match="/s3:OmregistreringEnvelope">
    <ns0:GroupEvent>
      <xsl:attribute name="type">
       <xsl:text>GroupMembershipCreateRequestEvent</xsl:text>
      </xsl:attribute>
      <ns0:IssuedTime>
        <xsl:value-of select="userCSharp:DateCurrentDateTime()" />
      </ns0:IssuedTime>
      <ns0:Producer>
        <xsl:value-of select="s2:OmregistreringEvent/s4:EventContext/s4:Anvandarnamn/text()" />
      </ns0:Producer>
      <ns0:ProducerReferenceId>
        <xsl:value-of select="s2:OmregistreringEvent/s4:HandelseUID/text()" />
      </ns0:ProducerReferenceId>
      <xsl:variable name="KurstillfalleUID" select="s2:OmregistreringEvent/s2:KurstillfalleUID"/>
      <xsl:apply-templates  select="s1:Utbildningstillfalle[base:Uid = $KurstillfalleUID]"/>
      <ns0:GroupEventData>
        <uuii:NewMember>
          <xsl:attribute name="identifier">
            <xsl:value-of select="s0:Student/base:Uid/text()|s0:Student/s0:Personnummer/text()" />
          </xsl:attribute>
          <xsl:if test="s0:Student/s0:Personnummer">
            <uuii:PersonNumber>
              <xsl:value-of select="s0:Student/s0:Personnummer/text()" />
            </uuii:PersonNumber>
          </xsl:if>
          <xsl:if test="s0:Student/s0:Fornamn">
            <uuii:Fornamn>
              <xsl:value-of select="s0:Student/s0:Fornamn/text()" />
            </uuii:Fornamn>
          </xsl:if>
          <xsl:if test="s0:Student/s0:Efternamn">
            <uuii:Efternamn>
              <xsl:value-of select="s0:Student/s0:Efternamn/text()" />
            </uuii:Efternamn>
          </xsl:if>
        </uuii:NewMember>
      </ns0:GroupEventData>
    </ns0:GroupEvent>
  </xsl:template>
  <xsl:template name="Group" match="s1:Utbildningstillfalle">
        <uuig:Group>
          <xsl:attribute name="type">
            <xsl:text>StudentGroup</xsl:text>
          </xsl:attribute>
          <xsl:variable name="date" select="ScriptNS0:Semester(string(s1:Tillfallesperioder/s1:ForstaUndervisningsdatum/text()) , 'yyyyM')" />
          
          <xsl:if test="not(s1:Tillfalleskod/text())">
            <xsl:message terminate="yes"><xsl:text>Tillfalleskod is missing for Utbildningstillfalle</xsl:text></xsl:message>
            </xsl:if>
          <uuig:Id>
            <xsl:value-of  select="userCSharp:StringConcat($date , '_' , string(s1:Tillfalleskod/text()))" />
          </uuig:Id>
          <uuig:Names>
            <uuig:Name>
              <xsl:text>ladok</xsl:text>
            </uuig:Name>
          </uuig:Names>
          <uuig:Semesters>
            <xsl:attribute name="start">
              <xsl:value-of select="$date" />
            </xsl:attribute>
            <uuig:Semester>
              <xsl:text />
            </uuig:Semester>
          </uuig:Semesters>
          <uuig:Description>
            <xsl:text />
          </uuig:Description>
          <uuig:Type>
            <xsl:text>Omregistrering</xsl:text>
          </uuig:Type>
        </uuig:Group>
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


public string DateCurrentDateTime()
{
	DateTime dt = DateTime.Now;
	string curdate = dt.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
	string curtime = dt.ToString("T", System.Globalization.CultureInfo.InvariantCulture);
	string retval = curdate + "T" + curtime;
	return retval;
}


public string StringConcat(string param0, string param1, string param2)
{
   return param0 + param1 + param2;
}



]]></msxsl:script>
</xsl:stylesheet>