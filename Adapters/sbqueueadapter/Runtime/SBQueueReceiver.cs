
using System;
using Microsoft.Samples.BizTalk.Adapter.Common;
using Microsoft.ServiceBus;
using Microsoft.ServiceBus.Messaging;
using System.Collections.Concurrent;

namespace BizTalk.Adapter.SBQueue
{
    //  The SBQueueReceiver class is a Singleton.
    //
    //  This is the class that is loaded by the BizTalk runtime and so must be public.
    //
    //  The instance of this class used by the BizTalk runtime is created at startup (or enable).
    //
    //  Through the BaseAdapter adapter Receiver class it acts as a Factory for endpoints. In this
    //  case SBQueueReceiverEndpoint instances. There will be an endpoint instance for every
    //  logical receive location configured and enabled. The base class is given the type of endpoint
    //  to create.
    //
    //  The Receiver maintains a hashtable of active receive locations and calls Update and Delete
    //  appropriately.
    //
    //  If you have any state that should be shared amongst all active endpoints of this adapter you can
    //  put it here as an alternative to making it static in the endpoint class.

    public class SBQueueReceiver : Receiver 
	{
        public static ConcurrentDictionary<string, Session> clients = new ConcurrentDictionary<string, Session>();

        

        public SBQueueReceiver()
            : base(
            "SBQueue Adapter",
			"1.0",
			"Retrieve messages from SB queue",
            "SBQueue:",
            new Guid("12F8CA70-4DE4-44e8-8F78-D947523F8AAA"),
            "http://schemas.microsoft.com/BizTalk/2012/Adapter/BrokeredMessage-properties",
			typeof(SBQueueReceiverEndpoint))
		{
            if(clients == null)
                clients = new ConcurrentDictionary<string, Session>();
            //Endpoint=sb://uuc-bizdev007-t.exchange-test.its.uu.se/uu-dev7-test;
            //SharedAccessKeyName =RootManageSharedAccessKey;
            //SharedAccessKey =2UWCQu2lC5OyroycIoJaflX9VtRrGNC5usqnMMfNICU=";
        }
    }
}