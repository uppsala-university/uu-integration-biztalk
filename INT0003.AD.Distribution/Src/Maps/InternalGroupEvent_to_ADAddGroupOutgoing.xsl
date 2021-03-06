<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" 
                exclude-result-prefixes="msxsl var s2 s1 s0 script" version="1.0" xmlns:s2="http://UU.Integrations.Common.Schemas.InternalGroupEvent" 
                xmlns:ns0="http://UU.Integrations.Common.Schemas.ADSendAdapterOneWayUpdate" xmlns:s1="http://UU.Integrations.Common.Schemas.Internal.Group" 
                xmlns:s0="http://UU.Integrations.Common.Schemas.Internal.Identity" xmlns:script="http://schemas.microsoft.com/BizTalk/2003/userCSharp">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:param name="groupPrefix"/>
  <xsl:param name="EqualToValue"/>
  <xsl:template match="/">
    <xsl:apply-templates select="/s2:GroupEvent" />
  </xsl:template>
  <xsl:template match="/s2:GroupEvent">
    <ns0:ActiveDirectoryUpdate>
      <ns0:Directives>
        <xsl:attribute name="WhereToBind">
          <xsl:text>Configured in send port</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="SearchScope">
          <xsl:text>subtree</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="ObjectTypeFilter">
          <xsl:text>(objectClass=*)</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="MaxObjects">
          <xsl:text>1</xsl:text>
        </xsl:attribute>
      </ns0:Directives>
      <ns0:Target>
        <xsl:attribute name="PropertyName">
          <xsl:text>distinguishedName</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="EqualToValue">
          <xsl:value-of select="script:ReplacePlaceholders($EqualToValue)"/>
        </xsl:attribute>
      </ns0:Target>
      <ns0:Change>
        <xsl:attribute name="PropertyName">
          <xsl:value-of select="concat('CN=', string(s1:Group/s1:Id/text()),$groupPrefix)" />
        </xsl:attribute>
        <xsl:attribute name="ChangeToValue">
          <xsl:text>group</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="ChangeType">
          <xsl:text>createobject</xsl:text>
        </xsl:attribute>
      </ns0:Change>
      <ns0:Change>
        <xsl:attribute name="PropertyName">
          <xsl:text>sAMAccountName</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="ChangeToValue">
          <xsl:value-of select="concat(string(s1:Group/s1:Id/text()),$groupPrefix)" />
        </xsl:attribute>
        <xsl:attribute name="ChangeType">
          <xsl:text>update</xsl:text>
        </xsl:attribute>
      </ns0:Change>
      <xsl:if test="s1:Group/s1:Description/text()">
      <ns0:Change>
        <xsl:attribute name="PropertyName">
          <xsl:text>description</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="ChangeToValue">
          <xsl:value-of select="s1:Group/s1:Description/text()" />
        </xsl:attribute>
        <xsl:attribute name="ChangeType">
          <xsl:text>update</xsl:text>
        </xsl:attribute>
      </ns0:Change>
      </xsl:if>
      <!--
      uuEduCourseCode,uuEduDepartmentCode,uuEduSemester
-->
      <!--
      <ns0:Change>
        <xsl:attribute name="PropertyName">
          <xsl:text>uuEduStartSemester</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="ChangeToValue">
          <xsl:value-of select="s1:Group/s1:Semesters/@start" />
        </xsl:attribute>
        <xsl:attribute name="ChangeType">
          <xsl:text>update</xsl:text>
        </xsl:attribute>
      </ns0:Change>
      -->
       <ns0:Change>
        <xsl:attribute name="PropertyName">
          <xsl:text>uuEduCourseCode</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="ChangeToValue">
          <xsl:value-of select="s1:Group/@course" />
        </xsl:attribute>
        <xsl:attribute name="ChangeType">
          <xsl:text>update</xsl:text>
        </xsl:attribute>
      </ns0:Change>
      <ns0:Change>
        <xsl:attribute name="PropertyName">
          <xsl:text>uuEduDepartmentCode</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="ChangeToValue">
          <xsl:value-of select="s1:Group/@organisation" />
        </xsl:attribute>
        <xsl:attribute name="ChangeType">
          <xsl:text>update</xsl:text>
        </xsl:attribute>
      </ns0:Change>
        <ns0:Change>
          <xsl:attribute name="PropertyName">
            <xsl:text>uuEduSemester</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="ChangeToValue">
              <xsl:apply-templates select="s1:Group/s1:Semesters/s1:Semester"/>
          </xsl:attribute>
          <xsl:attribute name="ChangeType">
            <xsl:text>update</xsl:text>
          </xsl:attribute>
        </ns0:Change>
      
      <!--
      <xsl:for-each select="s1:Group/s1:Names/s1:Name">
        <ns0:Change>
          <xsl:attribute name="PropertyName">
            <xsl:text>uuEduName</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="ChangeToValue">
       ***LTI-206 2018-01-08 removed ,$groupPrefix from concat statement***
            <xsl:value-of select="concat(string(@lang), ': ', string(./text()))" />
          </xsl:attribute>
          <xsl:attribute name="ChangeType">
            <xsl:text>add</xsl:text>
          </xsl:attribute>
        </ns0:Change>
      </xsl:for-each>
      -->
    </ns0:ActiveDirectoryUpdate>
  </xsl:template>
  
  <xsl:template match="s1:Semester">
    <xsl:if test="position() > 1">
      <xsl:text>,</xsl:text>
  </xsl:if>
  
  <xsl:value-of select="text()"/>
  
  </xsl:template>
  <msxsl:script implements-prefix="script" language='CSharp'>
    <![CDATA[  
    public string ReplacePlaceholders(string input)
        {
            string output = input.Replace(" EQ ", " = ");
            output = output.Replace(" NE ", " != ");
            output = output.Replace(" NQ ", " >= ");
            return output.Replace(" LE ", " <= ");
        }
    ]]>
  </msxsl:script>
</xsl:stylesheet>