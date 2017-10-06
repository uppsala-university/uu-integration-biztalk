namespace INT0001.Ladok.Tests.Maps {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet", typeof(global::INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"INT0001.Ladok.Tests.TableOperation_MEMBERSHIP_EVENTS_RECEIVED+Insert", typeof(global::INT0001.Ladok.Tests.TableOperation_MEMBERSHIP_EVENTS_RECEIVED.Insert))]
    public sealed class MEMBERSHIP_EVENTS_To_MEMBERSHIP_EVENTS_RECEIVED : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s0 userCSharp"" version=""1.0"" xmlns:ns0=""http://schemas.microsoft.com/Sql/2008/05/TableOp/dbo/MEMBERSHIP_EVENTS_RECEIVED"" xmlns:s0=""http://schemas.microsoft.com/Sql/2008/05/TypedPolling/ladokevents"" xmlns:array=""http://schemas.microsoft.com/2003/10/Serialization/Arrays"" xmlns:ns3=""http://schemas.microsoft.com/Sql/2008/05/Types/Tables/dbo"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:userCSharp=""http://schemas.microsoft.com/BizTalk/2003/userCSharp"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s0:TypedPollingResultSet0"" />
  </xsl:template>
  <xsl:template match=""/s0:TypedPollingResultSet0"">
    <xsl:variable name=""var:v2"" select=""userCSharp:DateCurrentDateTime()"" />
    <ns0:Insert>
      <ns0:Rows>
        <ns3:MEMBERSHIP_EVENTS_RECEIVED>
          <xsl:if test=""s0:Id"">
            <xsl:variable name=""var:v1"" select=""string(s0:Id/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v1)='true'"">
              <ns3:event_id>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:event_id>
            </xsl:if>
            <xsl:if test=""string($var:v1)='false'"">
              <ns3:event_id>
                <xsl:value-of select=""s0:Id/text()"" />
              </ns3:event_id>
            </xsl:if>
          </xsl:if>
          <ns3:event_datetime>
            <xsl:value-of select=""$var:v2"" />
          </ns3:event_datetime>
          <xsl:if test=""s0:date"">
            <xsl:variable name=""var:v3"" select=""string(s0:date/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v3)='true'"">
              <ns3:date>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:date>
            </xsl:if>
            <xsl:if test=""string($var:v3)='false'"">
              <ns3:date>
                <xsl:value-of select=""s0:date/text()"" />
              </ns3:date>
            </xsl:if>
          </xsl:if>
          <xsl:if test=""s0:pnr"">
            <xsl:variable name=""var:v4"" select=""string(s0:pnr/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v4)='true'"">
              <ns3:pnr>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:pnr>
            </xsl:if>
            <xsl:if test=""string($var:v4)='false'"">
              <ns3:pnr>
                <xsl:value-of select=""s0:pnr/text()"" />
              </ns3:pnr>
            </xsl:if>
          </xsl:if>
          <xsl:if test=""s0:meType"">
            <xsl:variable name=""var:v5"" select=""string(s0:meType/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v5)='true'"">
              <ns3:meType>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:meType>
            </xsl:if>
            <xsl:if test=""string($var:v5)='false'"">
              <ns3:meType>
                <xsl:value-of select=""s0:meType/text()"" />
              </ns3:meType>
            </xsl:if>
          </xsl:if>
          <xsl:if test=""s0:courseCode"">
            <xsl:variable name=""var:v6"" select=""string(s0:courseCode/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v6)='true'"">
              <ns3:courseCode>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:courseCode>
            </xsl:if>
            <xsl:if test=""string($var:v6)='false'"">
              <ns3:courseCode>
                <xsl:value-of select=""s0:courseCode/text()"" />
              </ns3:courseCode>
            </xsl:if>
          </xsl:if>
          <xsl:if test=""s0:reportCode"">
            <xsl:variable name=""var:v7"" select=""string(s0:reportCode/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v7)='true'"">
              <ns3:reportCode>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:reportCode>
            </xsl:if>
            <xsl:if test=""string($var:v7)='false'"">
              <ns3:reportCode>
                <xsl:value-of select=""s0:reportCode/text()"" />
              </ns3:reportCode>
            </xsl:if>
          </xsl:if>
          <xsl:if test=""s0:startSemester"">
            <xsl:variable name=""var:v8"" select=""string(s0:startSemester/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v8)='true'"">
              <ns3:startSemester>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:startSemester>
            </xsl:if>
            <xsl:if test=""string($var:v8)='false'"">
              <ns3:startSemester>
                <xsl:value-of select=""s0:startSemester/text()"" />
              </ns3:startSemester>
            </xsl:if>
          </xsl:if>
          <xsl:if test=""s0:semester"">
            <xsl:variable name=""var:v9"" select=""string(s0:semester/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v9)='true'"">
              <ns3:semester>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:semester>
            </xsl:if>
            <xsl:if test=""string($var:v9)='false'"">
              <ns3:semester>
                <xsl:value-of select=""s0:semester/text()"" />
              </ns3:semester>
            </xsl:if>
          </xsl:if>
          <xsl:if test=""s0:program"">
            <xsl:variable name=""var:v10"" select=""string(s0:program/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v10)='true'"">
              <ns3:program>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:program>
            </xsl:if>
            <xsl:if test=""string($var:v10)='false'"">
              <ns3:program>
                <xsl:value-of select=""s0:program/text()"" />
              </ns3:program>
            </xsl:if>
          </xsl:if>
          <xsl:if test=""s0:programOrientation"">
            <xsl:variable name=""var:v11"" select=""string(s0:programOrientation/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v11)='true'"">
              <ns3:programOrientation>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:programOrientation>
            </xsl:if>
            <xsl:if test=""string($var:v11)='false'"">
              <ns3:programOrientation>
                <xsl:value-of select=""s0:programOrientation/text()"" />
              </ns3:programOrientation>
            </xsl:if>
          </xsl:if>
          <xsl:if test=""s0:condition1"">
            <xsl:variable name=""var:v12"" select=""string(s0:condition1/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v12)='true'"">
              <ns3:condition1>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:condition1>
            </xsl:if>
            <xsl:if test=""string($var:v12)='false'"">
              <ns3:condition1>
                <xsl:value-of select=""s0:condition1/text()"" />
              </ns3:condition1>
            </xsl:if>
          </xsl:if>
          <xsl:if test=""s0:condition2"">
            <xsl:variable name=""var:v13"" select=""string(s0:condition2/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v13)='true'"">
              <ns3:condition2>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:condition2>
            </xsl:if>
            <xsl:if test=""string($var:v13)='false'"">
              <ns3:condition2>
                <xsl:value-of select=""s0:condition2/text()"" />
              </ns3:condition2>
            </xsl:if>
          </xsl:if>
          <xsl:if test=""s0:condition3"">
            <xsl:variable name=""var:v14"" select=""string(s0:condition3/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v14)='true'"">
              <ns3:condition3>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:condition3>
            </xsl:if>
            <xsl:if test=""string($var:v14)='false'"">
              <ns3:condition3>
                <xsl:value-of select=""s0:condition3/text()"" />
              </ns3:condition3>
            </xsl:if>
          </xsl:if>
          <xsl:if test=""s0:origin"">
            <xsl:variable name=""var:v15"" select=""string(s0:origin/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v15)='true'"">
              <ns3:origin>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:origin>
            </xsl:if>
            <xsl:if test=""string($var:v15)='false'"">
              <ns3:origin>
                <xsl:value-of select=""s0:origin/text()"" />
              </ns3:origin>
            </xsl:if>
          </xsl:if>
          <xsl:if test=""s0:origin2"">
            <xsl:variable name=""var:v16"" select=""string(s0:origin2/@xsi:nil) = 'true'"" />
            <xsl:if test=""string($var:v16)='true'"">
              <ns3:origin2>
                <xsl:attribute name=""xsi:nil"">
                  <xsl:value-of select=""'true'"" />
                </xsl:attribute>
              </ns3:origin2>
            </xsl:if>
            <xsl:if test=""string($var:v16)='false'"">
              <ns3:origin2>
                <xsl:value-of select=""s0:origin2/text()"" />
              </ns3:origin2>
            </xsl:if>
          </xsl:if>
        </ns3:MEMBERSHIP_EVENTS_RECEIVED>
      </ns0:Rows>
    </ns0:Insert>
  </xsl:template>
  <msxsl:script language=""C#"" implements-prefix=""userCSharp""><![CDATA[
public string DateCurrentDateTime()
{
	DateTime dt = DateTime.Now;
	string curdate = dt.ToString(""yyyy-MM-dd"", System.Globalization.CultureInfo.InvariantCulture);
	string curtime = dt.ToString(""T"", System.Globalization.CultureInfo.InvariantCulture);
	string retval = curdate + ""T"" + curtime;
	return retval;
}



]]></msxsl:script>
</xsl:stylesheet>";
        
        private const int _useXSLTransform = 0;
        
        private const string _strArgList = @"<ExtensionObjects />";
        
        private const string _strSrcSchemasList0 = @"INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet";
        
        private const global::INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet _srcSchemaTypeReference0 = null;
        
        private const string _strTrgSchemasList0 = @"INT0001.Ladok.Tests.TableOperation_MEMBERSHIP_EVENTS_RECEIVED+Insert";
        
        private const global::INT0001.Ladok.Tests.TableOperation_MEMBERSHIP_EVENTS_RECEIVED.Insert _trgSchemaTypeReference0 = null;
        
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
                _SrcSchemas[0] = @"INT0001.Ladok2.Events.Schemas.getNext.getNext_resultSet";
                return _SrcSchemas;
            }
        }
        
        public override string[] TargetSchemas {
            get {
                string[] _TrgSchemas = new string [1];
                _TrgSchemas[0] = @"INT0001.Ladok.Tests.TableOperation_MEMBERSHIP_EVENTS_RECEIVED+Insert";
                return _TrgSchemas;
            }
        }
    }
}
