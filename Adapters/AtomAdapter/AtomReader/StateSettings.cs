using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;


namespace Shared.Components
{
    public class StateSettings
    {
        /// <summary>
        /// Previosly processed entry Id
        /// </summary>
        public string Id { get; set; } = String.Empty;
        
        /// <summary>
        /// Atom Feed to start processing from or latest processed feed
        /// </summary>
        public string WorkingFeed { get; set; } = String.Empty;
       
        /// <summary>
        /// Find first feed either from recent or specified first feed, only used if Id is empty
        /// </summary>
        public bool FindFirst { get; set; }

        /// <summary>
        /// Latest processed "recent" feed updated time
        /// </summary>
        public DateTime LastUpdated { get; set; } = DateTime.Now;
    }
}
