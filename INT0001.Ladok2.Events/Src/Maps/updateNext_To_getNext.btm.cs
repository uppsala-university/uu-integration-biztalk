namespace INT0001.Ladok2.Events.Maps {
    
    
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"INT0001.Ladok2.Events.Schemas.updateNext.Procedure_updateNext_Response", typeof(global::INT0001.Ladok2.Events.Schemas.updateNext.Procedure_updateNext_Response))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"INT0001.Ladok2.Events.procedure_getNext+TypedPolling", typeof(global::INT0001.Ladok2.Events.procedure_getNext.TypedPolling))]
    public sealed class updateNext_To_getNext : global::Microsoft.XLANGs.BaseTypes.TransformBase {
        
        private const string _strMap = @"<?xml version=""1.0"" encoding=""UTF-16""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:msxsl=""urn:schemas-microsoft-com:xslt"" xmlns:var=""http://schemas.microsoft.com/BizTalk/2003/var"" exclude-result-prefixes=""msxsl var s1 s0"" version=""1.0"" xmlns:ns0=""http://schemas.microsoft.com/Sql/2008/05/TypedPolling/ladokevents"" xmlns:s0=""http://schemas.microsoft.com/Sql/2008/05/ProceduresResultSets/dbo/INT0001.Ladok2.Events.updateNext"" xmlns:s1=""http://schemas.microsoft.com/Sql/2008/05/TypedProcedures/dbo"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"">
  <xsl:output omit-xml-declaration=""yes"" method=""xml"" version=""1.0"" />
  <xsl:template match=""/"">
    <xsl:apply-templates select=""/s1:INT0001.Ladok2.Events.updateNextResponse"" />
  </xsl:template>
  <xsl:template match=""/s1:INT0001.Ladok2.Events.updateNextResponse"">
    <ns0:TypedPolling>
      <ns0:TypedPollingResultSet0>
        <xsl:for-each select=""s1:StoredProcedureResultSet0"">
          <xsl:for-each select=""s0:StoredProcedureResultSet0"">
            <ns0:TypedPollingResultSet0>
              <xsl:if test=""s0:Id"">
                <xsl:variable name=""var:v1"" select=""string(s0:Id/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v1)='true'"">
                  <ns0:Id>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:Id>
                </xsl:if>
                <xsl:if test=""string($var:v1)='false'"">
                  <ns0:Id>
                    <xsl:value-of select=""s0:Id/text()"" />
                  </ns0:Id>
                </xsl:if>
              </xsl:if>
              <xsl:if test=""s0:date"">
                <xsl:variable name=""var:v2"" select=""string(s0:date/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v2)='true'"">
                  <ns0:date>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:date>
                </xsl:if>
                <xsl:if test=""string($var:v2)='false'"">
                  <ns0:date>
                    <xsl:value-of select=""s0:date/text()"" />
                  </ns0:date>
                </xsl:if>
              </xsl:if>
              <xsl:if test=""s0:pnr"">
                <xsl:variable name=""var:v3"" select=""string(s0:pnr/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v3)='true'"">
                  <ns0:pnr>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:pnr>
                </xsl:if>
                <xsl:if test=""string($var:v3)='false'"">
                  <ns0:pnr>
                    <xsl:value-of select=""s0:pnr/text()"" />
                  </ns0:pnr>
                </xsl:if>
              </xsl:if>
              <xsl:if test=""s0:meType"">
                <xsl:variable name=""var:v4"" select=""string(s0:meType/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v4)='true'"">
                  <ns0:meType>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:meType>
                </xsl:if>
                <xsl:if test=""string($var:v4)='false'"">
                  <ns0:meType>
                    <xsl:value-of select=""s0:meType/text()"" />
                  </ns0:meType>
                </xsl:if>
              </xsl:if>
              <xsl:if test=""s0:courseCode"">
                <xsl:variable name=""var:v5"" select=""string(s0:courseCode/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v5)='true'"">
                  <ns0:courseCode>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:courseCode>
                </xsl:if>
                <xsl:if test=""string($var:v5)='false'"">
                  <ns0:courseCode>
                    <xsl:value-of select=""s0:courseCode/text()"" />
                  </ns0:courseCode>
                </xsl:if>
              </xsl:if>
              <xsl:if test=""s0:reportCode"">
                <xsl:variable name=""var:v6"" select=""string(s0:reportCode/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v6)='true'"">
                  <ns0:reportCode>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:reportCode>
                </xsl:if>
                <xsl:if test=""string($var:v6)='false'"">
                  <ns0:reportCode>
                    <xsl:value-of select=""s0:reportCode/text()"" />
                  </ns0:reportCode>
                </xsl:if>
              </xsl:if>
              <xsl:if test=""s0:startSemester"">
                <xsl:variable name=""var:v7"" select=""string(s0:startSemester/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v7)='true'"">
                  <ns0:startSemester>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:startSemester>
                </xsl:if>
                <xsl:if test=""string($var:v7)='false'"">
                  <ns0:startSemester>
                    <xsl:value-of select=""s0:startSemester/text()"" />
                  </ns0:startSemester>
                </xsl:if>
              </xsl:if>
              <xsl:if test=""s0:semester"">
                <xsl:variable name=""var:v8"" select=""string(s0:semester/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v8)='true'"">
                  <ns0:semester>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:semester>
                </xsl:if>
                <xsl:if test=""string($var:v8)='false'"">
                  <ns0:semester>
                    <xsl:value-of select=""s0:semester/text()"" />
                  </ns0:semester>
                </xsl:if>
              </xsl:if>
              <xsl:if test=""s0:program"">
                <xsl:variable name=""var:v9"" select=""string(s0:program/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v9)='true'"">
                  <ns0:program>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:program>
                </xsl:if>
                <xsl:if test=""string($var:v9)='false'"">
                  <ns0:program>
                    <xsl:value-of select=""s0:program/text()"" />
                  </ns0:program>
                </xsl:if>
              </xsl:if>
              <xsl:if test=""s0:programOrientation"">
                <xsl:variable name=""var:v10"" select=""string(s0:programOrientation/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v10)='true'"">
                  <ns0:programOrientation>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:programOrientation>
                </xsl:if>
                <xsl:if test=""string($var:v10)='false'"">
                  <ns0:programOrientation>
                    <xsl:value-of select=""s0:programOrientation/text()"" />
                  </ns0:programOrientation>
                </xsl:if>
              </xsl:if>
              <xsl:if test=""s0:condition1"">
                <xsl:variable name=""var:v11"" select=""string(s0:condition1/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v11)='true'"">
                  <ns0:condition1>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:condition1>
                </xsl:if>
                <xsl:if test=""string($var:v11)='false'"">
                  <ns0:condition1>
                    <xsl:value-of select=""s0:condition1/text()"" />
                  </ns0:condition1>
                </xsl:if>
              </xsl:if>
              <xsl:if test=""s0:condition2"">
                <xsl:variable name=""var:v12"" select=""string(s0:condition2/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v12)='true'"">
                  <ns0:condition2>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:condition2>
                </xsl:if>
                <xsl:if test=""string($var:v12)='false'"">
                  <ns0:condition2>
                    <xsl:value-of select=""s0:condition2/text()"" />
                  </ns0:condition2>
                </xsl:if>
              </xsl:if>
              <xsl:if test=""s0:condition3"">
                <xsl:variable name=""var:v13"" select=""string(s0:condition3/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v13)='true'"">
                  <ns0:condition3>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:condition3>
                </xsl:if>
                <xsl:if test=""string($var:v13)='false'"">
                  <ns0:condition3>
                    <xsl:value-of select=""s0:condition3/text()"" />
                  </ns0:condition3>
                </xsl:if>
              </xsl:if>
              <xsl:if test=""s0:origin"">
                <xsl:variable name=""var:v14"" select=""string(s0:origin/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v14)='true'"">
                  <ns0:origin>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:origin>
                </xsl:if>
                <xsl:if test=""string($var:v14)='false'"">
                  <ns0:origin>
                    <xsl:value-of select=""s0:origin/text()"" />
                  </ns0:origin>
                </xsl:if>
              </xsl:if>
              <xsl:if test=""s0:origin2"">
                <xsl:variable name=""var:v15"" select=""string(s0:origin2/@xsi:nil) = 'true'"" />
                <xsl:if test=""string($var:v15)='true'"">
                  <ns0:origin2>
                    <xsl:attribute name=""xsi:nil"">
                      <xsl:value-of select=""'true'"" />
                    </xsl:attribute>
                  </ns0:origin2>
                </xsl:if>
                <xsl:if test=""string($var:v15)='false'"">
                  <ns0:origin2>
                    <xsl:value-of select=""s0:origin2/text()"" />
                  </ns0:origin2>
                </xsl:if>
              </xsl:if>
            </ns0:TypedPollingResultSet0>
          </xsl:for-each>
        </xsl:for-each>
      </ns0:TypedPollingResultSet0>
    </ns0:TypedPolling>
  </xsl:template>
</xsl:stylesheet>";
        
        private const int _useXSLTransform = 0;
        
        private const string _strArgList = @"<ExtensionObjects />";
        
        private const string _strSrcSchemasList0 = @"INT0001.Ladok2.Events.Schemas.updateNext.Procedure_updateNext_Response";
        
        private const global::INT0001.Ladok2.Events.Schemas.updateNext.Procedure_updateNext_Response _srcSchemaTypeReference0 = null;
        
        private const string _strTrgSchemasList0 = @"INT0001.Ladok2.Events.procedure_getNext+TypedPolling";
        
        private const global::INT0001.Ladok2.Events.procedure_getNext.TypedPolling _trgSchemaTypeReference0 = null;
        
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
                _SrcSchemas[0] = @"INT0001.Ladok2.Events.Schemas.updateNext.Procedure_updateNext_Response";
                return _SrcSchemas;
            }
        }
        
        public override string[] TargetSchemas {
            get {
                string[] _TrgSchemas = new string [1];
                _TrgSchemas[0] = @"INT0001.Ladok2.Events.procedure_getNext+TypedPolling";
                return _TrgSchemas;
            }
        }
    }
}
