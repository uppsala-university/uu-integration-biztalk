namespace SBOrderedDelivery.Maps {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"SBOrderedDelivery.Transaction", typeof(global::SBOrderedDelivery.Transaction))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"SBOrderedDelivery.sbTableOperation_dbo_Transactions+Insert", typeof(global::SBOrderedDelivery.sbTableOperation_dbo_Transactions.Insert))]
    public sealed class sb_Transactions_to_sql_Transactions : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" 
                exclude-result-prefixes=""msxsl var s0"" version=""1.0"" xmlns:s0=""http://SBOrderedDelivery.Transaction"" 
                xmlns:array=""http://schemas.microsoft.com/2003/10/Serialization/Arrays"" xmlns:ns3=""http://schemas.microsoft.com/Sql/2008/05/Types/Tables/dbo"" 
                xmlns:ns0=""http://schemas.microsoft.com/Sql/2008/05/TableOp/dbo/Transactions"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s0:Transaction"" />
  </xsl:template>
  <xsl:template match=""/s0:Transaction"">
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
</xsl:stylesheet>";
        
        private const int _useXSLTransform = 0;
        
        private const string _strArgList = @"<ExtensionObjects />";
        
        private const string _strSrcSchemasList0 = @"SBOrderedDelivery.Transaction";
        
        private const global::SBOrderedDelivery.Transaction _srcSchemaTypeReference0 = null;
        
        private const string _strTrgSchemasList0 = @"SBOrderedDelivery.sbTableOperation_dbo_Transactions+Insert";
        
        private const global::SBOrderedDelivery.sbTableOperation_dbo_Transactions.Insert _trgSchemaTypeReference0 = null;
        
        public override string XmlContent {
            get {
                return _strMap;
            }
        }
        
        public override int UseXSLTransform {
            get {
                return _useXSLTransform;
            }
        }
        
        public override string XsltArgumentListContent {
            get {
                return _strArgList;
            }
        }
        
        public override string[] SourceSchemas {
            get {
                string[] _SrcSchemas = new string [1];
                _SrcSchemas[0] = @"SBOrderedDelivery.Transaction";
                return _SrcSchemas;
            }
        }
        
        public override string[] TargetSchemas {
            get {
                string[] _TrgSchemas = new string [1];
                _TrgSchemas[0] = @"SBOrderedDelivery.sbTableOperation_dbo_Transactions+Insert";
                return _TrgSchemas;
            }
        }
    }
}
