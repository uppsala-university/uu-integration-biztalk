using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BizTalk.Adapter.Atom
{
    public class AtomState
    {
        public DateTime LastUpdated { get; set; } = DateTime.Now;
        public string LastEntryId { get; set; } = String.Empty;

        public string LastFeed { get; set; } = String.Empty;

    }
}
