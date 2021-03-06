<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
                xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s0 s3 s2 s1 userCSharp ScriptNS0" 
                version="1.0" xmlns:uuii="http://UU.Integrations.Common.Schemas.Internal.Identity" 
                xmlns:uuig="http://UU.Integrations.Common.Schemas.Internal.Group" 
                xmlns:s0="http://schemas.ladok.se/events" xmlns:s2="http://schemas.ladok.se/dap" 
                xmlns:ns0="http://UU.Integrations.Common.Schemas.InternalGroupEvent" 
                xmlns:s1="http://schemas.ladok.se" xmlns:s3="http://schemas.ladok.se/utbildningsinformation" 
                xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" 
                xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s3:KurstillfalleTillStatusEvent" />
  </xsl:template>
  <xsl:template match="/s3:KurstillfalleTillStatusEvent">
  
    <ns0:GroupEvent>
      <xsl:attribute name="type">
        <xsl:text>GroupCreateRequestEvent</xsl:text>
      </xsl:attribute>
      <ns0:IssuedTime>
        <xsl:value-of select="userCSharp:DateCurrentDateTime()"/>
      </ns0:IssuedTime>
      <ns0:Producer>
        <xsl:text>ladok</xsl:text>
      </ns0:Producer>
      <!--
      <ns0:ProducerReferenceId>
        <xsl:value-of select="s3:UtbildningsinstansUID/text()"/>
      </ns0:ProducerReferenceId>
      -->
     <ns0:ProducerReferenceId>
        <xsl:value-of select="s0:HandelseUID/text()"/>
      </ns0:ProducerReferenceId>
      <uuig:Group>
        <xsl:attribute name="type">
          <xsl:text>CourseInstanceGroup</xsl:text>
        </xsl:attribute>

        <uuig:Id>
          <xsl:value-of select="concat(s3:StartperiodID/text(),'_',s3:Utbildningstillfalleskod/text())" />
        </uuig:Id>
  
         <xsl:variable name="CourseDescriptions" select="ScriptNS0:GetCourseDescriptions(s3:UtbildningsinstansUID/text())" />
          <uuig:Names>
            <uuig:Name>
              <xsl:attribute name="lang">
                <xsl:text>SV</xsl:text>
              </xsl:attribute>
              <xsl:value-of select="substring-before($CourseDescriptions,'~')" />
            </uuig:Name>
            <uuig:Name>
              <xsl:attribute name="lang">
                <xsl:text>EN</xsl:text>
              </xsl:attribute>
              <xsl:value-of select="substring-after($CourseDescriptions,'~')" />
            </uuig:Name>
          </uuig:Names>
      
        <xsl:variable name="Semesters" select="ScriptNS0:GetSemesters(s3:StartperiodID/text() , s3:Utbildningstillfalleskod/text())" />
        <xsl:call-template name="WritePropertyNodeTemplate">
          <xsl:with-param name="GetDB" select="$Semesters" />
          <xsl:with-param name ="StartSemester" select="s3:StartperiodID/text()"/>
        </xsl:call-template>
        <uuig:Description/>
        <uuig:Type>
          <xsl:text>Kurstillfalle</xsl:text>
        </uuig:Type>
      </uuig:Group>
    </ns0:GroupEvent>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp">
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
  <xsl:template name="WritePropertyNodeTemplate">
<xsl:param name="GetDB" />
<xsl:param name="StartSemester" />
<!-- create property node -->
<xsl:element name="uuig:Semesters">
  <xsl:attribute name="start">
    <xsl:value-of select="$StartSemester"/>
  </xsl:attribute>
<!-- create single instance children nodes -->
<!-- call splitter template which accepts the "|" separated string -->
<xsl:call-template name="StringSplit">
  <xsl:with-param name="val" select="$GetDB" />
</xsl:call-template>
  
</xsl:element>
    
</xsl:template>
  <xsl:template name="StringSplit">
<xsl:param name="val" />
<!-- do a check to see if the input string (still) has a "|" in it -->
<xsl:choose>
  <xsl:when test="contains($val, '~')">
   <!-- pull out the value of the string before the "|" delimiter -->
   <xsl:element name="uuig:Semester">
     <xsl:value-of select="substring-before($val, '~')" />
   </xsl:element>
     <!-- recursively call this template and pass in value AFTER the "|" delimiter -->
     <xsl:call-template name="StringSplit">
     <xsl:with-param name="val" select="substring-after($val, '~')" />
     </xsl:call-template>
  </xsl:when>
  <xsl:otherwise>
      <!-- if there is no more delimiter values, print out the whole string -->
      <xsl:element name="uuig:Semester"><xsl:value-of select="$val" /></xsl:element>
   </xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>