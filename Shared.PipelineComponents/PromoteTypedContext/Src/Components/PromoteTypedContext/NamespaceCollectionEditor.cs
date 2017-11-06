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
   
    public class NamespaceCollectionEditor : System.Drawing.Design.UITypeEditor
    {
        public NamespaceCollectionEditor()
        {
            _editor = new CollectionEditor(typeof(NamespaceCollection));

        }
        CollectionEditor _editor;
        public override System.Drawing.Design.UITypeEditorEditStyle GetEditStyle(System.ComponentModel.ITypeDescriptorContext context)
        {
            return _editor.GetEditStyle(context);
        }

        public override object EditValue(System.ComponentModel.ITypeDescriptorContext context, IServiceProvider provider, object value)
        {
            //If unchanged return original collection or else create a new one.
            string state = ((NamespaceCollection)value).ToString();

            NamespaceCollection coll = (NamespaceCollection)_editor.EditValue(context, provider, value);

            string new_state = coll.ToString();

            if (state != new_state)
            {

                coll = new NamespaceCollection();
                coll.SetCollection(new_state);

            }

            return coll;
        }

    }

    
    public class NamespaceCollection : System.Collections.CollectionBase
    {

       
       

        public enum KeyType
        {
            Namespace,
            Name
        }

        public NamespaceCollection()
        {
           

           this.AddDefaultNamespaces();
            
        }

        protected override void OnInsert(int index, Object value)
        {


            base.OnInsert(index, value);


        }


        public void Add(NamespaceValue context)
        {
            this.InnerList.Add(context);
        }

        private void AddDefaultNamespaces()
        {
            foreach (KeyValuePair<string,string> item in Utils.DefaultNamespaces)
            {
                base.InnerList.Add(new NamespaceValue { Name = item.Key, Namespace = item.Value});
            }
           
        }

        public bool TryGetValue(string key,KeyType type,out string value)
        {
            int cnt = this.InnerList.Count;
            value = String.Empty;
            
            for (int i = 0; i < cnt; i++)
            {
                NamespaceValue ns = this[i];

                switch(type)
                {
                    case KeyType.Name:
                        if (ns.Name == key)
                        { 
                            value = ns.Namespace; 
                            return true; 
                        }
                        break;
                    default:
                        if (ns.Namespace == key)
                        {
                            value = ns.Name;
                            return true;
                        }
                        break;
                }
                

                
            }

          


            return false;
        }


        public bool ContainsNamespace(string ns)
        {
            int cnt = this.InnerList.Count;


            for (int i = 0; i < cnt; i++)
            {
                NamespaceValue ns_value = this[i];

                if (ns_value.Namespace == ns)

                    return true;
            }

            return false;
        }

        public bool ContainsName(string Name)
        {
            int cnt = this.InnerList.Count;
            

            for (int i = 0; i < cnt; i++)
            {
                NamespaceValue ns_value = this[i];

                if (ns_value.Name == Name)

                return true;
            }

            return false;
        }

        public string GetNamespace(string Name)
        {


            string value = String.Empty;

            int cnt = this.InnerList.Count;


            for (int i = 0; i < cnt; i++)
            {
                NamespaceValue ns_value = this[i];

                if (ns_value.Name == Name)
                    return ns_value.Namespace;

            }

            return value;


        }

        public string GetName(string Namespace)
        {
           

                string value = String.Empty;

                int cnt = this.InnerList.Count;


                for (int i = 0; i < cnt; i++)
                {
                    NamespaceValue ns_value = this[i];

                    if (ns_value.Namespace == Namespace)
                        return ns_value.Name;
                        
                }
            
              return value;
            
            
        }
        
        public NamespaceValue this[int index]
        {
            get { return (NamespaceValue)this.InnerList[index]; }
            set { this.InnerList[index] = value; }
        }

        
        
        public void SetCollection(string Namespaces)
        {
            string[] arrCollection = Namespaces.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);

            this.InnerList.Clear();

            this.AddDefaultNamespaces();

            string ns = String.Empty;
            string value = String.Empty;

            foreach (string coll in arrCollection)
            {
                string[] namespaceValue = coll.Split(new char[] { '#'}, StringSplitOptions.RemoveEmptyEntries);


                this.InnerList.Add(new NamespaceValue { Name = namespaceValue[1], Namespace = namespaceValue[0] });
            }

           
        }
        
        public override string ToString()
        {
            StringBuilder builder = new StringBuilder();
            string ns = String.Empty;

            foreach (NamespaceValue namespaceValue in this)
            {
                if(Utils.DefaultNamespaces.ContainsKey(namespaceValue.Name) == false)
                    builder.AppendFormat("{0}#{1};", namespaceValue.Namespace,namespaceValue.Name);
            }

            return builder.ToString();

        }

        
    }

    public class NamespaceValue
    {
        string _Namespace = String.Empty;
        string _Name = String.Empty;

        public string Namespace
        {
            get { return _Namespace; }
            set
            {
               
                _Namespace = value;
            }
        }

        public string Name
        {
            get { return _Name; }
            set
            {

                _Name = value;
            }
        }

    }
}
