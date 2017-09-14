namespace INT0003.AD.Distribution {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.GroupEvents.InternalGroupEvent", typeof(global::Shared.Schemas.GroupEvents.InternalGroupEvent))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.GroupEvents.ADNewIndividual", typeof(global::Shared.Schemas.GroupEvents.ADNewIndividual))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.ADEvents.ADSendAdapterOneWayUpdate", typeof(global::Shared.Schemas.ADEvents.ADSendAdapterOneWayUpdate))]
    public sealed class InternalGroupEvent_to_ADSendAdapterOneWayUpdate : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s0 s2 s3 s1 s4"" version=""1.0"" xmlns:s0=""http://UU.Integrations.Common.ADChange.NewIndividual"" xmlns:s2=""http://schemas.microsoft.com/BizTalk/2003/aggschema"" xmlns:s3=""http://UU.Integrations.Common.Schemas.Internal.Identity"" xmlns:s1=""http://UU.Integrations.Common.Schemas.InternalGroupEvent"" xmlns:s4=""http://UU.Integrations.Common.Schemas.Internal.Group"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s2:Root"" />
  </xsl:template>
  <xsl:template match=""/s2:Root"">
    <ActiveDirectoryUpdate>
      <Directives>
        <xsl:attribute name=""SearchScope"">
          <xsl:text>subtree</xsl:text>
        </xsl:attribute>
      </Directives>
      <Change>
        <xsl:attribute name=""ChangeType"">
          <xsl:text>update</xsl:text>
        </xsl:attribute>
      </Change>
    </ActiveDirectoryUpdate>
  </xsl:template>
</xsl:stylesheet>";
        
        private const int _useXSLTransform = 0;
        
        private const string _strArgList = @"<ExtensionObjects />";
        
        private const string _strSrcSchemasList0 = @"Shared.Schemas.GroupEvents.InternalGroupEvent";
        
        private const global::Shared.Schemas.GroupEvents.InternalGroupEvent _srcSchemaTypeReference0 = null;
        
        private const string _strSrcSchemasList1 = @"Shared.Schemas.GroupEvents.ADNewIndividual";
        
        private const global::Shared.Schemas.GroupEvents.ADNewIndividual _srcSchemaTypeReference1 = null;
        
        private const string _strTrgSchemasList0 = @"Shared.Schemas.ADEvents.ADSendAdapterOneWayUpdate";
        
        private const global::Shared.Schemas.ADEvents.ADSendAdapterOneWayUpdate _trgSchemaTypeReference0 = null;
        
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
                string[] _SrcSchemas = new string [2];
                _SrcSchemas[0] = @"Shared.Schemas.GroupEvents.InternalGroupEvent";
                _SrcSchemas[1] = @"Shared.Schemas.GroupEvents.ADNewIndividual";
                return _SrcSchemas;
            }
        }
        
        public override string[] TargetSchemas {
            get {
                string[] _TrgSchemas = new string [1];
                _TrgSchemas[0] = @"Shared.Schemas.ADEvents.ADSendAdapterOneWayUpdate";
                return _TrgSchemas;
            }
        }
    }
}
