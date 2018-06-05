<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" exclude-result-prefixes="msxsl var s2 s1 s0 userCSharp" version="1.0" xmlns:s2="http://UU.Integrations.Common.Schemas.InternalGroupEvent" xmlns:s1="http://UU.Integrations.Common.Schemas.Internal.Group" xmlns:s0="http://UU.Integrations.Common.Schemas.Internal.Identity" xmlns:userCSharp="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:param name="path"  select="'OU EQ Users,OU EQ Student,OU EQ Akka,DC EQ exchange-test,DC EQ its,DC EQ uu,DC EQ se'"/>
  <xsl:template match="/">
    <xsl:apply-templates select="/s2:GroupEvent" />
  </xsl:template>
  <xsl:template match="/s2:GroupEvent">
    <ActiveDirectoryQuery>
      <Directives>
        <xsl:attribute name="WhereToBind">
          <xsl:text>Configured in send port</xsl:text>
        </xsl:attribute>
        <xsl:variable name="var:v2" select="userCSharp:MyConcat(string(s1:Group/@type))" />
        <xsl:variable name="var:v3" select="concat(s1:Group/s1:Id/text() , string($var:v2))" />
        <xsl:variable name="var:v4" select="concat(&quot;(&amp;(objectCategory=user)(norEduPersonNIN=&quot; , string(s2:GroupEventData/s0:NewMember/s0:PersonNumber/text()) , &quot;)(memberof=CN=&quot; , string($var:v3) ,userCSharp:ReplacePlaceholders($path), &quot;))&quot;)" />
        <xsl:attribute name="Filter">
          <xsl:value-of select="$var:v4" />
        </xsl:attribute>
        <xsl:attribute name="SearchScope">
          <xsl:text>onelevel</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="PropertiesToReturn">
          <xsl:text>cn</xsl:text>
        </xsl:attribute>
      </Directives>
    </ActiveDirectoryQuery>
  </xsl:template>
  <msxsl:script language="C#" implements-prefix="userCSharp">
  <![CDATA[



public string MyConcat(string type)
{
    if(type == "Registrering")
        return "_registered";
    else if(type == "Omregistrering")
        return "_reregistered";
    else if(type == "ForvantatDeltagande")
        return "_accepted";
    else
        return "";
}

public string ReplacePlaceholders(string input)
        {
            string output = input.Replace(" EQ ", "=");
            output = output.Replace(" NE ", "!=");
            output = output.Replace(" NQ ", ">=");
            return output.Replace(" LE ", "<=");
        }




]]></msxsl:script>
</xsl:stylesheet>