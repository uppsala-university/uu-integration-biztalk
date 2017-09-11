<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s0" version="1.0" xmlns:ns0="http://schemas.microsoft.com/Sql/2008/05/Procedures/dbo" xmlns:ns3="http://schemas.datacontract.org/2004/07/System.Data" xmlns:s0="http://BizTalk.PipelineComponents.ContextToXml.Context">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s0:ContextCollection" />
  </xsl:template>
  <xsl:template match="/s0:ContextCollection">
    <ns0:updateId>
      <ns0:Id>
        <xsl:value-of select="Context[@Name='EventId']/text()" />
      </ns0:Id>
    </ns0:updateId>
  </xsl:template>
</xsl:stylesheet>