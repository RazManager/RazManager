using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.CrudServices.CarTag;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.CarTag;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.CarTag
{
    public class CarTagStore : EntityCrudStoreBase<CarTagEntity,
                                                       CarTagRead, CarTagCreateUpdate, CarTagCreateUpdate>, ICarTagStore
    {
        public CarTagStore(Stores.Context.RepositoryDbContext dbContext,
                           IHttpContextOptions httpContextOptions,
                           AutoMapper.IMapper mapper) :
            base(dbContext, httpContextOptions, mapper)
        { }


        protected override IQueryable<CarTagEntity> GetQueryable()
        {
            return RepositoryDbContext.CarTags;
        }


        protected override Task CreateValidateAsync(CarTagEntity entity)
        {
            return CreateUpdateValidateAsync(entity);
        }


        protected override Task UpdateValidateAsync(CarTagEntity entity)
        {
            return CreateUpdateValidateAsync(entity);
        }


        private async Task CreateUpdateValidateAsync(CarTagEntity entity)
        {
            if (await RepositoryDbContext.CarTags.AnyAsync(x => x.TenantId == HttpContextOptions.TenantId && x.Id != entity.Id && x.Name == entity.Name))
            {
                throw new ValidationException(ExceptionMessages.CarTagNameDuplicate);
            }
        }


        public async IAsyncEnumerable<CarTagList> ListAsync(int limit, int offset)
        {
            var query = RepositoryDbContext.CarTags
                .Where(x => x.TenantId == HttpContextOptions.TenantId)
                .OrderBy(x => x.Position)
                .ThenBy(x => x.Name);

            var response = ListAsync(limit, offset, query);

            await foreach (var entity in response)
            {
                yield return Mapper.Map<CarTagList>(entity);
            }
        }


        public async IAsyncEnumerable<CarTagSelect> SelectAsync()
        {
            var response = RepositoryDbContext.CarTags
                .Where(x => x.TenantId == HttpContextOptions.TenantId)
                .OrderBy(x => x.Position)
                .ThenBy(x => x.Name)
                .AsAsyncEnumerable()
                .ConfigureAwait(false);

            await foreach (var entity in response)
            {
                yield return Mapper.Map<CarTagSelect>(entity);
            }
        }
    }
}
