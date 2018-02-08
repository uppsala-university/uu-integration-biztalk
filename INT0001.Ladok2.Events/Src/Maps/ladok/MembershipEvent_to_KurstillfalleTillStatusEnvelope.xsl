<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" 
                exclude-result-prefixes="msxsl var s0 userCSharp ScriptNS0" version="1.0" xmlns:ns1="http://schemas.ladok.se/events" xmlns:si="http://schemas.ladok.se/studentinformation" 
                xmlns:ui="http://schemas.ladok.se/utbildningsinformation" xmlns:ns0="http://ladok.uu.envelope.schemas" xmlns:ns2="http://schemas.ladok.se"
  xmlns:sd="http://schemas.ladok.se/studiedeltagande" xmlns:s0="http://schemas.microsoft.com/Sql/2008/05/TypedPolling/ladokevents" xmlns:ns3="http://schemas.ladok.se/dap"
                xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp"
                 xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s0:TypedPollingResultSet0" />
  </xsl:template>
  <xsl:template match="/s0:TypedPollingResultSet0">
    <ns0:KurstillfalleTillStatusEnvelope>
      <ui:KurstillfalleTillStatusEvent>
        <ns1:EventContext>
          <ns1:Anvandarnamn>
            <xsl:text>uppdok</xsl:text>
          </ns1:Anvandarnamn>
        </ns1:EventContext>
          <ns1:HandelseUID>
            <xsl:value-of select="s0:Id/text()" />
          </ns1:HandelseUID>
        <ui:Status>
          <xsl:text>2</xsl:text>
        </ui:Status>
        <xsl:if test="s0:reportCode">
          <ui:Utbildningstillfalleskod>
            <xsl:value-of select="s0:reportCode/text()" />
          </ui:Utbildningstillfalleskod>
        </xsl:if>
        <ui:Kurstillfallesperioder>
          <ui:ForstaUndervisningsdatum>
            <xsl:value-of select="userCSharp:SemesterToDate(string(s0:startSemester/text()))" />
          </ui:ForstaUndervisningsdatum>
        </ui:Kurstillfallesperioder>
      </ui:KurstillfalleTillStatusEvent>
      <xsl:variable name="CourseDescriptions" select="ScriptNS0:GetCourseDescriptions(s0:courseCode/text())" />
      <ui:Utbildningsinstans>
          <ui:Benamningar>
            <ns2:Benamning>
              <ns2:Sprakkod>
                <xsl:text>sv</xsl:text>
              </ns2:Sprakkod>
              <ns2:Text>
                <xsl:value-of select="substring-before($CourseDescriptions,'~')" />
              </ns2:Text>
            </ns2:Benamning>
            <ns2:Benamning>
              <ns2:Sprakkod>
                <xsl:text>en</xsl:text>
              </ns2:Sprakkod>
              <ns2:Text>
                <xsl:value-of select="substring-after($CourseDescriptions,'~')" />
              </ns2:Text>
            </ns2:Benamning>
          </ui:Benamningar>
            <ui:Utbildningskod>
              <xsl:value-of select="s0:courseCode/text()"/>
            </ui:Utbildningskod>
      </ui:Utbildningsinstans>
    </ns0:KurstillfalleTillStatusEnvelope>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp"><![CDATA[
public DateTime SemesterToDate(string semester)
{
  return DateTime.ParseExact(semester, "yyyyM", null);
}

public string MathInt(string val)
{
	string retval = "";
	double d = 0;
	if (IsNumeric(val, ref d))
	{
		try
		{
			int i = Convert.ToInt32(d, System.Globalization.CultureInfo.InvariantCulture);
			if (i > d)
			{
				i = i-1;
			}
			retval = i.ToString(System.Globalization.CultureInfo.InvariantCulture);
		}
		catch (Exception)
		{
		}
	}
	return retval;
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