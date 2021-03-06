<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" 
  exclude-result-prefixes="msxsl var s5 s8 s0 s1 s7 s2 s4 s3 s6 s9 userCSharp ScriptNS0" version="1.0" xmlns:s3="http://schemas.ladok.se" 
  xmlns:s2="http://schemas.ladok.se/utbildningsinformation" xmlns:s9="http://schemas.ladok.se/dap" xmlns:s7="http://schemas.ladok.se/studentinformation" 
  xmlns:s1="http://schemas.ladok.se/kataloginformation" xmlns:uuig="http://UU.Integrations.Common.Schemas.Internal.Group" xmlns:s6="http://schemas.ladok.se/studiedeltagande" 
                xmlns:s4="http://ladok.uu.envelope.schemas" xmlns:s8="http://schemas.ladok.se/events" xmlns:s0="http://UU.Integrations.Common.Schemas" 
                xmlns:s5="http://schemas.ladok.se/avisering" xmlns:uuii="http://UU.Integrations.Common.Schemas.Internal.Identity" 
                xmlns:ns0="http://UU.Integrations.Common.Schemas.InternalGroupEvent" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" 
                xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s4:KurstillfalleTillStatusEnvelope" />
  </xsl:template>
  <xsl:template match="/s4:KurstillfalleTillStatusEnvelope">
    <xsl:variable name="ForstaUndervisningsdatum" select="s2:KurstillfalleTillStatusEvent/s2:Kurstillfallesperioder[1]/s2:ForstaUndervisningsdatum/text()" />
    
    <ns0:GroupEvent>
      <xsl:attribute name="type">
        <xsl:text>GroupCreateRequestEvent</xsl:text>
      </xsl:attribute>
      <ns0:IssuedTime>
        <xsl:value-of select="userCSharp:DateCurrentDateTime()" />
      </ns0:IssuedTime>
      <ns0:Producer>
        <xsl:value-of select="s2:KurstillfalleTillStatusEvent/s8:EventContext/s8:Anvandarnamn/text()" />
      </ns0:Producer>
      <ns0:ProducerReferenceId>
        <xsl:value-of select="s2:KurstillfalleTillStatusEvent/s8:HandelseUID/text()" />
      </ns0:ProducerReferenceId>
      <uuig:Group>
        <xsl:attribute name="type">
          <xsl:text>CourseInstanceGroup</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="organisation">
          <xsl:value-of select="s1:Organisation/s1:Organisationskod/text()" />
        </xsl:attribute>
        <xsl:attribute name="course">
          <xsl:value-of select="s2:Utbildningsinstans/s2:Utbildningskod" />
        </xsl:attribute>
       <uuig:Id>
         <xsl:value-of select="concat(ScriptNS0:Semester($ForstaUndervisningsdatum , 'yyyyM') , '_' , s2:KurstillfalleTillStatusEvent/s2:Utbildningstillfalleskod/text())" />
        </uuig:Id>
        <uuig:Names>
          <xsl:for-each select="s2:Utbildningsinstans/s2:Benamningar">
            <xsl:for-each select="s3:Benamning">
              <uuig:Name>
                <xsl:if test="s3:Sprakkod">
                  <xsl:attribute name="lang">
                    <xsl:value-of select="s3:Sprakkod/text()" />
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="s3:Text">
                  <xsl:value-of select="s3:Text/text()" />
                </xsl:if>
              </uuig:Name>
            </xsl:for-each>
          </xsl:for-each>
        </uuig:Names>
        <uuig:Semesters>
          <xsl:apply-templates select="s2:KurstillfalleTillStatusEvent/s2:Kurstillfallesperioder"/>
        </uuig:Semesters>
        <uuig:Description>
          <xsl:value-of select="s2:Utbildningsinstans/s2:Benamningar/s3:Benamning[s3:Sprakkod='sv']/s3:Text" />
        </uuig:Description>
        <uuig:Type>
          <xsl:text>Kurstillfalle</xsl:text>
        </uuig:Type>
      </uuig:Group>
    </ns0:GroupEvent>
  </xsl:template>
  
  <xsl:template match="s2:Kurstillfallesperioder">
    <xsl:variable name="semester" select="ScriptNS0:Semester(s2:ForstaUndervisningsdatum/text() ,'yyyyM')" />

    <xsl:if test="position() = 1">
      <xsl:attribute name="start">
        <xsl:value-of select="$semester" />
      </xsl:attribute>
    </xsl:if>

    <uuig:Semester>
      <xsl:value-of select="$semester" />
    </uuig:Semester>

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