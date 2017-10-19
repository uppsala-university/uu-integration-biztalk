<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:var="http://schemas.microsoft.com/BizTalk/2003/var" 
                exclude-result-prefixes="msxsl var s0" version="1.0" xmlns:s0="http://SBOrderedDelivery.Transaction" 
                xmlns:array="http://schemas.microsoft.com/2003/10/Serialization/Arrays" xmlns:ns3="http://schemas.microsoft.com/Sql/2008/05/Types/Tables/dbo" 
                xmlns:ns0="http://schemas.microsoft.com/Sql/2008/05/TableOp/dbo/Transactions">
  <xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
  <xsl:template match="/">
    <xsl:apply-templates select="/s0:Transaction" />
  </xsl:template>
  <xsl:template match="/s0:Transaction">
    <ns0:Insert>
      <ns0:Rows>
        <ns3:Transactions>
          <ns3:TranId>
            <xsl:text></xsl:text>
          </ns3:TranId>
        </ns3:Transactions>
      </ns0:Rows>
    </ns0:Insert>
  </xsl:template>
</xsl:stylesheet>