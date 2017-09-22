namespace INT0002.UU.GroupEvents.Maps {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation+KurstillfalleTillStatusEvent", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation.KurstillfalleTillStatusEvent))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.GroupEvents.InternalGroupEvent", typeof(global::Shared.Schemas.GroupEvents.InternalGroupEvent))]
    public sealed class KurstillfalleTillStatusEvent_to_InternalGroupEvent : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s0 s3 s2 s1 userCSharp ScriptNS0"" version=""1.0"" xmlns:uuii=""http://UU.Integrations.Common.Schemas.Internal.Identity"" xmlns:uuig=""http://UU.Integrations.Common.Schemas.Internal.Group"" xmlns:s0=""http://schemas.ladok.se/events"" xmlns:s2=""http://schemas.ladok.se/dap"" xmlns:ns0=""http://UU.Integrations.Common.Schemas.InternalGroupEvent"" xmlns:s1=""http://schemas.ladok.se"" xmlns:s3=""http://schemas.ladok.se/utbildningsinformation"" xmlns:userCSharp=""http://schemas.microsoft.com/BizTalk/2003/userCSharp"" xmlns:ScriptNS0=""http://schemas.microsoft.com/BizTalk/2003/ScriptNS0"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s3:KurstillfalleTillStatusEvent"" />
  </xsl:template>
  <xsl:template match=""/s3:KurstillfalleTillStatusEvent"">
    <xsl:variable name=""var:v1"" select=""userCSharp:StringTrimLeft(&quot;GroupCreateRequestEvent&quot;)"" />
    <xsl:variable name=""var:v2"" select=""userCSharp:StringTrimRight(&quot;GroupCreateRequestEvent&quot;)"" />
    <xsl:variable name=""var:v3"" select=""userCSharp:StringConcat(string(s3:StartperiodID/text()) , &quot;_&quot; , string(s3:Utbildningstillfalleskod/text()))"" />
    <xsl:variable name=""var:v37"" select=""string(s3:StartperiodID/text())"" />
    <xsl:variable name=""var:v38"" select=""string(s3:Utbildningstillfalleskod/text())"" />
    <ns0:GroupEvent>
      <xsl:attribute name=""type"">
        <xsl:value-of select=""$var:v1"" />
      </xsl:attribute>
      <uuig:Group>
        <xsl:attribute name=""type"">
          <xsl:value-of select=""$var:v2"" />
        </xsl:attribute>
        <uuig:Id>
          <xsl:value-of select=""$var:v3"" />
        </uuig:Id>
        <xsl:for-each select=""s3:UtbildningsinstansUID"">
          <xsl:variable name=""var:v13"" select=""string(./text())"" />
          <uuig:Names>
            <uuig:Name>
              <xsl:variable name=""var:v4"" select=""ScriptNS0:GetCourseDescriptions(string(./text()))"" />
              <xsl:variable name=""var:v5"" select=""userCSharp:StringFind(string($var:v4) , &quot;~&quot;)"" />
              <xsl:variable name=""var:v6"" select=""userCSharp:MathSubtract(string($var:v5) , &quot;1&quot;)"" />
              <xsl:variable name=""var:v7"" select=""userCSharp:StringSubstring(string($var:v4) , &quot;1&quot; , string($var:v6))"" />
              <xsl:variable name=""var:v8"" select=""userCSharp:MathAdd(string($var:v5) , &quot;1&quot;)"" />
              <xsl:variable name=""var:v9"" select=""userCSharp:StringSize(string($var:v4))"" />
              <xsl:variable name=""var:v10"" select=""userCSharp:StringSubstring(string($var:v4) , string($var:v8) , string($var:v9))"" />
              <xsl:variable name=""var:v11"" select=""'SV'"" />
              <xsl:attribute name=""lang"">
                <xsl:value-of select=""$var:v11"" />
              </xsl:attribute>
              <xsl:variable name=""var:v12"" select=""$var:v7"" />
              <xsl:value-of select=""$var:v12"" />
            </uuig:Name>
            <xsl:variable name=""var:v14"" select=""ScriptNS0:GetCourseDescriptions($var:v13)"" />
            <xsl:variable name=""var:v15"" select=""userCSharp:StringFind(string($var:v14) , &quot;~&quot;)"" />
            <xsl:variable name=""var:v16"" select=""userCSharp:MathSubtract(string($var:v15) , &quot;1&quot;)"" />
            <xsl:variable name=""var:v17"" select=""userCSharp:StringSubstring(string($var:v14) , &quot;1&quot; , string($var:v16))"" />
            <xsl:variable name=""var:v18"" select=""userCSharp:MathAdd(string($var:v15) , &quot;1&quot;)"" />
            <xsl:variable name=""var:v19"" select=""userCSharp:StringSize(string($var:v14))"" />
            <xsl:variable name=""var:v20"" select=""userCSharp:StringSubstring(string($var:v14) , string($var:v18) , string($var:v19))"" />
          </uuig:Names>
          <uuig:Names>
            <uuig:Name>
              <xsl:variable name=""var:v21"" select=""ScriptNS0:GetCourseDescriptions($var:v13)"" />
              <xsl:variable name=""var:v22"" select=""userCSharp:StringFind(string($var:v21) , &quot;~&quot;)"" />
              <xsl:variable name=""var:v23"" select=""userCSharp:MathSubtract(string($var:v22) , &quot;1&quot;)"" />
              <xsl:variable name=""var:v24"" select=""userCSharp:StringSubstring(string($var:v21) , &quot;1&quot; , string($var:v23))"" />
              <xsl:variable name=""var:v25"" select=""userCSharp:MathAdd(string($var:v22) , &quot;1&quot;)"" />
              <xsl:variable name=""var:v26"" select=""userCSharp:StringSize(string($var:v21))"" />
              <xsl:variable name=""var:v27"" select=""userCSharp:StringSubstring(string($var:v21) , string($var:v25) , string($var:v26))"" />
              <xsl:variable name=""var:v28"" select=""'EN'"" />
              <xsl:attribute name=""lang"">
                <xsl:value-of select=""$var:v28"" />
              </xsl:attribute>
              <xsl:variable name=""var:v29"" select=""$var:v27"" />
              <xsl:value-of select=""$var:v29"" />
            </uuig:Name>
            <xsl:variable name=""var:v30"" select=""ScriptNS0:GetCourseDescriptions($var:v13)"" />
            <xsl:variable name=""var:v31"" select=""userCSharp:StringFind(string($var:v30) , &quot;~&quot;)"" />
            <xsl:variable name=""var:v32"" select=""userCSharp:MathSubtract(string($var:v31) , &quot;1&quot;)"" />
            <xsl:variable name=""var:v33"" select=""userCSharp:StringSubstring(string($var:v30) , &quot;1&quot; , string($var:v32))"" />
            <xsl:variable name=""var:v34"" select=""userCSharp:MathAdd(string($var:v31) , &quot;1&quot;)"" />
            <xsl:variable name=""var:v35"" select=""userCSharp:StringSize(string($var:v30))"" />
            <xsl:variable name=""var:v36"" select=""userCSharp:StringSubstring(string($var:v30) , string($var:v34) , string($var:v35))"" />
          </uuig:Names>
        </xsl:for-each>
        <xsl:variable name=""var:v39"" select=""ScriptNS0:GetSemesters($var:v37 , $var:v38)"" />
        <xsl:call-template name=""WritePropertyNodeTemplate"">
          <xsl:with-param name=""GetDB"" select=""string($var:v39)"" />
        </xsl:call-template>
      </uuig:Group>
    </ns0:GroupEvent>
  </xsl:template>
  <msxsl:script language=""C#"" implements-prefix=""userCSharp""><![CDATA[
