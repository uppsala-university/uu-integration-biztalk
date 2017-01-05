namespace UU.Integrations.Common.Schemas.ActiveAdapter {
    using Microsoft.XLANGs.BaseTypes;
    
    
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.BizTalk.Schema.Compiler", "3.0.1.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [SchemaType(SchemaTypeEnum.Document)]
    [Schema(@"http://UU.Integrations.Common.Schemas.ADSendAdapterSolicitResponseIndividualQuery",@"ActiveDirectoryQuery")]
    [Microsoft.XLANGs.BaseTypes.PropertyAttribute(typeof(global::UU.Integrations.Common.PersonNumber), XPath = @"/*[local-name()='ActiveDirectoryQuery' and namespace-uri()='http://UU.Integrations.Common.Schemas.ADSendAdapterSolicitResponseIndividualQuery']/*[local-name()='Directives' and namespace-uri()='http://UU.Integrations.Common.Schemas.ADSendAdapterSolicitResponseIndividualQuery']/@*[local-name()='PersonNumber' and namespace-uri()='']", XsdType = @"string")]
    [System.SerializableAttribute()]
    [SchemaRoots(new string[] {@"ActiveDirectoryQuery"})]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"UU.Integrations.Common.PropertySchema", typeof(global::UU.Integrations.Common.PropertySchema))]
    public sealed class ADSendAdapterSolicitResponseIndividualQuery : Microsoft.XLANGs.BaseTypes.SchemaBase {
        
        [System.NonSerializedAttribute()]
        private static object _rawSchema;
        
        [System.NonSerializedAttribute()]
        private const string _strSchema = @"<?xml version=""1.0"" encoding=""utf-16""?>
<xs:schema xmlns=""http://UU.Integrations.Common.Schemas.ADSendAdapterSolicitResponseIndividualQuery"" xmlns:b=""http://schemas.microsoft.com/BizTalk/2003"" xmlns:ns0=""https://UU.Integrations.Common.PropertySchema"" elementFormDefault=""qualified"" targetNamespace=""http://UU.Integrations.Common.Schemas.ADSendAdapterSolicitResponseIndividualQuery"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"">
  <xs:annotation>
    <xs:appinfo>
      <b:imports>
        <b:namespace prefix=""ns0"" uri=""https://UU.Integrations.Common.PropertySchema"" location=""UU.Integrations.Common.PropertySchema"" />
      </b:imports>
    </xs:appinfo>
  </xs:annotation>
  <xs:element name=""ActiveDirectoryQuery"">
    <xs:annotation>
      <xs:appinfo>
        <b:properties>
          <b:property name=""ns0:PersonNumber"" xpath=""/*[local-name()='ActiveDirectoryQuery' and namespace-uri()='http://UU.Integrations.Common.Schemas.ADSendAdapterSolicitResponseIndividualQuery']/*[local-name()='Directives' and namespace-uri()='http://UU.Integrations.Common.Schemas.ADSendAdapterSolicitResponseIndividualQuery']/@*[local-name()='PersonNumber' and namespace-uri()='']"" />
        </b:properties>
      </xs:appinfo>
    </xs:annotation>
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""Directives"">
          <xs:complexType>
            <xs:attribute name=""WhereToBind"" type=""xs:string"" use=""required"" />
            <xs:attribute name=""Username"" type=""xs:string"" />
            <xs:attribute name=""Password"" type=""xs:string"" />
            <xs:attribute name=""Filter"" type=""xs:string"" />
            <xs:attribute default=""subtree"" name=""SearchScope"">
              <xs:simpleType>
                <xs:restriction base=""xs:string"">
                  <xs:enumeration value=""onelevel"" />
                  <xs:enumeration value=""subtree"" />
                </xs:restriction>
              </xs:simpleType>
            </xs:attribute>
            <xs:attribute name=""PropertiesToReturn"" type=""xs:string"" />
            <xs:attribute name=""PageSize"" type=""xs:string"" use=""optional"" />
            <xs:attribute name=""PersonNumber"" type=""xs:string"" />
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
</xs:schema>";
        
        public ADSendAdapterSolicitResponseIndividualQuery() {
        }
        
        public override string XmlContent {
            get {
                return _strSchema;
            }
        }
        
        public override string[] RootNodes {
            get {
                string[] _RootElements = new string [1];
                _RootElements[0] = "ActiveDirectoryQuery";
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
