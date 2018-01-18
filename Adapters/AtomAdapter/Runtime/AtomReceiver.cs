
using System;
using Microsoft.BizTalk.Adapter.Common;
using System.Collections.Concurrent;

namespace BizTalk.Adapter.Atom
{
    //  The Atomceiver class is a Singleton.
    //
    //  This is the class that is loaded by the BizTalk runtime and so must be public.
    //
    //  The instance of this class used by the BizTalk runtime is created at startup (or enable).
    //
    //  Through the BaseAdapter adapter Receiver class it acts as a Factory for endpoints. In this
    //  case AtomReceiverEndpoint instances. There will be an endpoint instance for every
    //  logical receive location configured and enabled. The base class is given the type of endpoint
    //  to create.
    //
    //  The Receiver maintains a hashtable of active receive locations and calls Update and Delete
    //  appropriately.
    //
    //  If you have any state that should be shared amongst all active endpoints of this adapter you can
    //  put it here as an alternative to making it static in the endpoint class.

    public class AtomReceiver : Receiver 
	{
        
        public AtomReceiver()
            : base(
            "Atom Adapter",
			"1.0",
			"Retrieve messages entries from Atom feeds",
            "AtomFeed",
        new Guid("1C771212-DB9D-422D-B9F7-EEF935656B6E"),
            "http://schemas/BizTalk/2016/Adapter/atom-properties",
			typeof(AtomReceiverEndpoint))
		{

        }
    }
}