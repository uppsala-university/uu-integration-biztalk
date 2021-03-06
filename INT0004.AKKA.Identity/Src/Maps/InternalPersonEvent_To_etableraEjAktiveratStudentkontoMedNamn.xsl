<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s0 s1 userCSharp ScriptNS0" version="1.0" xmlns:ns0="http://call.authsrv.its.uu.se/" xmlns:s1="http://UU.Integrations.Common.Schemas.InternalPersonEvent" xmlns:ns1="http://cxf.akkaappl.akka.its.uu.se/" xmlns:s0="http://UU.Integrations.Common.Schemas.Internal.Person" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s1:PersonEvent" />
  </xsl:template>
  <xsl:template match="/s1:PersonEvent">
    <ns1:etableraEjAktiveratStudentkontoMedNamn>
      <applikation>
        <xsl:text>ESB</xsl:text>
      </applikation>
      <xsl:if test="s0:Person/@identifier and (s0:Person/@identifier != s0:Person/s0:PersonNumber/text())">
        <ladokUUID>
          <xsl:value-of select="s0:Person/@identifier" />
        </ladokUUID>
      </xsl:if>
      <xsl:variable name="expectedMessageType">PersonStudentAffiliationCreateRequestEvent</xsl:variable>
      <xsl:if test="@type != $expectedMessageType">
        <xsl:message terminate="yes">
          Message type <xsl:value-of select="@type" /> is not the expected message type <xsl:value-of select="$expectedMessageType" />
        </xsl:message>
      </xsl:if>

      <xsl:if test="s0:Person/s0:PersonNumber">
        <pnr>
          <xsl:value-of select="s0:Person/s0:PersonNumber/text()" />
        </pnr>
      </xsl:if>

      <xsl:call-template name="AddNamn">
        <xsl:with-param name="fullname" select="s0:Person/s0:Affiliations/s0:Student/text()" />
      </xsl:call-template>

    
      <metadata>
        <xsl:text>INT0004.AKKA.Identity</xsl:text>
      </metadata>
    </ns1:etableraEjAktiveratStudentkontoMedNamn>
  </xsl:template>
  <xsl:template name="AddNamn">
    <xsl:param name="fullname" />

    <fornamn>
      <xsl:value-of select="substring-before($fullname,',')" />
      <!--<xsl:value-of select="$fullname" /> -->
    </fornamn>
    <efternamn>
      <xsl:value-of select="normalize-space(substring-after($fullname,','))" />
    </efternamn>

  </xsl:template>
</xsl:stylesheet>