<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s0" version="1.0" xmlns:s0="http://BizTalk.PipelineComponents.ContextToXml.Context" xmlns:ns3="http://schemas.microsoft.com/Sql/2008/05/ProceduresResultSets/dbo/INT0001.Ladok2.Events.updateNext" xmlns:ns0="http://schemas.microsoft.com/Sql/2008/05/TypedProcedures/dbo">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s0:ContextCollection" />
  </xsl:template>
  <xsl:template match="/s0:ContextCollection">
    <ns0:INT0001.Ladok2.Events.updateNext>
      <ns0:ackId>
        <xsl:value-of select="Context[@Name='EventId']/text()" />
      </ns0:ackId>
    </ns0:INT0001.Ladok2.Events.updateNext>
  </xsl:template>
</xsl:stylesheet>