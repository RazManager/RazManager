using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.CrudServices.HeatIndicatorStint;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.HeatIndicatorStint;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.HeatIndicatorStint
{
    public class HeatIndicatorStintStore : EntityCrudStoreBase<HeatIndicatorStintEntity,
                                                               HeatIndicatorStintRead, HeatIndicatorStintCreate, HeatIndicatorStintUpdate>, IHeatIndicatorStintStore
    {
        public HeatIndicatorStintStore(Stores.Context.RepositoryDbContext dbContext,
                                       IHttpContextOptions httpContextOptions,
                                       AutoMapper.IMapper mapper) :
            base(dbContext, httpContextOptions, mapper)
        { }


        protected override IQueryable<HeatIndicatorStintEntity> GetQueryable()
        {
            return RepositoryDbContext.HeatIndicatorStints;
        }


        protected override Task CreateValidateAsync(HeatIndicatorStintEntity entity)
        {
            return CreateUpdateValidateAsync(entity);
        }


        protected override Task UpdateValidateAsync(HeatIndicatorStintEntity entity)
        {
            return CreateUpdateValidateAsync(entity);
        }


        private async Task CreateUpdateValidateAsync(HeatIndicatorStintEntity entity)
        {
            if (await RepositoryDbContext.HeatIndicatorStints.AnyAsync(x => x.HeatIndicatorId == entity.HeatIndicatorId && x.Id != entity.Id && x.Lap == entity.Lap))
            {
                throw new ValidationException(ExceptionMessages.HeatIndicatorStintLapDuplicate);
            }
        }
    }
}
