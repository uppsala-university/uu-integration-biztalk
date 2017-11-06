using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
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
using System.Xml.Serialization;

namespace BizTalk.PipelineComponents
{



    
    public class ContextValueCollectionEditor : System.Drawing.Design.UITypeEditor
    {
        
        CollectionEditor _editor;

        public ContextValueCollectionEditor()
        {
            _editor = new CollectionEditor(typeof(ContextValueCollection));

        }
        
        public override System.Drawing.Design.UITypeEditorEditStyle GetEditStyle(System.ComponentModel.ITypeDescriptorContext context)
        {
            return _editor.GetEditStyle(context);
        }

        public override object EditValue(System.ComponentModel.ITypeDescriptorContext context, IServiceProvider provider, object value)
        {

            //If unchanged return original collection or else create a new one.
            string state = ((ContextValueCollection)value).Serialize();

            ContextValueCollection coll = (ContextValueCollection)_editor.EditValue(context, provider, value);

            string new_state = coll.Serialize();

            if (state != new_state)
            {

                coll = ContextValueCollection.Deserialize(new_state);
              
            }
                
            return coll;
        }


    }

    
    public class ContextValueCollection : System.Collections.CollectionBase
    {
        private NamespaceCollection namespaces = null;

        static public ContextValueCollection Deserialize(string content)
        {
            XmlSerializer ser = new XmlSerializer(typeof(ContextValueCollection));
            return (ContextValueCollection)ser.Deserialize(new StringReader(content));

        }

        public string Serialize()
        {
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);

            XmlWriterSettings setting = new XmlWriterSettings();
            setting.OmitXmlDeclaration = true;
            XmlWriter writer = XmlWriter.Create(sw, setting);

            XmlSerializer ser = new XmlSerializer(typeof(ContextValueCollection));
            ser.Serialize(writer, this);

            return sb.ToString();
        }

        public ContextValueCollection()
        {
            namespaces = new NamespaceCollection();
        }

        public NamespaceCollection Namespaces
        {
            set{
                namespaces = value;
            }
            
        }


        public bool Contains(ContextValue context)
        {
            foreach (ContextValue item in this.InnerList)
            {
                if (item.ToString() == context.ToString())
                    return true;
            }

            return false;
           
        }
       
        protected  override void OnInsert(int index, Object value)
        {

            ContextValue context = (ContextValue)value;

            context.Namespaces = namespaces;

            base.OnInsert(index, value);

           
        }

        public void Add(ContextValue context)
        {
            this.InnerList.Add(context);
        }
        /*
        public bool KeyExist(string name,string ns)
        {
            get { 
                foreach (ContextValue context in this)
                {
                   
                    builder.AppendFormat("{0}#{1}@{3}={2};", context.Namespace, context.Key, Utils.EncodeSpecialCharacters(context.Value), (int)context.Code);
                }
            }
           
        }
        */
        public ContextValue this[int index]
        {
            get { return (ContextValue)this.InnerList[index]; }
            set { this.InnerList[index] = value; }
        }
        
        public override string ToString()
        {
            StringBuilder builder = new StringBuilder();
            string ns = String.Empty;

           
                foreach (ContextValue context in this)
                {
                   
                    builder.AppendFormat("{0}#{1}@{3}={2};", context.Namespace, context.Key, Utils.EncodeSpecialCharacters(context.Value), (int)context.Code);
                }
            
            
            
            return builder.ToString();

        }
        /*
        public void SetCollection(string stringCollection)
        {
            string[] arrCollection = stringCollection.Split(new char[] {';'}, StringSplitOptions.RemoveEmptyEntries);

            this.InnerList.Clear();
            string ns = String.Empty;

           

            foreach (string coll in arrCollection)
	        {
                
                string[] context = coll.Split(new char[] {'#','='}, StringSplitOptions.RemoveEmptyEntries);
                
                TypeCode type = TypeCode.String;
                string property = context[1];

                //2017-10-07 BUG found and fixed, pattern did only pick first number
                Match match = Regex.Match(property, @"@(\d*)$");

                if (match.Success == true)
                {
               
                    type = (TypeCode)Enum.Parse(typeof(TypeCode), match.Groups[1].Value);
                    property = property.Substring(0, property.Length - match.Value.Length);
                }




                this.InnerList.Add(new ContextValue { Key = property, Namespace = context[0], Value = Utils.DecodeSpecialCharacters(context[2]), Code = type });
	        }
            
        }
         * */
       

    }

    public class ContextValue
    {

        
        string _Namespace = String.Empty;
        string _Prefix = String.Empty;
        string _Value = String.Empty;
        string _Key = String.Empty;
        TypeCode type = TypeCode.String;
        NamespaceCollection namespaces = null;

        [System.ComponentModel.Browsable(false)]
        public NamespaceCollection Namespaces
        {
            set
            {
                namespaces = value;
            }

        }

        public override string ToString()
        {
            return _Key.Length > 0 ? String.Format("{0}.{1}",_Prefix, _Key): "Context value";
        }

        [System.ComponentModel.DisplayName("Namespace prefix")]
        public string Prefix
        {
            get { return _Prefix; }
            set
            {
                 _Prefix = value;

                 if (namespaces != null)
                 {
                     _Namespace = namespaces.GetNamespace(_Prefix);

                     if (String.IsNullOrEmpty(_Namespace))
                     {
                         _Prefix = String.Empty;
                     }
                 }
                

                //
            }
        }
           
        public string Value
        {
            get { return _Value; }
            set
            {
          
                _Value = value;
            }
        }

        [System.ComponentModel.DisplayName("Property name")]
        public string Key
        {
            get { return _Key; }
            set
            {
             
                _Key = value;
            }
        }

        [System.ComponentModel.Browsable(false)]
        public string Namespace
        {
            get { return _Namespace; }
            set
            {
             
                _Namespace = value;
            }
        }

        [System.ComponentModel.DisplayName("Property type")]
        public TypeCode Code
        {
            get { return type; }
            set
            {
           
                type = value;
            }
        }

        
        
  
    }

    
}
