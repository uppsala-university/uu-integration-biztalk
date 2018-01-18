using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Shared.Components
{
    public static class AtomReaderExtension
    {
       public static Entry PopOrNUll(this Stack<Entry> stack)
       {
            
            try
            {
                return stack.Pop();
            }
            catch (InvalidOperationException)
            {

                return null;
            }

           
       }
    }
}
