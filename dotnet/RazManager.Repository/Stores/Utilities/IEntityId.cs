using System;

namespace RazManager.Repository.Stores.Utilities
{
    public interface IEntityId
    {
        Guid Id { get; set; }
    }
}
