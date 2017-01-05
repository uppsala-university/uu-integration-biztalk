namespace UU.Integrations.Common.Schemas.Internal {
    using Microsoft.XLANGs.BaseTypes;
    
    
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.BizTalk.Schema.Compiler", "3.0.1.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [SchemaType(SchemaTypeEnum.Document)]
    [Schema(@"http://UU.Integrations.Common.Schemas.Internal.Person",@"Person")]
    [System.SerializableAttribute()]
    [SchemaRoots(new string[] {@"Person"})]
    public sealed class InternalPerson : Microsoft.XLANGs.BaseTypes.SchemaBase {
        
        [System.NonSerializedAttribute()]
        private static object _rawSchema;
        
        [System.NonSerializedAttribute()]
        private const string _strSchema = @"<?xml version=""1.0"" encoding=""utf-16""?>
<xs:schema xmlns:b=""http://schemas.microsoft.com/BizTalk/2003"" xmlns:tns=""http://UU.Integrations.Common.Schemas.Internal.Person"" attributeFormDefault=""unqualified"" elementFormDefault=""qualified"" targetNamespace=""http://UU.Integrations.Common.Schemas.Internal.Person"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"">
  <xs:element name=""Person"">
    <xs:complexType>
      <xs:sequence>
        <xs:element name=""PersonNumber"" type=""xs:unsignedLong"" />
        <xs:element name=""Affiliations"">
          <xs:complexType>
            <xs:sequence>
              <xs:element name=""Student"" type=""xs:anyType"" />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
      <xs:attribute name=""identifier"" type=""xs:unsignedLong"" use=""required"" />
    </xs:complexType>
  </xs:element>
</xs:schema>";
        
        public InternalPerson() {
        }
        
        public override string XmlContent {
            get {
                return _strSchema;
            }
        }
        
        public override string[] RootNodes {
            get {
                string[] _RootElements = new string [1];
                _RootElements[0] = "Person";
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
