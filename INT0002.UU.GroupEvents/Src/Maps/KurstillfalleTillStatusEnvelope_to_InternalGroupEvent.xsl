<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" 
  exclude-result-prefixes="msxsl var s5 s0 s1 s4 base s3 s6 userCSharp ScriptNS0" version="1.0" xmlns:uuii="http://UU.Integrations.Common.Schemas.Internal.Identity" 
  xmlns:uuig="http://UU.Integrations.Common.Schemas.Internal.Group" xmlns:s3="http://schemas.ladok.se/studiedeltagande" 
  xmlns:s0="http://schemas.ladok.se/studentinformation" xmlns:s1="http://schemas.ladok.se/utbildningsinformation" xmlns:s5="http://schemas.ladok.se/events" 
  xmlns:s4="http://ladok.uu.envelope.schemas" xmlns:ns0="http://UU.Integrations.Common.Schemas.InternalGroupEvent" xmlns:base="http://schemas.ladok.se" 
  xmlns:s6="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s4:KurstillfalleTillStatusEnvelope" />
  </xsl:template>
  <xsl:template match="/s4:KurstillfalleTillStatusEnvelope">
    <xsl:variable name="ForstaUndervisningsdatum" select="s1:KurstillfalleTillStatusEvent/s1:Kurstillfallesperioder[1]/s1:ForstaUndervisningsdatum/text()" />
    <ns0:GroupEvent>
      <xsl:attribute name="type">
        <xsl:text>GroupCreateRequestEvent</xsl:text>
      </xsl:attribute>
      <ns0:IssuedTime>
        <xsl:value-of select="userCSharp:DateCurrentDateTime()" />
      </ns0:IssuedTime>
      <ns0:Producer>
        <xsl:value-of select="s1:KurstillfalleTillStatusEvent/s5:EventContext/s5:Anvandarnamn/text()" />
      </ns0:Producer>
      <ns0:ProducerReferenceId>
        <xsl:value-of select="s1:KurstillfalleTillStatusEvent/s5:HandelseUID/text()" />
      </ns0:ProducerReferenceId>
      <uuig:Group>
        <xsl:attribute name="type">
          <xsl:text>CourseInstanceGroup</xsl:text>
        </xsl:attribute>
         <xsl:attribute name="organisation">
         <xsl:value-of select="base:Organisation/base:Kod" />
      </xsl:attribute>  
        <xsl:attribute name="course">
         <xsl:value-of select="s1:Utbildningsinstans/s1:Utbildningskod" />
      </xsl:attribute>
        <uuig:Id>
          <xsl:value-of select="concat(ScriptNS0:Semester($ForstaUndervisningsdatum , 'yyyyM') , '_' , s1:KurstillfalleTillStatusEvent/s1:Utbildningstillfalleskod/text())" />
        </uuig:Id>
        <uuig:Names>
          <xsl:for-each select="s1:Utbildningsinstans/s1:Benamningar">
            <xsl:for-each select="base:Benamning">
              <uuig:Name>
                <xsl:if test="base:Sprakkod">
                  <xsl:attribute name="lang">
                    <xsl:value-of select="base:Sprakkod/text()" />
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="base:Text">
                  <xsl:value-of select="base:Text/text()" />
                </xsl:if>
              </uuig:Name>
            </xsl:for-each>
          </xsl:for-each>
        </uuig:Names>
        <uuig:Semesters>
          <xsl:apply-templates select="s1:KurstillfalleTillStatusEvent/s1:Kurstillfallesperioder"/>
        </uuig:Semesters>
        <uuig:Description>
          <xsl:value-of select="../../s1:Utbildningsinstans/s1:Benamningar/s5:Benamning[s5:Sprakkod='sv']/s5:Text" />
        </uuig:Description>
        <uuig:Type>
         <xsl:text>Kurstillfalle</xsl:text>
        </uuig:Type>
      </uuig:Group>
    </ns0:GroupEvent>
  </xsl:template>
  <xsl:template match="s1:Kurstillfallesperioder">
     <xsl:variable name="semester" select="ScriptNS0:Semester(s1:ForstaUndervisningsdatum/text() ,'yyyyM')" />
    
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