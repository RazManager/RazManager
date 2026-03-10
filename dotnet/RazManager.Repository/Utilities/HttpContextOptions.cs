using Microsoft.AspNetCore.Http;
using System;
using System.Linq;
using System.Security.Claims;


namespace RazManager.Repository.Utilities
{
    public class HttpContextOptions : IHttpContextOptions
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public HttpContextOptions(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }


        public Guid UserId
        {
            get
            {
                var sub = _httpContextAccessor.HttpContext?.User.Claims.FirstOrDefault(x => x.Type == ClaimTypes.NameIdentifier)?.Value;
                if (sub is null)
                {
                    return Guid.Empty;
                }

                return new Guid(sub);
            }
        }


        public Guid TenantId
        {
            get
            {
                var tenantId = _httpContextAccessor.HttpContext?.User.Claims.FirstOrDefault(x => x.Type == "tenantId")?.Value;
                if (tenantId is null)
                {
                    return Guid.Empty;
                }

                return new Guid(tenantId);
            }
        }
    }
}
