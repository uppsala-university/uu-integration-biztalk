namespace INT0003.AD.Distribution.Pipelines
{
    using System;
    using System.Collections.Generic;
    using Microsoft.BizTalk.PipelineOM;
    using Microsoft.BizTalk.Component;
    using Microsoft.BizTalk.Component.Interop;
    
    
    public sealed class MapGroupToAD : Microsoft.BizTalk.PipelineOM.SendPipeline
    {
        
        private const string _strPipeline = "<?xml version=\"1.0\" encoding=\"utf-16\"?><Document xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instanc"+
"e\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" MajorVersion=\"1\" MinorVersion=\"0\">  <Description /> "+
" <CategoryId>8c6b051c-0ff5-4fc2-9ae5-5016cb726282</CategoryId>  <FriendlyName>Transmit</FriendlyName"+
">  <Stages>    <Stage>      <PolicyFileStage _locAttrData=\"Name\" _locID=\"1\" Name=\"Pre-Assemble\" minO"+
"ccurs=\"0\" maxOccurs=\"-1\" execMethod=\"All\" stageId=\"9d0e4101-4cce-4536-83fa-4a5040674ad6\" />      <Co"+
"mponents />    </Stage>    <Stage>      <PolicyFileStage _locAttrData=\"Name\" _locID=\"2\" Name=\"Assemb"+
"le\" minOccurs=\"0\" maxOccurs=\"1\" execMethod=\"All\" stageId=\"9d0e4107-4cce-4536-83fa-4a5040674ad6\" />  "+
"    <Components />    </Stage>    <Stage>      <PolicyFileStage _locAttrData=\"Name\" _locID=\"3\" Name="+
"\"Encode\" minOccurs=\"0\" maxOccurs=\"-1\" execMethod=\"All\" stageId=\"9d0e4108-4cce-4536-83fa-4a5040674ad6"+
"\" />      <Components>        <Component>          <Name>BizTalkComponents.PipelineComponents.XSLTTr"+
"ansform,BizTalkComponents.PipelineComponents.XSLTransform, Version=1.0.0.1, Culture=neutral, PublicK"+
"eyToken=47190f56632fbc76</Name>          <ComponentName>XSLT Transformation</ComponentName>         "+
" <Description>Pipeline Component to apply BizTalk map with context as argument.</Description>       "+
"   <Version>1.0.0</Version>          <Properties>            <Property Name=\"MapName\" />            "+
"<Property Name=\"Parameters\">              <Value xsi:type=\"xsd:string\">groupPrefix=?</Value>        "+
"    </Property>          </Properties>          <CachedDisplayName>XSLT Transformation</CachedDispla"+
"yName>          <CachedIsManaged>true</CachedIsManaged>        </Component>      </Components>    </"+
"Stage>  </Stages></Document>";
        
        private const string _versionDependentGuid = "5c12b561-a1bb-4bc0-b2f9-32d23c718ec1";
        
        public MapGroupToAD()
        {
            Microsoft.BizTalk.PipelineOM.Stage stage = this.AddStage(new System.Guid("9d0e4108-4cce-4536-83fa-4a5040674ad6"), Microsoft.BizTalk.PipelineOM.ExecutionMode.all);
            IBaseComponent comp0 = Microsoft.BizTalk.PipelineOM.PipelineManager.CreateComponent("BizTalkComponents.PipelineComponents.XSLTTransform,BizTalkComponents.PipelineComponents.XSLTransform, Version=1.0.0.1, Culture=neutral, PublicKeyToken=47190f56632fbc76");;
            if (comp0 is IPersistPropertyBag)
            {
                string comp0XmlProperties = "<?xml version=\"1.0\" encoding=\"utf-16\"?><PropertyBag xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-inst"+
"ance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">  <Properties>    <Property Name=\"MapName\" />    "+
"<Property Name=\"Parameters\">      <Value xsi:type=\"xsd:string\">groupPrefix=?</Value>    </Property> "+
" </Properties></PropertyBag>";
                PropertyBag pb = PropertyBag.DeserializeFromXml(comp0XmlProperties);;
                ((IPersistPropertyBag)(comp0)).Load(pb, 0);
            }
            this.AddComponent(stage, comp0);
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
