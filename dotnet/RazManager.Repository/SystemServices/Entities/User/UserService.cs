using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.SystemServices.User;
using System.Linq;
using System.Security.Cryptography;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.User
{
    public class UserService : Razmanager.Protobuf.Internal.Repository.SystemServices.User.UserService.UserServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;


        public UserService(Stores.Context.RepositoryDbContext dbContext)
        {
            _repositoryDbContext = dbContext;
        }



        public override async Task<StringValue> SignIn(SignInRequest request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.Users.SingleOrDefaultAsync(x => x.UserName.ToLower() == request.UserName.ToLower()).ConfigureAwait(false);
            if (entity is null)
            {
                return new StringValue();
            }

            using (var sha512 = SHA512.Create())
            {
                var passwordHash = sha512.ComputeHash(System.Text.Encoding.UTF8.GetBytes(request.Password));
                if (!passwordHash.SequenceEqual(entity.PasswordHash))
                {
                    return new StringValue();
                }
            }

            return new StringValue
            {
                Value = entity.Id.ToString()
            };
        }
    }
}
