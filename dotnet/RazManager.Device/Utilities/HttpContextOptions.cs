using Microsoft.AspNetCore.Http;
using System;
using System.Linq;


namespace RazManager.Device.Utilities
{
    public class HttpContextOptions : IHttpContextOptions
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public HttpContextOptions(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }


        public Guid DeviceId
        {
            get
            {
                var id = _httpContextAccessor.HttpContext?.User.Claims.FirstOrDefault(x => x.Type == "deviceId")?.Value;
                if (id is null)
                {
                    return Guid.Empty;
                }

                return new Guid(id);
            }
        }
    }
}
