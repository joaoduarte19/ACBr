using System;

namespace ACBrLib.Core
{


    public class ACBrLibException : Exception
    {
        public ACBrLibException(string message) : base(message) { }
    }

    public class ACBrLibTimeoutException : ACBrLibException
    {
        public ACBrLibTimeoutException(string message) : base(message) { }
    }
}