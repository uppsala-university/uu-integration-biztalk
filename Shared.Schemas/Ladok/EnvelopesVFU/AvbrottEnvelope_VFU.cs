namespace Shared.Schemas.Ladok {
    using Microsoft.XLANGs.BaseTypes;
    
    
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.BizTalk.Schema.Compiler", "3.0.1.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [SchemaType(SchemaTypeEnum.Document)]
    [Schema(@"http://ladok.uu.envelope.vfu.schema",@"RegistreringEnvelope_VFU")]
    [System.SerializableAttribute()]
    [SchemaRoots(new string[] {@"RegistreringEnvelope_VFU"})]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se_studentinformation", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se_studentinformation))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.RegistreringEnvelope", typeof(global::Shared.Schemas.Ladok.RegistreringEnvelope))]
    public sealed class RegistreringEnvelope_VFU : Microsoft.XLANGs.BaseTypes.SchemaBase {
        
        [System.NonSerializedAttribute()]
        private static object _rawSchema;
        
        [System.NonSerializedAttribute()]
        private const string _strSchema = @"<?xml version=""1.0"" encoding=""utf-16""?>
<xs:schema xmlns:sd=""http://schemas.ladok.se/studiedeltagande"" xmlns:si=""http://schemas.ladok.se/studentinformation"" xmlns:ui=""http://schemas.ladok.se/utbildningsinformation"" xmlns:b=""http://schemas.microsoft.com/BizTalk/2003"" xmlns=""http://UU.Integrations.Common.Schemas"" xmlns:en=""http://ladok.uu.envelope.schemas"" targetNamespace=""http://ladok.uu.envelope.vfu.schema"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"">
  <xs:import schemaLocation=""Shared.Schemas.Ladok.schemas_ladok_se_studentinformation"" namespace=""http://schemas.ladok.se/studentinformation"" />
  <xs:import schemaLocation=""Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation"" namespace=""http://schemas.ladok.se/utbildningsinformation"" />
  <xs:import schemaLocation=""Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande"" namespace=""http://schemas.ladok.se/studiedeltagande"" />
  <xs:import schemaLocation=""Shared.Schemas.Ladok.RegistreringEnvelope"" namespace=""http://ladok.uu.envelope.schemas"" />
  <xs:annotation>
    <xs:appinfo>
      <b:references>
        <b:reference targetNamespace=""http://UU.Integrations.Common.Schemas"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/dap"" />
        <b:reference targetNamespace=""http://schemas.ladok.se"" />
        <b:reference targetNamespace=""http://ladok.uu.envelope.schemas"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/utbildningsinformation"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/studentinformation"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/kataloginformation"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/events"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/studiedeltagande"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/avisering"" />
      </b:references>
    </xs:appinfo>
  </xs:annotation>
  <xs:element name=""RegistreringEnvelope_VFU"">
    <xs:complexType>
      <xs:sequence>
        <xs:element ref=""en:RegistreringEnvelope"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
</xs:schema>";
        
        public RegistreringEnvelope_VFU() {
        }
        
        public override string XmlContent {
            get {
                return _strSchema;
            }
        }
        
        public override string[] RootNodes {
            get {
                string[] _RootElements = new string [1];
                _RootElements[0] = "RegistreringEnvelope_VFU";
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
