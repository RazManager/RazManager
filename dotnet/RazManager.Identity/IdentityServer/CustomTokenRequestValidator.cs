using Duende.IdentityServer.Validation;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Identity.IdentityServer
{
    public class CustomTokenRequestValidator : ICustomTokenRequestValidator
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Tenant.TenantService.TenantServiceClient _tenantServiceClient;


        public CustomTokenRequestValidator(Razmanager.Protobuf.Internal.Repository.SystemServices.Tenant.TenantService.TenantServiceClient tenantServiceClient)
        {
            _tenantServiceClient = tenantServiceClient;
        }


        public async Task ValidateAsync(CustomTokenRequestValidationContext context)
        {
            if (context.Result?.ValidatedRequest is null)
            {
                return;
            }
            var tenantId = context.Result.ValidatedRequest.Raw["tenantId"];
            if (tenantId is not null)
            {
                var response = await _tenantServiceClient.IsAdministratorAsync(new Razmanager.Protobuf.Internal.Repository.SystemServices.Tenant.TenantIdUserIdRequest
                {
                    TenantId = tenantId,
                    UserId = context.Result.ValidatedRequest.Subject.Claims.FirstOrDefault(x => x.Type == JwtRegisteredClaimNames.Sub)?.Value
                });
                if (!response.Value)
                {
                    context.Result.IsError = true;
                    context.Result.Error = "access_denied";
                }
            }
        }
    }
}
