using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Shared.Components
{
    public class Feed
    {
        private Stack<Entry> entries = null;
        public Stack<Entry> Entries
        {
            get
            {
                if (entries == null)
                    entries = new Stack<Entry>();

                return entries;

            }

            
        }

        public string Uri { get; set; }
        public DateTime Updated { get; set; }
    }
}
