using System;

namespace RazManager.Repository.Utilities
{
    public interface IHttpContextOptions
    {
        Guid UserId { get; }
        Guid TenantId { get; }
    }
}
