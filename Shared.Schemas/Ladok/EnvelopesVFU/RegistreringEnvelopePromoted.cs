namespace Shared.Schemas.Ladok {
    using Microsoft.XLANGs.BaseTypes;
    
    
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.BizTalk.Schema.Compiler", "3.0.1.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [SchemaType(SchemaTypeEnum.Document)]
    [Schema(@"http://ladok.uu.envelope.schemas",@"RegistreringEnvelope")]
    [Microsoft.XLANGs.BaseTypes.PropertyAttribute(typeof(global::Shared.Schemas.Ladok.PropertySchema.Period), XPath = @"/*[local-name()='RegistreringEnvelope' and namespace-uri()='http://ladok.uu.envelope.schemas']/*[local-name()='RegistreringEvent' and namespace-uri()='http://schemas.ladok.se/studiedeltagande']/*[local-name()='Period' and namespace-uri()='http://schemas.ladok.se/studiedeltagande']", XsdType = @"int")]
    [System.SerializableAttribute()]
    [SchemaRoots(new string[] {@"RegistreringEnvelope"})]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se_studentinformation", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se_studentinformation))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se_kataloginformation", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se_kataloginformation))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.InternalMarkningsvarden", typeof(global::Shared.Schemas.Ladok.InternalMarkningsvarden))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.PropertySchema.PropertySchema", typeof(global::Shared.Schemas.Ladok.PropertySchema.PropertySchema))]
    public sealed class RegistreringEnvelope : Microsoft.XLANGs.BaseTypes.SchemaBase {
        
        [System.NonSerializedAttribute()]
        private static object _rawSchema;
        
        [System.NonSerializedAttribute()]
        private const string _strSchema = @"<?xml version=""1.0"" encoding=""utf-16""?>
<xs:schema xmlns:in=""http://UU.Integrations.Common.Schemas"" xmlns:base=""http://schemas.ladok.se"" xmlns:si=""http://schemas.ladok.se/studentinformation"" xmlns:ui=""http://schemas.ladok.se/utbildningsinformation"" xmlns:b=""http://schemas.microsoft.com/BizTalk/2003"" xmlns:ns0=""https://Shared.Schemas.Ladok.PropertySchema"" xmlns=""http://ladok.uu.envelope.schemas"" xmlns:ki=""http://schemas.ladok.se/kataloginformation"" xmlns:sd=""http://schemas.ladok.se/studiedeltagande"" targetNamespace=""http://ladok.uu.envelope.schemas"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"">
  <xs:import schemaLocation=""Shared.Schemas.Ladok.schemas_ladok_se_studentinformation"" namespace=""http://schemas.ladok.se/studentinformation"" />
  <xs:import schemaLocation=""Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation"" namespace=""http://schemas.ladok.se/utbildningsinformation"" />
  <xs:import schemaLocation=""Shared.Schemas.Ladok.schemas_ladok_se"" namespace=""http://schemas.ladok.se"" />
  <xs:import schemaLocation=""Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande"" namespace=""http://schemas.ladok.se/studiedeltagande"" />
  <xs:import schemaLocation=""Shared.Schemas.Ladok.schemas_ladok_se_kataloginformation"" namespace=""http://schemas.ladok.se/kataloginformation"" />
  <xs:import schemaLocation=""Shared.Schemas.Ladok.InternalMarkningsvarden"" namespace=""http://UU.Integrations.Common.Schemas"" />
  <xs:annotation>
    <xs:appinfo>
      <b:references>
        <b:reference targetNamespace=""http://UU.Integrations.Common.Schemas"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/dap"" />
        <b:reference targetNamespace=""http://schemas.ladok.se"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/utbildningsinformation"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/studentinformation"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/kataloginformation"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/events"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/studiedeltagande"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/avisering"" />
      </b:references>
      <b:imports>
        <b:namespace prefix=""ns0"" uri=""https://Shared.Schemas.Ladok.PropertySchema"" location=""Shared.Schemas.Ladok.PropertySchema.PropertySchema"" />
      </b:imports>
    </xs:appinfo>
  </xs:annotation>
  <xs:element name=""RegistreringEnvelope"">
    <xs:annotation>
      <xs:appinfo>
        <b:properties>
          <b:property name=""ns0:Period"" xpath=""/*[local-name()='RegistreringEnvelope' and namespace-uri()='http://ladok.uu.envelope.schemas']/*[local-name()='RegistreringEvent' and namespace-uri()='http://schemas.ladok.se/studiedeltagande']/*[local-name()='Period' and namespace-uri()='http://schemas.ladok.se/studiedeltagande']"" />
        </b:properties>
      </xs:appinfo>
    </xs:annotation>
    <xs:complexType>
      <xs:sequence>
        <xs:element ref=""sd:RegistreringEvent"" />
        <xs:element maxOccurs=""unbounded"" ref=""ui:Utbildningstillfalle"" />
        <xs:element ref=""ui:Utbildningsinstans"" />
        <xs:element ref=""si:Student"" />
        <xs:element ref=""si:Kontaktuppgifter"" />
        <xs:element ref=""ki:Organisation"" />
        <xs:element ref=""ui:Markningsnycklar"" />
        <xs:element ref=""in:InternalMarkningsvarden"" />
        <xs:element ref=""ui:Finansieringsformer"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
</xs:schema>";
        
        public RegistreringEnvelope() {
        }
        
        public override string XmlContent {
            get {
                return _strSchema;
            }
        }
        
        public override string[] RootNodes {
            get {
                string[] _RootElements = new string [1];
                _RootElements[0] = "RegistreringEnvelope";
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
