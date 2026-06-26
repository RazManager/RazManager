using Duende.IdentityServer.Models;
using Duende.IdentityServer.Services;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Threading;
using System.Threading.Tasks;


namespace RazManager.Identity.IdentityServer
{
    public class ProfileService : IProfileService
    {
        public Task GetProfileDataAsync(ProfileDataRequestContext context, CancellationToken ct)
        {
            var validatedTokenRequest = context.ProtocolRequest as Duende.IdentityServer.Validation.ValidatedTokenRequest;

            if (validatedTokenRequest is null)
            {
                return Task.CompletedTask;
            }


            var id = context.Subject.Claims.FirstOrDefault(x => x.Type == JwtRegisteredClaimNames.Sub)?.Value;
            var claims = new List<Claim>();

            var tenantId = validatedTokenRequest.Raw["tenantId"];
            if (tenantId is not null)
            {
                claims.Add(new Claim("tenantId", tenantId));
                claims.Add(new Claim("role", "TenantAdministrator"));
            }
            context.AddRequestedClaims(claims);

            return Task.CompletedTask;
        }


        public Task IsActiveAsync(IsActiveContext context, CancellationToken ct)
        {
            // TODO: check if the user is active
            context.IsActive = true;
            return Task.CompletedTask;
        }
    }
}
