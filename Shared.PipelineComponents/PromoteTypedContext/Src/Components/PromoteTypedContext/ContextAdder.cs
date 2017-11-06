using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.BizTalk.Component.Utilities;
using Microsoft.BizTalk.Component.Interop;
using Microsoft.BizTalk.Message.Interop;
using System.Resources;
using System.Reflection;
using System.Drawing;
using System.Runtime.InteropServices;
using System.IO;
using System.Xml;
using System.Threading;
using System.Collections;
using System.Collections.Specialized;
using System.ComponentModel.Design;
using System.Text.RegularExpressions;
using BizTalkComponents.Utils;

namespace BizTalk.PipelineComponents
{

    [ComponentCategory(CategoryTypes.CATID_PipelineComponent)]
    [ComponentCategory(CategoryTypes.CATID_Any)]
    [System.Runtime.InteropServices.Guid("9FA416D7-88F6-4005-885D-8CB3AC56AF41")]
    public class AddContextProperties : IBaseComponent, IComponent, IComponentUI, IPersistPropertyBag
    {

        
        #region Properties



        
        //private ContextValueCollection properties = null;
        private ContextValueCollection properties = null;

        private NamespaceCollection namespaces = null;

       

        public AddContextProperties()
        {

            
        }

       

       

        [System.ComponentModel.Browsable(true)]
        [System.ComponentModel.Editor(typeof(NamespaceCollectionEditor), typeof(System.Drawing.Design.UITypeEditor))]
        public NamespaceCollection Namespaces
        {
            get
            {
                if (namespaces == null)
                    namespaces = new NamespaceCollection();

                return this.namespaces;
            }
            set
            {
                if (value == null)
                    throw new ArgumentNullException("Namespace values not specified");
                this.namespaces = value;

            }

        }

       

       [System.ComponentModel.Browsable(true)]
       [System.ComponentModel.Editor(typeof(ContextValueCollectionEditor), typeof(System.Drawing.Design.UITypeEditor))]
        public ContextValueCollection Properties
        {
            get
            {
                if (properties == null)
                    properties = new ContextValueCollection();

                properties.Namespaces = Namespaces;
                
                return properties;
            }
            set
            {
                if (value == null)
                    throw new ArgumentNullException("Context values not specified");
                this.properties = value;
               
            }

        }

      
        

        #endregion

        #region IBaseComponent Members
        [System.ComponentModel.Browsable(false)]
        public string Description
        {
            get
            {
                return "Add typed context properties";
            }
        }
        [System.ComponentModel.Browsable(false)]
        public string Name
        {
            get
            {
                return "Context Adder";
            }
        }
        [System.ComponentModel.Browsable(false)]
        public string Version
        {
            get
            {
                return "1.0.0.0";
            }
        }

        #endregion

        #region IComponent Members

        public IBaseMessage Execute(IPipelineContext pContext, IBaseMessage pInMsg)
        {
           
            
            IEnumerator e = Properties.GetEnumerator();
            while (e.MoveNext())
            {
                ContextValue v = (ContextValue)e.Current;

                //2017-09-09 Added possibility to use expression instead of a static value
                object obj = ScriptExpressionHelper.Expression(v.Value);
                var value = Convert.ChangeType(obj, v.Code);

                

                pInMsg.Context.Promote(v.Key, v.Namespace, value);

            }
            return pInMsg;
        }

        #endregion

        #region IComponentUI Members

        public System.Collections.IEnumerator Validate(object projectSystem)
        {
            return null;
        }
        [System.ComponentModel.Browsable(false)]
        public System.IntPtr Icon
        {
            get
            {
                return IntPtr.Zero;
            }
        }

        #endregion

        #region IPersistPropertyBag Members

        public void InitNew()
        {
        }

        public void GetClassID(out Guid classID)
        {
            classID = new Guid("9FA416D7-88F6-4005-885D-8CB3AC56AF41");
        }

        object ReadProperty(IPropertyBag propertyBag, string key)
        {
            object val = null;
            try
            {
                propertyBag.Read(key, out val, 0);
            }
            catch
            {
            }
            return val;

        }

        public void Load(IPropertyBag propertyBag, int errorLog)
        {

            object val = ReadProperty(propertyBag, "Namespaces");

            if (val != null)
            { 
                Namespaces.SetCollection((string)val); 
            }
           
                

            val = ReadProperty(propertyBag, "Properties");

            if(val != null)
            { 
                Properties = ContextValueCollection.Deserialize((string)val);
                Properties.Namespaces = Namespaces;
            }
           
              


            foreach (ContextValue context in Properties)
            {

                   string name = String.Format("{0}.{1}", context.Prefix, context.Key);

                    val = ReadProperty(propertyBag, name);

                    if (val != null)
                        context.Value = (string)val;
                
                       
            }

            
        }

        private string HiddenProperties(IPropertyBag propertyBag,ContextValueCollection contexts)
        {
            string hidden = String.Empty; 
            string props = String.Empty;
            ContextValueCollection saved_context = null;

            
            hidden = PropertyBagHelper.ReadPropertyBag<string>(propertyBag,"HiddenProperties","Properties,Namespaces");

            if (hidden == null)
                return "Properties,Namespaces";

            props = PropertyBagHelper.ReadPropertyBag<string>(propertyBag,"Properties",String.Empty);
            
            saved_context = ContextValueCollection.Deserialize(props);


            foreach (ContextValue context in saved_context)
	        {
		        if(contexts.Contains(context) == false)
                {
                    if(hidden.IndexOf(context.ToString()) < 0)
                        hidden = String.Format("{0},{1}",hidden,context.ToString());
                }
	        }


            return hidden.Replace(",,", ",");
        }

        public void Save(IPropertyBag propertyBag, bool clearDirty, bool saveAllProperties)
        {

            string hidden = HiddenProperties(propertyBag, properties);


            propertyBag.Write("Namespaces", Namespaces.ToString());

            propertyBag.Write("Properties", Properties.Serialize());

            foreach (ContextValue context in Properties)
            {


                string name = context.ToString();
                propertyBag.Write(name, context.Value);

                if (hidden != String.Empty && hidden.IndexOf(name) >= 0)
                    hidden = hidden.Replace(name, "");


            }


            hidden = hidden.Replace(",,", ",");



            propertyBag.Write("HiddenProperties", hidden);

        }
        

        #endregion
    }
}
