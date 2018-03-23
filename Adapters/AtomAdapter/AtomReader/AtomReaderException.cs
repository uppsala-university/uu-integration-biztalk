using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Shared.Components
{
    [Serializable()]
    public class AtomReaderException : Exception
    {
        
        public AtomReaderException()
        {
        }

        public AtomReaderException(string message) : base(message)
        {
        }

        public AtomReaderException(string message, Exception innerException) : base(message, innerException)
        {
        }

        protected AtomReaderException(SerializationInfo info, StreamingContext context) : base(info, context)
        {

        }
    }
    [Serializable()]
    public class InvalidConfiguration:AtomReaderException
    {
        public InvalidConfiguration(string message) : base(message) { }

        protected InvalidConfiguration(SerializationInfo info, StreamingContext context) : base(info, context) { }
    }

    [Serializable()]
    public class MaxDeepthException : AtomReaderException
    {
        public MaxDeepthException(string message) : base(message) { }

        public MaxDeepthException(int max) : base(String.Format("Maximum feeds to search has been reached, {0} feeds have been searched!", max)) { }
    }

}
