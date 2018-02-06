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
}
