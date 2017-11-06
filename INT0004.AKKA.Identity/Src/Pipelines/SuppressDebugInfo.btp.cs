namespace INT0004.AKKA.Identity.Pipelines
{
    using System;
    using System.Collections.Generic;
    using Microsoft.BizTalk.PipelineOM;
    using Microsoft.BizTalk.Component;
    using Microsoft.BizTalk.Component.Interop;
    
    
    public sealed class SuppressDebugInfo : Microsoft.BizTalk.PipelineOM.ReceivePipeline
    {
        
        private const string _strPipeline = "<?xml version=\"1.0\" encoding=\"utf-16\"?><Document xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instanc"+
"e\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" MajorVersion=\"1\" MinorVersion=\"0\">  <Description /> "+
" <CategoryId>f66b9f5e-43ff-4f5f-ba46-885348ae1b4e</CategoryId>  <FriendlyName>Receive</FriendlyName>"+
"  <Stages>    <Stage>      <PolicyFileStage _locAttrData=\"Name\" _locID=\"1\" Name=\"Decode\" minOccurs=\""+
"0\" maxOccurs=\"-1\" execMethod=\"All\" stageId=\"9d0e4103-4cce-4536-83fa-4a5040674ad6\" />      <Component"+
"s />    </Stage>    <Stage>      <PolicyFileStage _locAttrData=\"Name\" _locID=\"2\" Name=\"Disassemble\" "+
"minOccurs=\"0\" maxOccurs=\"-1\" execMethod=\"FirstMatch\" stageId=\"9d0e4105-4cce-4536-83fa-4a5040674ad6\" "+
"/>      <Components>        <Component>          <Name>Microsoft.BizTalk.Component.XmlDasmComp,Micro"+
"soft.BizTalk.Pipeline.Components, Version=3.0.1.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35<"+
"/Name>          <ComponentName>XML disassembler</ComponentName>          <Description>Streaming XML "+
"disassembler</Description>          <Version>1.0</Version>          <Properties>            <Propert"+
"y Name=\"EnvelopeSpecNames\">              <Value xsi:type=\"xsd:string\" />            </Property>     "+
"       <Property Name=\"EnvelopeSpecTargetNamespaces\">              <Value xsi:type=\"xsd:string\" />  "+
"          </Property>            <Property Name=\"DocumentSpecNames\">              <Value xsi:type=\"x"+
"sd:string\" />            </Property>            <Property Name=\"DocumentSpecTargetNamespaces\">      "+
"        <Value xsi:type=\"xsd:string\" />            </Property>            <Property Name=\"AllowUnrec"+
"ognizedMessage\">              <Value xsi:type=\"xsd:boolean\">false</Value>            </Property>    "+
"        <Property Name=\"ValidateDocument\">              <Value xsi:type=\"xsd:boolean\">false</Value> "+
"           </Property>            <Property Name=\"RecoverableInterchangeProcessing\">              <V"+
"alue xsi:type=\"xsd:boolean\">false</Value>            </Property>            <Property Name=\"HiddenPr"+
"operties\">              <Value xsi:type=\"xsd:string\">EnvelopeSpecTargetNamespaces,DocumentSpecTarget"+
"Namespaces</Value>            </Property>          </Properties>          <CachedDisplayName>XML dis"+
"assembler</CachedDisplayName>          <CachedIsManaged>true</CachedIsManaged>        </Component>  "+
"    </Components>    </Stage>    <Stage>      <PolicyFileStage _locAttrData=\"Name\" _locID=\"3\" Name=\""+
"Validate\" minOccurs=\"0\" maxOccurs=\"-1\" execMethod=\"All\" stageId=\"9d0e410d-4cce-4536-83fa-4a5040674ad"+
"6\" />      <Components>        <Component>          <Name>BizTalk.PipelineComponents.AddContextPrope"+
"rties,BizTalk.PipelineComponents.PromoteTypedContext, Version=1.0.0.0, Culture=neutral, PublicKeyTok"+
"en=2dbe33dac94b8972</Name>          <ComponentName>Context Adder</ComponentName>          <Descripti"+
"on>Add typed context properties</Description>          <Version>1.0.0.0</Version>          <Properti"+
"es>            <Property Name=\"Namespaces\">              <Value xsi:type=\"xsd:string\" />            "+
"</Property>            <Property Name=\"Properties\">              <Value xsi:type=\"xsd:string\">&lt;Ar"+
"rayOfContextValue xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org"+
"/2001/XMLSchema\"&gt;&lt;ContextValue&gt;&lt;Prefix&gt;BTS&lt;/Prefix&gt;&lt;Value&gt;True&lt;/Value&"+
"gt;&lt;Key&gt;SuppressRoutingFailureDiagnosticInfo&lt;/Key&gt;&lt;Namespace&gt;http://schemas.micros"+
"oft.com/BizTalk/2003/system-properties&lt;/Namespace&gt;&lt;Code&gt;Boolean&lt;/Code&gt;&lt;/Context"+
"Value&gt;&lt;/ArrayOfContextValue&gt;</Value>            </Property>            <Property Name=\"BTS."+
"SuppressRoutingFailureDiagnosticInfo\">              <Value xsi:type=\"xsd:string\">True</Value>       "+
"     </Property>            <Property Name=\"HiddenProperties\">              <Value xsi:type=\"xsd:str"+
"ing\">Properties,Namespaces</Value>            </Property>          </Properties>          <CachedDis"+
"playName>Context Adder</CachedDisplayName>          <CachedIsManaged>true</CachedIsManaged>        <"+
"/Component>      </Components>    </Stage>    <Stage>      <PolicyFileStage _locAttrData=\"Name\" _loc"+
"ID=\"4\" Name=\"ResolveParty\" minOccurs=\"0\" maxOccurs=\"-1\" execMethod=\"All\" stageId=\"9d0e410e-4cce-4536"+
"-83fa-4a5040674ad6\" />      <Components />    </Stage>  </Stages></Document>";
        
        private const string _versionDependentGuid = "3f0e948e-f30e-4496-a63e-aaef2c2ef451";
        
        public SuppressDebugInfo()
        {
            Microsoft.BizTalk.PipelineOM.Stage stage = this.AddStage(new System.Guid("9d0e4105-4cce-4536-83fa-4a5040674ad6"), Microsoft.BizTalk.PipelineOM.ExecutionMode.firstRecognized);
            IBaseComponent comp0 = Microsoft.BizTalk.PipelineOM.PipelineManager.CreateComponent("Microsoft.BizTalk.Component.XmlDasmComp,Microsoft.BizTalk.Pipeline.Components, Version=3.0.1.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35");;
            if (comp0 is IPersistPropertyBag)
            {
                string comp0XmlProperties = "<?xml version=\"1.0\" encoding=\"utf-16\"?><PropertyBag xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-inst"+
"ance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">  <Properties>    <Property Name=\"EnvelopeSpecNam"+
"es\">      <Value xsi:type=\"xsd:string\" />    </Property>    <Property Name=\"EnvelopeSpecTargetNamesp"+
"aces\">      <Value xsi:type=\"xsd:string\" />    </Property>    <Property Name=\"DocumentSpecNames\">   "+
"   <Value xsi:type=\"xsd:string\" />    </Property>    <Property Name=\"DocumentSpecTargetNamespaces\"> "+
"     <Value xsi:type=\"xsd:string\" />    </Property>    <Property Name=\"AllowUnrecognizedMessage\">   "+
"   <Value xsi:type=\"xsd:boolean\">false</Value>    </Property>    <Property Name=\"ValidateDocument\"> "+
"     <Value xsi:type=\"xsd:boolean\">false</Value>    </Property>    <Property Name=\"RecoverableInterc"+
"hangeProcessing\">      <Value xsi:type=\"xsd:boolean\">false</Value>    </Property>    <Property Name="+
"\"HiddenProperties\">      <Value xsi:type=\"xsd:string\">EnvelopeSpecTargetNamespaces,DocumentSpecTarge"+
"tNamespaces</Value>    </Property>  </Properties></PropertyBag>";
                PropertyBag pb = PropertyBag.DeserializeFromXml(comp0XmlProperties);;
                ((IPersistPropertyBag)(comp0)).Load(pb, 0);
            }
            this.AddComponent(stage, comp0);
            stage = this.AddStage(new System.Guid("9d0e410d-4cce-4536-83fa-4a5040674ad6"), Microsoft.BizTalk.PipelineOM.ExecutionMode.all);
            IBaseComponent comp1 = Microsoft.BizTalk.PipelineOM.PipelineManager.CreateComponent("BizTalk.PipelineComponents.AddContextProperties,BizTalk.PipelineComponents.PromoteTypedContext, Version=1.0.0.0, Culture=neutral, PublicKeyToken=2dbe33dac94b8972");;
            if (comp1 is IPersistPropertyBag)
            {
                string comp1XmlProperties = "<?xml version=\"1.0\" encoding=\"utf-16\"?><PropertyBag xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-inst"+
"ance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">  <Properties>    <Property Name=\"Namespaces\">   "+
"   <Value xsi:type=\"xsd:string\" />    </Property>    <Property Name=\"Properties\">      <Value xsi:ty"+
"pe=\"xsd:string\">&lt;ArrayOfContextValue xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:"+
"xsd=\"http://www.w3.org/2001/XMLSchema\"&gt;&lt;ContextValue&gt;&lt;Prefix&gt;BTS&lt;/Prefix&gt;&lt;Va"+
"lue&gt;True&lt;/Value&gt;&lt;Key&gt;SuppressRoutingFailureDiagnosticInfo&lt;/Key&gt;&lt;Namespace&gt"+
";http://schemas.microsoft.com/BizTalk/2003/system-properties&lt;/Namespace&gt;&lt;Code&gt;Boolean&lt"+
";/Code&gt;&lt;/ContextValue&gt;&lt;/ArrayOfContextValue&gt;</Value>    </Property>    <Property Name"+
"=\"BTS.SuppressRoutingFailureDiagnosticInfo\">      <Value xsi:type=\"xsd:string\">True</Value>    </Pro"+
"perty>    <Property Name=\"HiddenProperties\">      <Value xsi:type=\"xsd:string\">Properties,Namespaces"+
"</Value>    </Property>  </Properties></PropertyBag>";
                PropertyBag pb = PropertyBag.DeserializeFromXml(comp1XmlProperties);;
                ((IPersistPropertyBag)(comp1)).Load(pb, 0);
            }
            this.AddComponent(stage, comp1);
        }
        
        public override string XmlContent
        {
            get
            {
                return _strPipeline;
            }
        }
        
        public override System.Guid VersionDependentGuid
        {
            get
            {
                return new System.Guid(_versionDependentGuid);
            }
        }
    }
}
