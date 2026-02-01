using System.Threading.Tasks;
using System;
using RazManager.Repository.Stores.Utilities;


namespace RazManager.Repository.CrudServices.Utilities
{
    public interface IEntityCrudStore<TEntity, TReadProto, TCreateProto, TUpdateProto>
        where TEntity : class, IEntity
        where TReadProto : class, new()
        where TCreateProto : class, new()
        where TUpdateProto : class, new()
    {
        Task<TReadProto> InitializeAsync();
        Task<(TReadProto Proto, string ETag)> ReadAsync(Guid id);
        Task<Razmanager.Protobuf.Internal.Repository.CrudServices.Common.CreateResponse> CreateAsync(TCreateProto proto);
        Task<Razmanager.Protobuf.Internal.Repository.CrudServices.Common.UpdateResponse> UpdateAsync(Guid id, TUpdateProto proto, string eTag);
        Task<Google.Protobuf.WellKnownTypes.Empty> DeleteAsync(Guid id, string eTag);
    }
}
