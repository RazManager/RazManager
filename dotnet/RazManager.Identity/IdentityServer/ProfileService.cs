using Duende.IdentityServer.Models;
using Duende.IdentityServer.Services;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;


namespace RazManager.Identity.IdentityServer
{
    public class ProfileService : IProfileService
    {
        public Task GetProfileDataAsync(ProfileDataRequestContext context)
        {
            if (context.ValidatedRequest is null)
            {
                return Task.CompletedTask;
            }

            var id = context.Subject.Claims.FirstOrDefault(x => x.Type == JwtRegisteredClaimNames.Sub)?.Value;
            var claims = new List<Claim>();

            var tenantId = context.ValidatedRequest.Raw["tenantId"];
            if (tenantId is not null)
            {
                claims.Add(new Claim("tenantId", tenantId));
                claims.Add(new Claim("role", "TenantAdministrator"));
            }
            context.AddRequestedClaims(claims);

            return Task.CompletedTask;
        }


        public Task IsActiveAsync(IsActiveContext context)
        {
            return Task.CompletedTask;
        }
    }
}
