namespace UU.Integrations.Common.Schemas.ActiveAdapter {
    using Microsoft.XLANGs.BaseTypes;
    
    
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.BizTalk.Schema.Compiler", "3.0.1.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [SchemaType(SchemaTypeEnum.Document)]
    [Schema(@"",@"ActiveDirectoryQueryResultsChange")]
    [System.SerializableAttribute()]
    [SchemaRoots(new string[] {@"ActiveDirectoryQueryResultsChange"})]
    public sealed class ActiveADAPTER_ActiveDirectoryQueryResultsChange_Schema : Microsoft.XLANGs.BaseTypes.SchemaBase {
        
        [System.NonSerializedAttribute()]
        private static object _rawSchema;
        
        [System.NonSerializedAttribute()]
        private const string _strSchema = @"<?xml version=""1.0"" encoding=""utf-16""?>
<xs:schema xmlns:b=""http://schemas.microsoft.com/BizTalk/2003"" attributeFormDefault=""unqualified"" elementFormDefault=""qualified"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"">
  <xs:element name=""ActiveDirectoryQueryResultsChange"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""unbounded"" name=""PROPERTY_CHANGED"">
          <xs:complexType>
            <xs:sequence>
              <xs:element name=""FilterMatch"">
                <xs:complexType>
                  <xs:sequence>
                    <xs:element name=""NEW_VALUES"">
                      <xs:complexType>
                        <xs:sequence>
                          <xs:element maxOccurs=""unbounded"" name=""Property"">
                            <xs:complexType>
                              <xs:attribute name=""Name"" type=""xs:string"" use=""required"" />
                              <xs:attribute name=""Value"" type=""xs:string"" use=""required"" />
                            </xs:complexType>
                          </xs:element>
                        </xs:sequence>
                      </xs:complexType>
                    </xs:element>
                    <xs:element name=""OLD_VALUES"">
                      <xs:complexType>
                        <xs:sequence>
                          <xs:element maxOccurs=""unbounded"" name=""Property"">
                            <xs:complexType>
                              <xs:attribute name=""Name"" type=""xs:string"" use=""required"" />
                              <xs:attribute name=""Value"" type=""xs:string"" use=""required"" />
                            </xs:complexType>
                          </xs:element>
                        </xs:sequence>
                      </xs:complexType>
                    </xs:element>
                  </xs:sequence>
                  <xs:attribute name=""ObjectPath"" type=""xs:string"" use=""required"" />
                </xs:complexType>
              </xs:element>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
        <xs:element minOccurs=""0"" maxOccurs=""unbounded"" name=""OBJECT_REMOVED"">
          <xs:complexType>
            <xs:sequence>
              <xs:element name=""FilterMatch"">
                <xs:complexType>
                  <xs:sequence>
                    <xs:element name=""OLD_VALUES"">
                      <xs:complexType>
                        <xs:sequence>
                          <xs:element maxOccurs=""unbounded"" name=""Property"">
                            <xs:complexType>
                              <xs:attribute name=""Name"" type=""xs:string"" use=""required"" />
                              <xs:attribute name=""Value"" type=""xs:string"" use=""required"" />
                            </xs:complexType>
                          </xs:element>
                        </xs:sequence>
                      </xs:complexType>
                    </xs:element>
                  </xs:sequence>
                  <xs:attribute name=""ObjectPath"" type=""xs:string"" use=""required"" />
                </xs:complexType>
              </xs:element>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
        <xs:element minOccurs=""0"" maxOccurs=""unbounded"" name=""OBJECT_ADDED"">
          <xs:complexType>
            <xs:sequence>
              <xs:element name=""FilterMatch"">
                <xs:complexType>
                  <xs:sequence>
                    <xs:element name=""NEW_VALUES"">
                      <xs:complexType>
                        <xs:sequence>
                          <xs:element maxOccurs=""unbounded"" name=""Property"">
                            <xs:complexType>
                              <xs:attribute name=""Name"" type=""xs:string"" use=""required"" />
                              <xs:attribute name=""Value"" type=""xs:string"" use=""required"" />
                            </xs:complexType>
                          </xs:element>
                        </xs:sequence>
                      </xs:complexType>
                    </xs:element>
                  </xs:sequence>
                  <xs:attribute name=""ObjectPath"" type=""xs:string"" use=""required"" />
                </xs:complexType>
              </xs:element>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
</xs:schema>";
        
        public ActiveADAPTER_ActiveDirectoryQueryResultsChange_Schema() {
        }
        
        public override string XmlContent {
            get {
                return _strSchema;
            }
        }
        
        public override string[] RootNodes {
            get {
                string[] _RootElements = new string [1];
                _RootElements[0] = "ActiveDirectoryQueryResultsChange";
                return _RootElements;
            }
        }
        
        protected override object RawSchema {
            get {
                return _rawSchema;
            }
            set {
                _rawSchema = value;
            }
        }
    }
}
