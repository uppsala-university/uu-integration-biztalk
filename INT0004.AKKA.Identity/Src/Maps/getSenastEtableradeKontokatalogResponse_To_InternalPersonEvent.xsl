<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s0 s1 userCSharp" version="1.0" xmlns:s0="http://call.authsrv.its.uu.se/" xmlns:ns0="http://UU.Integrations.Common.Schemas.InternalPersonEvent" xmlns:s1="http://cxf.akkaappl.akka.its.uu.se/" xmlns:uuii="http://UU.Integrations.Common.Schemas.Internal.Person" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s1:getSenastEtableradeKontokatalogResponse" />
  </xsl:template>
  <xsl:template match="/s1:getSenastEtableradeKontokatalogResponse">
    <ns0:PersonEvent>
      <xsl:attribute name="type">
        <xsl:text>PersonStudentActiveAccountResponse</xsl:text>
      </xsl:attribute>
      <ns0:IssuedTime>
        <xsl:value-of select="userCSharp:DateCurrentDateTime()" />
      </ns0:IssuedTime>
      <ns0:Producer>
        <xsl:text>AKKA</xsl:text>
      </ns0:Producer>
      <ns0:ProducerReferenceId>
        <xsl:value-of select="msxsl:Read('ProducerReferenceId','https://INT0004.AKKA.Identity.Schemas.PersonEvents.PersonEvent_PropertySchema')" />
      </ns0:ProducerReferenceId>
      <uuii:Person>
        <xsl:attribute name="identifier">
          <xsl:value-of select="normalize-space(return/anvid/text())" />
        </xsl:attribute>
        <uuii:PersonNumber>
          <xsl:text />
        </uuii:PersonNumber>
      </uuii:Person>
    </ns0:PersonEvent>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp"><![CDATA[
public string DateCurrentDateTime()
{
	DateTime dt = DateTime.Now;
	string curdate = dt.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
	string curtime = dt.ToString("T", System.Globalization.CultureInfo.InvariantCulture);
	string retval = curdate + "T" + curtime;
	return retval;
}



]]></msxsl:script>
</xsl:stylesheet>