using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using Razmanager.Protobuf.Internal.Repository.CrudServices.User;
using System.Threading.Tasks;


namespace RazManager.App.CrudServices.Entities.User
{
    [Authorize]
    public class UserService : Razmanager.Protobuf.Internal.Repository.CrudServices.User.UserService.UserServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.CrudServices.User.UserService.UserServiceClient _serviceClient;


        public UserService(Razmanager.Protobuf.Internal.Repository.CrudServices.User.UserService.UserServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task<UserReadResponse> Read(Empty request, ServerCallContext context)
        {
            return await _serviceClient.ReadAsync(request);
        }


        [AllowAnonymous]
        public override async Task<CreateResponse> Create(UserCreate request, ServerCallContext context)
        {
            return await _serviceClient.CreateAsync(request);
        }


        public override async Task<UpdateResponse> Update(UserUpdateRequest request, ServerCallContext context)
        {
            return await _serviceClient.UpdateAsync(request);
        }


        public override async Task<Empty> Delete(EtagRequest request, ServerCallContext context)
        {
            return await _serviceClient.DeleteAsync(request);
        }
    }
}
