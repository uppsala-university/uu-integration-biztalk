using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.ServiceBus;
using Microsoft.ServiceBus.Messaging;

namespace BizTalk.Adapter.SBQueue
{
    public class Session
    {
        public bool Busy { get; set; }

        public QueueClient Client { get; set; }
    }
}
