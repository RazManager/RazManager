using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Npgsql.Internal;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using RazManager.Utilities.Exceptions;
using SkiaSharp;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using static Grpc.Core.Metadata;


namespace RazManager.Repository.CrudServices.Utilities
{
    public abstract class EntityCrudStoreBase<TEntity, TReadProto, TCreateProto, TUpdateProto> : IEntityCrudStore<TEntity, TReadProto, TCreateProto, TUpdateProto>
        where TEntity : class, IEntity
        where TReadProto : class, new()
        where TCreateProto : class, new()
        where TUpdateProto : class, new()
    {
        protected readonly Stores.Context.RepositoryDbContext RepositoryDbContext;
        protected readonly IHttpContextOptions HttpContextOptions;
        protected readonly AutoMapper.IMapper Mapper;


        protected EntityCrudStoreBase(Stores.Context.RepositoryDbContext dbContext,
                                      IHttpContextOptions httpContextOptions,
                                      AutoMapper.IMapper mapper)
        {
            RepositoryDbContext = dbContext;
            HttpContextOptions = httpContextOptions;
            Mapper = mapper;
        }


        protected abstract IQueryable<TEntity> GetQueryable();


        public virtual Task<TReadProto> InitializeAsync()
        {
            return Task.Run(() => Mapper.Map<TReadProto>(Activator.CreateInstance<TEntity>()));
        }


        protected virtual TReadProto ReadMap(TEntity entity)
        {
            return Mapper.Map<TReadProto>(entity);
        }

        public virtual async Task<(TReadProto Proto, string ETag)> ReadAsync(Guid id)
        {
            var entity = await GetQueryable()
                .AsSplitQuery()
                .SingleOrDefaultAsync(x => x.Id == id)
                .ConfigureAwait(false);

            if (entity is null)
            {
                throw new NotFoundException();
            }

            if (entity is ITenantEntity tenantModel && !tenantModel.TenantId.Equals(HttpContextOptions.TenantId))
            {
                throw new NotFoundException();
            }

            return (ReadMap(entity), entity.ETag.ToString());
        }



        protected virtual TEntity CreateMap(TCreateProto proto)
        {
            return Mapper.Map<TEntity>(proto);
        }

        protected virtual Task CreateValidateAsync(TEntity entity)
        {
            return Task.CompletedTask;
        }

        protected virtual Task CreateBeforeAsync(TEntity entity)
        {
            return Task.CompletedTask;
        }

        protected virtual Task CreateAfterAsync(TEntity entity, TCreateProto proto)
        {
            return Task.CompletedTask;
        }

        public virtual async Task<CreateResponse> CreateAsync(TCreateProto proto)
        {
            try
            {
                var entity = CreateMap(proto);

                if (entity is ITenantEntity tenantEntity)
                {
                    tenantEntity.TenantId = HttpContextOptions.TenantId;
                }
                RepositoryDbContext.Set<TEntity>().Add(entity);
                await CreateValidateAsync(entity);
                await CreateBeforeAsync(entity);
                await RepositoryDbContext.SaveChangesAsync().ConfigureAwait(false);
                await CreateAfterAsync(entity, proto);
                return new CreateResponse
                {
                    Id = entity.Id.ToString(),
                    Etag = entity.ETag.ToString()
                };
            }
            catch (DbUpdateException exception)
            {
                throw new UpdateConflictException(exception.InnerException!.Message);
            }
        }


        protected virtual void UpdateMap(TUpdateProto proto, TEntity entity)
        {
            Mapper.Map(proto, entity);
        }

        protected virtual Task UpdateValidateAsync(TEntity entity)
        {
            return Task.CompletedTask;
        }

        protected virtual Task UpdateAfterAsync(TEntity entity, TUpdateProto proto)
        {
            return Task.CompletedTask;
        }

        public virtual async Task<UpdateResponse> UpdateAsync(Guid id, TUpdateProto proto, string eTag)
        {
            try
            {
                var entity = await GetQueryable().AsSplitQuery().AsTracking().SingleOrDefaultAsync(x => x.Id == id).ConfigureAwait(false);

                if (entity is null)
                {
                    throw new UpdateConflictException();
                }

                if (eTag is not null && eTag != entity.ETag.ToString())
                {
                    throw new UpdateConflictException();
                }

                if (entity is ITenantEntity tenantEntity && !tenantEntity.TenantId.Equals(HttpContextOptions.TenantId))
                {
                    throw new NotFoundException();
                }

                UpdateMap(proto, entity);
                await UpdateValidateAsync(entity);
                await RepositoryDbContext.SaveChangesAsync().ConfigureAwait(false);
                await UpdateAfterAsync(entity, proto);
                return new UpdateResponse
                {
                    Etag = entity.ETag.ToString()
                };
            }
            catch (DbUpdateException exception)
            {
                throw new UpdateConflictException(exception.InnerException!.Message);
            }
        }



        public async Task<(TEntity Entity, string ETag)> UpdateAsync(Guid id, string? eTag, Action<TEntity> map, Action<TEntity> validate)
        {
            var entity = await GetQueryable().AsSplitQuery().AsTracking().SingleOrDefaultAsync(x => x.Id == id).ConfigureAwait(false);

            if (entity is null)
            {
                throw new UpdateConflictException();
            }

            if (eTag is not null && eTag != entity.ETag.ToString())
            {
                throw new UpdateConflictException();
            }

            if (entity is ITenantEntity tenantEntity && !tenantEntity.TenantId.Equals(HttpContextOptions.TenantId))
            {
                throw new NotFoundException();
            }

            try
            {
                map(entity);
                validate(entity);
                await RepositoryDbContext.SaveChangesAsync().ConfigureAwait(false);
            }
            catch (DbUpdateException e)
            {
                throw new UpdateConflictException(e.InnerException!.Message);
            }

            return (entity, entity.ETag.ToString());
        }


        protected virtual void DeleteValidate(TEntity entity)
        {
        }

        protected virtual Task DeleteBeforeAsync(Guid id)
        {
            return Task.CompletedTask;
        }

        protected virtual Task DeleteAfterAsync(Guid id)
        {
            return Task.CompletedTask;
        }

        public virtual async Task<Empty> DeleteAsync(Guid id, string eTag)
        {
            try
            {
                var entity = await GetQueryable().AsSplitQuery().AsTracking().SingleOrDefaultAsync(x => x.Id == id).ConfigureAwait(false);

                if (entity is null)
                {
                    throw new DeleteConflictException();
                }

                if (eTag != entity.ETag.ToString())
                {
                    throw new DeleteConflictException();
                }

                if (entity is ITenantEntity tenantEntity && !tenantEntity.TenantId.Equals(HttpContextOptions.TenantId))
                {
                    throw new NotFoundException();
                }

                DeleteValidate(entity);
                RepositoryDbContext.Remove(entity);
                await DeleteBeforeAsync(id);
                await RepositoryDbContext.SaveChangesAsync().ConfigureAwait(false);
                await DeleteAfterAsync(id);
                return new Empty();
            }
            catch (DbUpdateException exception)
            {
                throw new DeleteConflictException(exception.InnerException!.Message);
            }
        }


        protected IAsyncEnumerable<TEntity> ListAsync(int limit, int offset, IQueryable<TEntity> query)
        {
            if (limit < 1)
            {
                throw new ValidationException("Invalid value for " + nameof(limit));
            }

            return query
                .Skip(offset)
                .Take(limit)
                .AsAsyncEnumerable();
        }


        protected byte[] Avatar(byte[] image)
        {
            const int Size = 100;
            using (var ms = new MemoryStream(image))
            {
                using (var skImage = SKImage.FromEncodedData(ms))
                {
                    using (var sKBitmap = SKBitmap.FromImage(skImage))
                    {
                        var newImageSizeI = new SKSizeI();
                        if (sKBitmap.Width < sKBitmap.Height)
                        {
                            newImageSizeI.Width = Size;
                            newImageSizeI.Height = Size * sKBitmap.Height / sKBitmap.Width;
                        }
                        else
                        {
                            newImageSizeI.Height = Size;
                            newImageSizeI.Width = Size * sKBitmap.Width / sKBitmap.Height;
                        }
                        using (var resizedSKBitmap = sKBitmap.Resize(newImageSizeI, SKFilterQuality.High))
                        {
                            return resizedSKBitmap.Encode(SKEncodedImageFormat.Png, int.MaxValue).ToArray();
                        }
                    }
                }
            }
        }
    }
}
