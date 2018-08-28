namespace Shared.Schemas.Ladok.Envelopes {
    using Microsoft.XLANGs.BaseTypes;
    
    
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.BizTalk.Schema.Compiler", "3.0.1.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [SchemaType(SchemaTypeEnum.Document)]
    [Schema(@"http://ladok.uu.envelope.schemas",@"DelayedUppehallStartEnvelopePromoted")]
    [System.SerializableAttribute()]
    [SchemaRoots(new string[] {@"DelayedUppehallStartEnvelopePromoted"})]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se_studentinformation", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se_studentinformation))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande", typeof(global::Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande))]
    [Microsoft.XLANGs.BaseTypes.SchemaReference(@"Shared.Schemas.Ladok.InternalMarkningsvarden", typeof(global::Shared.Schemas.Ladok.InternalMarkningsvarden))]
    public sealed class DelayedUppehallStartEnvelopePromoted : Microsoft.XLANGs.BaseTypes.SchemaBase {
        
        [System.NonSerializedAttribute()]
        private static object _rawSchema;
        
        [System.NonSerializedAttribute()]
        private const string _strSchema = @"<?xml version=""1.0"" encoding=""utf-16""?>
<xs:schema xmlns:in=""http://UU.Integrations.Common.Schemas"" xmlns:si=""http://schemas.ladok.se/studentinformation"" xmlns:ui=""http://schemas.ladok.se/utbildningsinformation"" xmlns:b=""http://schemas.microsoft.com/BizTalk/2003"" xmlns=""http://ladok.uu.envelope.schemas"" xmlns:sd=""http://schemas.ladok.se/studiedeltagande"" targetNamespace=""http://ladok.uu.envelope.schemas"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"">
  <xs:import schemaLocation=""Shared.Schemas.Ladok.schemas_ladok_se_studentinformation"" namespace=""http://schemas.ladok.se/studentinformation"" />
  <xs:import schemaLocation=""Shared.Schemas.Ladok.schemas_ladok_se_utbildningsinformation"" namespace=""http://schemas.ladok.se/utbildningsinformation"" />
  <xs:import schemaLocation=""Shared.Schemas.Ladok.schemas_ladok_se_studiedeltagande"" namespace=""http://schemas.ladok.se/studiedeltagande"" />
  <xs:import schemaLocation=""Shared.Schemas.Ladok.InternalMarkningsvarden"" namespace=""http://UU.Integrations.Common.Schemas"" />
  <xs:annotation>
    <xs:appinfo>
      <b:references>
        <b:reference targetNamespace=""http://UU.Integrations.Common.Schemas"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/dap"" />
        <b:reference targetNamespace=""http://schemas.ladok.se"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/utbildningsinformation"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/studentinformation"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/events"" />
        <b:reference targetNamespace=""http://schemas.ladok.se/studiedeltagande"" />
      </b:references>
    </xs:appinfo>
  </xs:annotation>
  <xs:element name=""DelayedUppehallStartEnvelopePromoted"">
    <xs:complexType>
      <xs:sequence>
        <xs:element ref=""sd:UppehallEvent"" />
        <xs:element ref=""si:Student"" />
        <xs:element ref=""si:Kontaktuppgifter"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
</xs:schema>";
        
        public DelayedUppehallStartEnvelopePromoted() {
        }
        
        public override string XmlContent {
            get {
                return _strSchema;
            }
        }
        
        public override string[] RootNodes {
            get {
                string[] _RootElements = new string [1];
                _RootElements[0] = "DelayedUppehallStartEnvelopePromoted";
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
