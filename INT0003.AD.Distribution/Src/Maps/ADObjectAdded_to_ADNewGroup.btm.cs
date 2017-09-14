namespace INT0003.AD.Distribution.Maps {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.ADEvents.ADQueryResultsChangeObjectAdded", typeof(global::Shared.Schemas.ADEvents.ADQueryResultsChangeObjectAdded))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.GroupEvents.ADNewGroup", typeof(global::Shared.Schemas.GroupEvents.ADNewGroup))]
    public sealed class ADObjectAdded_to_ADNewGroup : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var userCSharp"" version=""1.0"" xmlns:ns0=""http://UU.Integrations.Common.ADChange.NewGroup"" xmlns:userCSharp=""http://schemas.microsoft.com/BizTalk/2003/userCSharp"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/OBJECT_ADDED"" />
  </xsl:template>
  <xsl:template match=""/OBJECT_ADDED"">
    <xsl:variable name=""var:v1"" select=""userCSharp:LogicalEq(string(FilterMatch/NEW_VALUES/Property/@Name) , &quot;cn&quot;)"" />
    <ns0:ADNewGroup>
      <xsl:if test=""string($var:v1)='true'"">
        <xsl:variable name=""var:v2"" select=""FilterMatch/NEW_VALUES/Property/@Value"" />
        <xsl:attribute name=""GroupName"">
          <xsl:value-of select=""$var:v2"" />
        </xsl:attribute>
      </xsl:if>
    </ns0:ADNewGroup>
  </xsl:template>
  <msxsl:script language=""C#"" implements-prefix=""userCSharp""><![CDATA[
public bool LogicalEq(string val1, string val2)
{
	bool ret = false;
	double d1 = 0;
	double d2 = 0;
	if (IsNumeric(val1, ref d1) && IsNumeric(val2, ref d2))
	{
		ret = d1 == d2;
	}
	else
	{
		ret = String.Compare(val1, val2, StringComparison.Ordinal) == 0;
	}
	return ret;
}


public bool IsNumeric(string val)
{
	if (val == null)
	{
		return false;
	}
	double d = 0;
	return Double.TryParse(val, System.Globalization.NumberStyles.AllowThousands | System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out d);
}

public bool IsNumeric(string val, ref double d)
{
	if (val == null)
	{
		return false;
	}
	return Double.TryParse(val, System.Globalization.NumberStyles.AllowThousands | System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out d);
}


]]></msxsl:script>
</xsl:stylesheet>";
        
        private const int _useXSLTransform = 0;
        
        private const string _strArgList = @"<ExtensionObjects />";
        
        private const string _strSrcSchemasList0 = @"Shared.Schemas.ADEvents.ADQueryResultsChangeObjectAdded";
        
        private const global::Shared.Schemas.ADEvents.ADQueryResultsChangeObjectAdded _srcSchemaTypeReference0 = null;
        
        private const string _strTrgSchemasList0 = @"Shared.Schemas.GroupEvents.ADNewGroup";
        
        private const global::Shared.Schemas.GroupEvents.ADNewGroup _trgSchemaTypeReference0 = null;
        
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
                _SrcSchemas[0] = @"Shared.Schemas.ADEvents.ADQueryResultsChangeObjectAdded";
                return _SrcSchemas;
            }
        }
        
        public override string[] TargetSchemas {
            get {
                string[] _TrgSchemas = new string [1];
                _TrgSchemas[0] = @"Shared.Schemas.GroupEvents.ADNewGroup";
                return _TrgSchemas;
            }
        }
    }
}
