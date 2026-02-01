using System;


namespace RazManager.Utilities.Store
{
    public interface ITimeToLiveAtRequired
    {
        DateTime TimeToLiveAt { get; set; }
    }
}
