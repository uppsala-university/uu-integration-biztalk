<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" 
  exclude-result-prefixes="msxsl var s4 s0 s1 s3 s5 s2 s6 userCSharp ScriptNS0" version="1.0" xmlns:s4="http://schemas.ladok.se/events" xmlns:s0="http://schemas.ladok.se/studentinformation" 
  xmlns:s1="http://schemas.ladok.se/utbildningsinformation" xmlns:s3="http://ladok.uu.envelope.schemas" xmlns:s5="http://schemas.ladok.se" xmlns:s2="http://schemas.ladok.se/studiedeltagande" 
  xmlns:ns0="http://INT0011.VFU.Events.Schemas.VFU.Adressandring" xmlns:s6="http://schemas.ladok.se/dap" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp" 
  xmlns:ScriptNS0="http://schemas.microsoft.com/BizTalk/2003/ScriptNS0">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s3:KontaktuppgifterEnvelope" />
  </xsl:template>
  <xsl:template match="/s3:KontaktuppgifterEnvelope">
    <ns0:Root>
      <eventname>
         <xsl:text>KontaktuppgifterEvent</xsl:text>
      </eventname>
      <eventuid>
        <xsl:value-of select="s0:KontaktuppgifterEvent/s4:HandelseUID/text()" />
      </eventuid>
      <xsl:if test="s0:KontaktuppgifterEvent/s0:Postadresser/s0:Postort">
        <city>
          <xsl:value-of select="s0:KontaktuppgifterEvent/s0:Postadresser/s0:Postort/text()" />
        </city>
      </xsl:if>
      <xsl:if test="s0:KontaktuppgifterEvent/s0:Postadresser/s0:Utdelningsadress">
        <street>
          <xsl:value-of select="s0:KontaktuppgifterEvent/s0:Postadresser/s0:Utdelningsadress/text()" />
        </street>
      </xsl:if>
      <xsl:if test="s0:KontaktuppgifterEvent/s0:Postadresser/s0:Postnummer">
        <zipcode>
          <xsl:value-of select="s0:KontaktuppgifterEvent/s0:Postadresser/s0:Postnummer/text()" />
        </zipcode>
      </xsl:if>
      <pnr>
         <xsl:value-of select="s0:Student/s0:Personnummer/text()" />      
      </pnr>
      <password>
        <xsl:value-of select="ScriptNS0:ReadValue('INT0011.VFU.Events' , 'password')" />
      </password>
    </ns0:Root>
  </xsl:template>
</xsl:stylesheet>