public string StringConcat(string param0, string param1, string param2)
{
   return param0 + param1 + param2;
}


public string StringSubstring(string str, string left, string right)
{
	string retval = """";
	double dleft = 0;
	double dright = 0;
	if (str != null && IsNumeric(left, ref dleft) && IsNumeric(right, ref dright))
	{
		int lt = (int)dleft;
		int rt = (int)dright;
		lt--; rt--;
		if (lt >= 0 && rt >= lt && lt < str.Length)
		{
			if (rt < str.Length)
			{
				retval = str.Substring(lt, rt-lt+1);
			}
			else
			{
				retval = str.Substring(lt, str.Length-lt);
			}
		}
	}
	return retval;
}


public int StringFind(string str, string strFind)
{
	if (str == null || strFind == null || strFind == """")
	{
		return 0;
	}
	return (str.IndexOf(strFind) + 1);
}


public int StringSize(string str)
{
	if (str == null)
	{
		return 0;
	}
	return str.Length;
}


public string StringTrimRight(string str)
{
	if (str == null)
	{
		return """";
	}
	return str.TrimEnd(null);
}


public string MathAdd(string param0, string param1)
{
	System.Collections.ArrayList listValues = new System.Collections.ArrayList();
	listValues.Add(param0);
	listValues.Add(param1);
	double ret = 0;
	foreach (string obj in listValues)
	{
	double d = 0;
		if (IsNumeric(obj, ref d))
		{
			ret += d;
		}
		else
		{
			return """";
		}
	}
	return ret.ToString(System.Globalization.CultureInfo.InvariantCulture);
}


