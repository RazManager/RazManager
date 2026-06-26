using Duende.IdentityServer.Validation;
using Razmanager.Protobuf.Internal.Repository.SystemServices.User;
using System.Threading;
using System.Threading.Tasks;


namespace RazManager.Identity.IdentityServer
{
    public class ResourceOwnerPasswordValidator : IResourceOwnerPasswordValidator
    {

        private readonly UserService.UserServiceClient _serviceClient;


        public ResourceOwnerPasswordValidator(UserService.UserServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public async Task ValidateAsync(ResourceOwnerPasswordValidationContext context, CancellationToken ct)
        {
            var userId = await _serviceClient.SignInAsync(new()
            {
                UserName = context.UserName,
                Password = context.Password
            }, null, null, ct);

            if (!string.IsNullOrEmpty(userId.Value))
            {
                context.Result = new GrantValidationResult(userId.Value, "");
            }
        }
    }
}
