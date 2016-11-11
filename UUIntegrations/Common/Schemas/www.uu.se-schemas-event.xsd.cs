namespace Common.Schemas {
    using Microsoft.XLANGs.BaseTypes;
    
    
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.BizTalk.Schema.Compiler", "3.0.1.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [SchemaType(SchemaTypeEnum.Document)]
    [Schema(@"http://www.uu.se/schemas/integration/Event",@"UUEvent")]
    [System.SerializableAttribute()]
    [SchemaRoots(new string[] {@"UUEvent"})]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Common.Schemas.www_uu_se_schemas_Copy", typeof(global::Common.Schemas.www_uu_se_schemas_Copy))]
    public sealed class Schema1 : Microsoft.XLANGs.BaseTypes.SchemaBase {
        
        [System.NonSerializedAttribute()]
        private static object _rawSchema;
        
        [System.NonSerializedAttribute()]
        private const string _strSchema = @"<?xml version=""1.0"" encoding=""utf-16""?>
<xs:schema xmlns:uuid=""http://www.uu.se/schemas/integration/Data"" xmlns:b=""http://schemas.microsoft.com/BizTalk/2003"" xmlns:tns=""http://www.uu.se/schemas/integration/Event"" elementFormDefault=""qualified"" targetNamespace=""http://www.uu.se/schemas/integration/Event"" version=""1.0"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"">
  <xs:import schemaLocation=""Common.Schemas.www_uu_se_schemas_Copy"" namespace=""http://www.uu.se/schemas/integration/Data"" />
  <xs:annotation>
    <xs:appinfo>
      <b:references>
        <b:reference targetNamespace=""http://www.uu.se/schemas/integration/Data"" />
      </b:references>
    </xs:appinfo>
  </xs:annotation>
  <xs:element name=""UUEvent"" type=""tns:uuEvent"" />
  <xs:complexType name=""uuEvent"">
    <xs:sequence>
      <xs:element minOccurs=""0"" name=""ProcessedTime"" type=""xs:dateTime"" />
      <xs:element minOccurs=""0"" name=""IssuedTime"" type=""xs:dateTime"" />
      <xs:element minOccurs=""0"" name=""Producer"" type=""xs:string"" />
      <xs:element minOccurs=""0"" name=""ProducerReferenceId"" type=""xs:string"" />
    </xs:sequence>
    <xs:attribute name=""identifier"" type=""xs:string"" />
    <xs:attribute name=""type"" type=""xs:string"" />
  </xs:complexType>
  <xs:complexType name=""groupEvent"">
    <xs:complexContent mixed=""false"">
      <xs:extension base=""tns:uuEvent"">
        <xs:sequence>
          <xs:element ref=""uuid:GroupEventData"" />
        </xs:sequence>
      </xs:extension>
    </xs:complexContent>
  </xs:complexType>
</xs:schema>";
        
        public Schema1() {
        }
        
        public override string XmlContent {
            get {
                return _strSchema;
            }
        }
        
        public override string[] RootNodes {
            get {
                string[] _RootElements = new string [1];
                _RootElements[0] = "UUEvent";
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
