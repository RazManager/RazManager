using System;


namespace RazManager.Repository.Stores.Utilities
{
    public interface IEntity : IEntityId
    {
        Guid ETag { get; set; }
    }
}
