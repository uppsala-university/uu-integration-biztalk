namespace INT0001.Ladok2.Events.Pipelines
{
    using System;
    using System.Collections.Generic;
    using Microsoft.BizTalk.PipelineOM;
    using Microsoft.BizTalk.Component;
    using Microsoft.BizTalk.Component.Interop;
    
    
    public sealed class ProcessAck_SendPipeline : Microsoft.BizTalk.PipelineOM.SendPipeline
    {
        
        private const string _strPipeline = "<?xml version=\"1.0\" encoding=\"utf-16\"?><Document xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instanc"+
"e\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" MajorVersion=\"1\" MinorVersion=\"0\">  <Description /> "+
" <CategoryId>8c6b051c-0ff5-4fc2-9ae5-5016cb726282</CategoryId>  <FriendlyName>Transmit</FriendlyName"+
">  <Stages>    <Stage>      <PolicyFileStage _locAttrData=\"Name\" _locID=\"1\" Name=\"Pre-Assemble\" minO"+
"ccurs=\"0\" maxOccurs=\"-1\" execMethod=\"All\" stageId=\"9d0e4101-4cce-4536-83fa-4a5040674ad6\" />      <Co"+
"mponents>        <Component>          <Name>BizTalkComponents.PipelineComponents.ContextToXml,BizTal"+
"k.PipelineComponents.ContextToXml, Version=1.0.0.0, Culture=neutral, PublicKeyToken=47190f56632fbc76"+
"</Name>          <ComponentName>Context to Xml</ComponentName>          <Description>Pipeline Compon"+
"ent that coverts context to a xm message. Original message will be descarded</Description>          "+
"<Version>1.0.0</Version>          <Properties />          <CachedDisplayName>Context to Xml</CachedD"+
"isplayName>          <CachedIsManaged>true</CachedIsManaged>        </Component>      </Components> "+
"   </Stage>    <Stage>      <PolicyFileStage _locAttrData=\"Name\" _locID=\"2\" Name=\"Assemble\" minOccur"+
"s=\"0\" maxOccurs=\"1\" execMethod=\"All\" stageId=\"9d0e4107-4cce-4536-83fa-4a5040674ad6\" />      <Compone"+
"nts />    </Stage>    <Stage>      <PolicyFileStage _locAttrData=\"Name\" _locID=\"3\" Name=\"Encode\" min"+
"Occurs=\"0\" maxOccurs=\"-1\" execMethod=\"All\" stageId=\"9d0e4108-4cce-4536-83fa-4a5040674ad6\" />      <C"+
"omponents>        <Component>          <Name>BizTalkComponents.PipelineComponents.XSLTTransform,BizT"+
"alkComponents.PipelineComponents.XSLTransform, Version=1.0.0.1, Culture=neutral, PublicKeyToken=4719"+
"0f56632fbc76</Name>          <ComponentName>XSLT Transformation</ComponentName>          <Descriptio"+
"n>Pipeline Component to apply BizTalk map with context as argument.</Description>          <Version>"+
"1.0.0</Version>          <Properties>            <Property Name=\"MapName\" />            <Property Na"+
"me=\"Parameters\" />          </Properties>          <CachedDisplayName>XSLT Transformation</CachedDis"+
"playName>          <CachedIsManaged>true</CachedIsManaged>        </Component>      </Components>   "+
" </Stage>  </Stages></Document>";
        
        private const string _versionDependentGuid = "3ac80383-5c14-4ec4-a6d5-2507f421d134";
        
        public ProcessAck_SendPipeline()
        {
            Microsoft.BizTalk.PipelineOM.Stage stage = this.AddStage(new System.Guid("9d0e4101-4cce-4536-83fa-4a5040674ad6"), Microsoft.BizTalk.PipelineOM.ExecutionMode.all);
            IBaseComponent comp0 = Microsoft.BizTalk.PipelineOM.PipelineManager.CreateComponent("BizTalkComponents.PipelineComponents.ContextToXml,BizTalk.PipelineComponents.ContextToXml, Version=1.0.0.0, Culture=neutral, PublicKeyToken=47190f56632fbc76");;
            if (comp0 is IPersistPropertyBag)
            {
                string comp0XmlProperties = "<?xml version=\"1.0\" encoding=\"utf-16\"?><PropertyBag xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-inst"+
"ance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">  <Properties /></PropertyBag>";
                PropertyBag pb = PropertyBag.DeserializeFromXml(comp0XmlProperties);;
                ((IPersistPropertyBag)(comp0)).Load(pb, 0);
            }
            this.AddComponent(stage, comp0);
            stage = this.AddStage(new System.Guid("9d0e4108-4cce-4536-83fa-4a5040674ad6"), Microsoft.BizTalk.PipelineOM.ExecutionMode.all);
            IBaseComponent comp1 = Microsoft.BizTalk.PipelineOM.PipelineManager.CreateComponent("BizTalkComponents.PipelineComponents.XSLTTransform,BizTalkComponents.PipelineComponents.XSLTransform, Version=1.0.0.1, Culture=neutral, PublicKeyToken=47190f56632fbc76");;
            if (comp1 is IPersistPropertyBag)
            {
                string comp1XmlProperties = "<?xml version=\"1.0\" encoding=\"utf-16\"?><PropertyBag xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-inst"+
"ance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">  <Properties>    <Property Name=\"MapName\" />    "+
"<Property Name=\"Parameters\" />  </Properties></PropertyBag>";
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
