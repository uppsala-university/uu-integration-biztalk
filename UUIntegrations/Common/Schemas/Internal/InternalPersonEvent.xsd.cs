namespace UU.Integrations.Common.Schemas.Internal {
    using Microsoft.XLANGs.BaseTypes;
    
    
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.BizTalk.Schema.Compiler", "3.0.1.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [SchemaType(SchemaTypeEnum.Document)]
    [Schema(@"http://UU.Integrations.Common.Schemas.InternalPersonEvent",@"PersonEvent")]
    [System.SerializableAttribute()]
    [SchemaRoots(new string[] {@"PersonEvent"})]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"UU.Integrations.Common.Schemas.Internal.InternalPerson", typeof(global::UU.Integrations.Common.Schemas.Internal.InternalPerson))]
    public sealed class InternalPersonEvent : Microsoft.XLANGs.BaseTypes.SchemaBase {
        
        [System.NonSerializedAttribute()]
        private static object _rawSchema;
        
        [System.NonSerializedAttribute()]
        private const string _strSchema = @"<?xml version=""1.0"" encoding=""utf-16""?>
<xs:schema xmlns:uuii=""http://UU.Integrations.Common.Schemas.Internal.Person"" xmlns:uuie=""http://UU.Integrations.Common.Schemas.InternalPersonEvent"" xmlns:b=""http://schemas.microsoft.com/BizTalk/2003"" xmlns:uuig=""http://www.uu.se/schemas/integration/2015/Group"" attributeFormDefault=""unqualified"" elementFormDefault=""qualified"" targetNamespace=""http://UU.Integrations.Common.Schemas.InternalPersonEvent"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"">
  <xs:import schemaLocation=""UU.Integrations.Common.Schemas.Internal.InternalPerson"" namespace=""http://UU.Integrations.Common.Schemas.Internal.Person"" />
  <xs:annotation>
    <xs:appinfo>
      <b:references>
        <b:reference targetNamespace=""http://UU.Integrations.Common.Schemas.Internal.Person"" />
      </b:references>
    </xs:appinfo>
  </xs:annotation>
  <xs:element name=""PersonEvent"">
    <xs:complexType>
      <xs:sequence>
        <xs:element name=""IssuedTime"" type=""xs:dateTime"" />
        <xs:element name=""Producer"" type=""xs:string"" />
        <xs:element name=""ProducerReferenceId"" type=""xs:string"" />
        <xs:element ref=""uuii:Person"" />
      </xs:sequence>
      <xs:attribute name=""type"" type=""xs:string"" use=""required"" />
    </xs:complexType>
  </xs:element>
</xs:schema>";
        
        public InternalPersonEvent() {
        }
        
        public override string XmlContent {
            get {
                return _strSchema;
            }
        }
        
        public override string[] RootNodes {
            get {
                string[] _RootElements = new string [1];
                _RootElements[0] = "PersonEvent";
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
