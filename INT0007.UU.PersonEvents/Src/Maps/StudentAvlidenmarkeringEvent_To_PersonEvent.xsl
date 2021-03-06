<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
                xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s3 s0 s2 s1 ns9 csharp" 
  version="1.0" xmlns:ns0="http://UU.Integrations.Common.Schemas.InternalPersonEvent" xmlns:s3="http://schemas.ladok.se/studentinformation" 
  xmlns:s0="http://schemas.ladok.se/events" xmlns:s1="http://schemas.ladok.se" xmlns:s2="http://schemas.ladok.se/dap" 
                xmlns:uuii="http://UU.Integrations.Common.Schemas.Internal.Person"
                xmlns:csharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp"
                xmlns:ns9="http://ladok.uu.envelope.schemas">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/ns9:StudentAvlidenmarkeringEnvelope/s3:StudentAvlidenmarkeringEvent" />
  </xsl:template>
  <xsl:template match="/ns9:StudentAvlidenmarkeringEnvelope/s3:StudentAvlidenmarkeringEvent">
    <ns0:PersonEvent>
      <xsl:attribute name="type">
        <xsl:choose>
          <xsl:when test="s3:avliden = 'true'">
            <xsl:text>PersonStudentDeceasedEvent</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>PersonStudentDeceasedRetractionEvent</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <ns0:IssuedTime>
        <xsl:value-of select="csharp:DateCurrentDateTime()" />
      </ns0:IssuedTime>
      <ns0:Producer>
        <xsl:value-of select="s0:EventContext/s0:Anvandarnamn/text()"/>
      </ns0:Producer>
      <ns0:ProducerReferenceId>
        <xsl:value-of select="s0:HandelseUID/text()"/>
      </ns0:ProducerReferenceId>
      <uuii:Person>
        <xsl:if test="s3:StudentUID">
          <xsl:attribute name="identifier">
            <xsl:value-of select="s3:StudentUID/text()" />
          </xsl:attribute>
        </xsl:if>
		<uuii:PersonNumber>
			<xsl:text>0</xsl:text>
		</uuii:PersonNumber>
      </uuii:Person>
    </ns0:PersonEvent>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="csharp">

    <![CDATA[


public string DateCurrentDateTime()
{
	DateTime dt = DateTime.Now;
	string curdate = dt.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
	string curtime = dt.ToString("T", System.Globalization.CultureInfo.InvariantCulture);
	string retval = curdate + "T" + curtime;
	return retval;
}



]]>
  </msxsl:script>
</xsl:stylesheet>