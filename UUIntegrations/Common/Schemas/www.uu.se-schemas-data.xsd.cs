namespace Common.Schemas {
    using Microsoft.XLANGs.BaseTypes;
    
    
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.BizTalk.Schema.Compiler", "3.0.1.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [SchemaType(SchemaTypeEnum.Document)]
    [Schema(@"http://www.uu.se/schemas/integration/Data",@"GroupEventData")]
    [System.SerializableAttribute()]
    [SchemaRoots(new string[] {@"GroupEventData"})]
    public sealed class www_uu_se_schemas_Copy : Microsoft.XLANGs.BaseTypes.SchemaBase {
        
        [System.NonSerializedAttribute()]
        private static object _rawSchema;
        
        [System.NonSerializedAttribute()]
        private const string _strSchema = @"<?xml version=""1.0"" encoding=""utf-16""?>
<xs:schema xmlns:b=""http://schemas.microsoft.com/BizTalk/2003"" xmlns:tns=""http://www.uu.se/schemas/integration/Data"" targetNamespace=""http://www.uu.se/schemas/integration/Data"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"">
  <xs:element name=""GroupEventData"" type=""tns:groupEventData"" />
  <xs:complexType name=""uuEventData"" abstract=""true"">
    <xs:sequence />
  </xs:complexType>
  <xs:complexType name=""groupEventData"">
    <xs:complexContent mixed=""false"">
      <xs:extension base=""tns:uuEventData"">
        <xs:sequence>
          <xs:element minOccurs=""0"" name=""GroupEventDataProperties"">
            <xs:complexType>
              <xs:sequence>
                <xs:element name=""key"" type=""xs:string"" />
                <xs:element name=""value"" type=""xs:string"" />
              </xs:sequence>
            </xs:complexType>
          </xs:element>
        </xs:sequence>
      </xs:extension>
    </xs:complexContent>
  </xs:complexType>
</xs:schema>";
        
        public www_uu_se_schemas_Copy() {
        }
        
        public override string XmlContent {
            get {
                return _strSchema;
            }
        }
        
        public override string[] RootNodes {
            get {
                string[] _RootElements = new string [1];
                _RootElements[0] = "GroupEventData";
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