public string MathSubtract(string param0, string param1)
{
	System.Collections.ArrayList listValues = new System.Collections.ArrayList();
	listValues.Add(param0);
	listValues.Add(param1);
	double ret = 0;
	bool first = true;
	foreach (string obj in listValues)
	{
		if (first)
		{
			first = false;
			double d = 0;
			if (IsNumeric(obj, ref d))
			{
				ret = d;
			}
			else
			{
				return """";
			}
		}
		else
		{
			double d = 0;
			if (IsNumeric(obj, ref d))
			{
				ret -= d;
			}
			else
			{
				return """";
			}
		}
	}
	return ret.ToString(System.Globalization.CultureInfo.InvariantCulture);
}


public string StringTrimLeft(string str)
{
	if (str == null)
	{
		return """";
	}
	return str.TrimStart(null);
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
  <xsl:template name=""WritePropertyNodeTemplate"">
<xsl:param name=""GetDB"" />
<!-- create property node -->
<xsl:element name=""uuig:Semesters"">
<!-- create single instance children nodes -->
<!-- call splitter template which accepts the ""|"" separated string -->
<xsl:call-template name=""StringSplit"">
<xsl:with-param name=""val"" select=""$GetDB"" />
</xsl:call-template>
</xsl:element>
</xsl:template>
  <xsl:template name=""StringSplit"">
<xsl:param name=""val"" />
<!-- do a check to see if the input string (still) has a ""|"" in it -->
<xsl:choose>
  <xsl:when test=""contains($val, '~')"">
   <!-- pull out the value of the string before the ""|"" delimiter -->
   <xsl:element name=""uuig:Semester""><xsl:value-of select=""substring-before($val, '~')"" /></xsl:element>
     <!-- recursively call this template and pass in value AFTER the ""|"" delimiter -->
     <xsl:call-template name=""StringSplit"">
     <xsl:with-param name=""val"" select=""substring-after($val, '~')"" />
     </xsl:call-template>
  </xsl:when>
  <xsl:otherwise>
      <!-- if there is no more delimiter values, print out the whole string -->
      <xsl:element name=""uuig:Semester""><xsl:value-of select=""$val"" /></xsl:element>
   </xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>";
        
        private const int _useXSLTransform = 0;
        
        private const string _strArgList = @"<ExtensionObjects>
  <ExtensionObject Namespace=""http://schemas.microsoft.com/BizTalk/2003/ScriptNS0"" AssemblyName=""INT0002.UU.Helper, Version=1.0.0.0, Culture=neutral, PublicKeyToken=b64e3957dd28061a"" ClassName=""Helper.MySQLConnect"" />
</ExtensionObjects>";
        
        private const string _strSrcSchemasList0 = @"Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation+KurstillfalleTillStatusEvent";
        
        private const global::Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation.KurstillfalleTillStatusEvent _srcSchemaTypeReference0 = null;
        
        private const string _strTrgSchemasList0 = @"Shared.Schemas.GroupEvents.InternalGroupEvent";
        
        private const global::Shared.Schemas.GroupEvents.InternalGroupEvent _trgSchemaTypeReference0 = null;
        
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
                _SrcSchemas[0] = @"Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation+KurstillfalleTillStatusEvent";
                return _SrcSchemas;
            }
        }
        
        public override string[] TargetSchemas {
            get {
                string[] _TrgSchemas = new string [1];
                _TrgSchemas[0] = @"Shared.Schemas.GroupEvents.InternalGroupEvent";
                return _TrgSchemas;
            }
        }
    }
}
