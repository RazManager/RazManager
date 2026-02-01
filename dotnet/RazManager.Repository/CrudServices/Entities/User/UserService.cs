using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using Razmanager.Protobuf.Internal.Repository.CrudServices.User;
using RazManager.Repository.Utilities;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.User
{
    [Authorize]
    public class UserService : Razmanager.Protobuf.Internal.Repository.CrudServices.User.UserService.UserServiceBase
    {
        private readonly IUserStore _entityCrudStore;
        private readonly IHttpContextOptions _httpContextOptions;

        public UserService(IUserStore entityCrudStore,
                          IHttpContextOptions httpContextOptions)
        {
            _entityCrudStore = entityCrudStore;
            _httpContextOptions = httpContextOptions;
        }


        public override async Task<UserReadResponse> Read(Empty request, ServerCallContext context)
        {
            var response = await _entityCrudStore.ReadAsync(_httpContextOptions.UserId);
            return new UserReadResponse
            {
                Entity = response.Proto,
                Etag = response.ETag
            };
        }


        [AllowAnonymous]
        public override Task<CreateResponse> Create(UserCreate request, ServerCallContext context)
        {
            return _entityCrudStore.CreateAsync(request);
        }


        public override Task<UpdateResponse> Update(UserUpdateRequest request, ServerCallContext context)
        {
            return _entityCrudStore.UpdateAsync(_httpContextOptions.UserId, request.Entity, request.Etag);
        }


        public override Task<Empty> Delete(EtagRequest request, ServerCallContext context)
        {
            return _entityCrudStore.DeleteAsync(_httpContextOptions.UserId, request.Etag);
        }
    }
}
