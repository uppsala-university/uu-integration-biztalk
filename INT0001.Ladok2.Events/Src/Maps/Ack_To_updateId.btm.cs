namespace INT0001.Ladok2.Events.Maps {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"BizTalk.PipelineComponents.ContextToXml.Context", typeof(global::BizTalk.PipelineComponents.ContextToXml.Context))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"INT0001.Ladok2.Events.procedure_updateId", typeof(global::INT0001.Ladok2.Events.procedure_updateId))]
    public sealed class Ack_To_updateId : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" 
                xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s0"" 
                version=""1.0"" xmlns:s0=""http://BizTalk.PipelineComponents.ContextToXml.Context""
                xmlns:ns0=""http://schemas.microsoft.com/Sql/2008/05/TypedProcedures/dbo"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s0:ContextCollection"" />
  </xsl:template>
  <xsl:template match=""/s0:ContextCollection"">
    <ns0:INT0001.Ladok2.Events.updateId>
      <ns0:ackId>
        <xsl:value-of select=""Context[@Name='EventId']/text()"" />
      </ns0:ackId>
    </ns0:INT0001.Ladok2.Events.updateId>
  </xsl:template>
</xsl:stylesheet>";
        
        private const int _useXSLTransform = 0;
        
        private const string _strArgList = @"<ExtensionObjects />";
        
        private const string _strSrcSchemasList0 = @"BizTalk.PipelineComponents.ContextToXml.Context";
        
        private const global::BizTalk.PipelineComponents.ContextToXml.Context _srcSchemaTypeReference0 = null;
        
        private const string _strTrgSchemasList0 = @"INT0001.Ladok2.Events.procedure_updateId";
        
        private const global::INT0001.Ladok2.Events.procedure_updateId _trgSchemaTypeReference0 = null;
        
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
                _SrcSchemas[0] = @"BizTalk.PipelineComponents.ContextToXml.Context";
                return _SrcSchemas;
            }
        }
        
        public override string[] TargetSchemas {
            get {
                string[] _TrgSchemas = new string [1];
                _TrgSchemas[0] = @"INT0001.Ladok2.Events.procedure_updateId";
                return _TrgSchemas;
            }
        }
    }
}
