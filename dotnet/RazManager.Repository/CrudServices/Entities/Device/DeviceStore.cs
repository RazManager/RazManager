using Microsoft.AspNetCore.Server.Kestrel.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Device;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Resources;
using RazManager.Repository.Stores.Entities.Device;
using RazManager.Repository.Stores.Entities.DeviceConfiguration;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Resources;
using System.Security.Cryptography.X509Certificates;
using System.Security.Cryptography;
using System.Threading.Tasks;
using Grpc.Core;
using RazManager.Repository.Stores.Entities.Tenant;
using RazManager.Utilities.Host;


namespace RazManager.Repository.CrudServices.Entities.Device
{
    public class DeviceStore : EntityCrudStoreBase<DeviceEntity,
                                                   DeviceRead, DeviceCreateUpdate, DeviceCreateUpdate>, IDeviceStore
    {
        private readonly ICertificateService _certificateService;

        public DeviceStore(Stores.Context.RepositoryDbContext dbContext,
                           IHttpContextOptions httpContextOptions,
                           ICertificateService certificateService,
                           AutoMapper.IMapper mapper) :
            base(dbContext, httpContextOptions, mapper)
        {
            _certificateService = certificateService;
        }


        protected override IQueryable<DeviceEntity> GetQueryable()
        {
            return RepositoryDbContext.Devices
                .Include(x => x.DeviceConfigurations.OrderBy(x => x.Name)).ThenInclude(x => x.DeviceConfigurationInputs)
                .Include(x => x.DeviceConfigurations.OrderBy(x => x.Name)).ThenInclude(x => x.DeviceConfigurationOutputs)
                .Include(x => x.DeviceConfigurations.OrderBy(x => x.Name)).ThenInclude(x => x.DeviceConfigurationFeatures);
        }


        //public override async Task<DeviceRead> InitializeAsync()
        //{
        //    var result = await base.InitializeAsync();

        //    result.DeviceConfigurations.Add(new DeviceConfigurationRead
        //    {
        //        Name = "Simulated"
        //    });

        //    return result;
        //}


        protected override DeviceEntity CreateMap(DeviceCreateUpdate proto)
        {
            var entity = base.CreateMap(proto);
            entity.Simulated = true;
            CreateUpdateMap(proto, entity);
            return entity;
        }


        protected override void UpdateMap(DeviceCreateUpdate proto, DeviceEntity entity)
        {
            base.UpdateMap(proto, entity);
            CreateUpdateMap(proto, entity);
        }


        private void CreateUpdateMap(DeviceCreateUpdate proto, DeviceEntity entity)
        {
            if (entity.Simulated)
            {
                var deviceConfigurationProto = proto.DeviceConfigurations.First();

                var deviceConfigurationEntity = entity.DeviceConfigurations.FirstOrDefault();
                if (deviceConfigurationEntity is null)
                {
                    deviceConfigurationEntity = new DeviceConfigurationEntity
                    {
                        Id = Guid.NewGuid(),
                        Name = "Simulated"
                    };
                    entity.DeviceConfigurations.Add(deviceConfigurationEntity);
                }

                deviceConfigurationEntity.DeviceConfigurationInputs.RemoveAll(x => true);
                foreach (var deviceConfigurationInputProto in deviceConfigurationProto.DeviceConfigurationInputs)
                {
                    deviceConfigurationEntity.DeviceConfigurationInputs.Add(new Stores.Entities.DeviceConfigurationInput.DeviceConfigurationInputEntity
                    {
                        DeviceConfigurationInputTypeId = deviceConfigurationInputProto.DeviceConfigurationInputTypeId,
                        DeviceConfigurationInputId = deviceConfigurationInputProto.DeviceConfigurationInputId.HasValue ? Convert.ToByte(deviceConfigurationInputProto.DeviceConfigurationInputId) : null
                    });
                }

                deviceConfigurationEntity.DeviceConfigurationOutputs.RemoveAll(x => true);
                foreach (var deviceConfigurationOutputProto in deviceConfigurationProto.DeviceConfigurationOutputs)
                {
                    deviceConfigurationEntity.DeviceConfigurationOutputs.Add(new Stores.Entities.DeviceConfigurationOutput.DeviceConfigurationOutputEntity
                    {
                        DeviceConfigurationOutputTypeId = deviceConfigurationOutputProto.DeviceConfigurationOutputTypeId,
                        DeviceConfigurationOutputId = deviceConfigurationOutputProto.DeviceConfigurationOutputId.HasValue ? Convert.ToByte(deviceConfigurationOutputProto.DeviceConfigurationOutputId) : null
                    });
                }

                deviceConfigurationEntity.DeviceConfigurationFeatures.RemoveAll(x => true);
                if (deviceConfigurationProto.DeviceConfigurationInputs.Any(x => x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.Sector1FinishIndicator))
                {
                    deviceConfigurationEntity.DeviceConfigurationFeatures.Add(new() { DeviceConfigurationFeatureTypeId = DeviceConfigurationFeatureTypeId.Sector1 });
                    deviceConfigurationEntity.DeviceConfigurationFeatures.Add(new() { DeviceConfigurationFeatureTypeId = DeviceConfigurationFeatureTypeId.Sector2 });
                }
                if (deviceConfigurationProto.DeviceConfigurationInputs.Any(x => x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.Sector2FinishIndicator))
                {
                    deviceConfigurationEntity.DeviceConfigurationFeatures.Add(new() { DeviceConfigurationFeatureTypeId = DeviceConfigurationFeatureTypeId.Sector3 });
                }
            }
        }


        protected override Task CreateValidateAsync(DeviceEntity entity)
        {
            return CreateUpdateValidateAsync(entity);
        }


        protected override Task UpdateValidateAsync(DeviceEntity entity)
        {
            return CreateUpdateValidateAsync(entity);
        }


        private async Task CreateUpdateValidateAsync(DeviceEntity entity)
        {
            var validationResults = new List<ValidationResult>();

            if (await RepositoryDbContext.Devices.AnyAsync(x => x.TenantId == HttpContextOptions.TenantId && x.Id != entity.Id && x.Name == entity.Name))
            {
                validationResults.Add(new ValidationResult(ExceptionMessages.DeviceNameDuplicate));
            }

            foreach(var deviceConfiguration in entity.DeviceConfigurations)
            {
                if (await RepositoryDbContext.DeviceConfigurations.AnyAsync(x => x.DeviceId == deviceConfiguration.DeviceId && x.Id != entity.Id && x.Name == entity.Name))
                {
                    validationResults.Add(new ValidationResult(ExceptionMessages.DeviceConfigurationNameDuplicate));
                }

                foreach (var item in deviceConfiguration.DeviceConfigurationInputs
                    .Where(x => !x.DeviceConfigurationInputId.HasValue &&
                                  Constants.DeviceConfigurationInputTypes.First(t => t.DeviceConfigurationInputTypeId == x.DeviceConfigurationInputTypeId).DeviceConfigurationInputOutputIdTypeId.Equals(DeviceConfigurationInputOutputIdTypeId.Required)))
                {
                    validationResults.Add(new ValidationResult(
                        string.Format(ExceptionMessages.DeviceDeviceInputDeviceInputIdRequired,
                                      new ResourceManager(typeof(DeviceInputType)).GetString(item.DeviceConfigurationInputTypeId.ToString()))));
                }

                foreach (var item in deviceConfiguration.DeviceConfigurationInputs
                    .Where(x => x.DeviceConfigurationInputId.HasValue &&
                                Constants.DeviceConfigurationInputTypes.First(t => t.DeviceConfigurationInputTypeId == x.DeviceConfigurationInputTypeId).DeviceConfigurationInputOutputIdTypeId.Equals(DeviceConfigurationInputOutputIdTypeId.None)))
                {
                    validationResults.Add(new ValidationResult(
                        string.Format(ExceptionMessages.DeviceDeviceInputDeviceInputIdNone,
                        new ResourceManager(typeof(DeviceInputType)).GetString(item.DeviceConfigurationInputTypeId.ToString()))));
                }

                if (deviceConfiguration.DeviceConfigurationInputs
                    .GroupBy(x => new { x.DeviceConfigurationInputTypeId, x.DeviceConfigurationInputId })
                    .Any(x => x.Count() > 1))
                {
                    validationResults.Add(new ValidationResult(ExceptionMessages.DeviceDeviceInputDuplicate));
                }

                foreach (var item in deviceConfiguration.DeviceConfigurationOutputs
                    .Where(x => !x.DeviceConfigurationOutputId.HasValue &&
                                Constants.DeviceConfigurationOutputTypes.First(t => t.DeviceConfigurationOutputTypeId == x.DeviceConfigurationOutputTypeId).DeviceConfigurationInputOutputIdTypeId.Equals(DeviceConfigurationInputOutputIdTypeId.Required)))
                {
                    validationResults.Add(new ValidationResult(
                        string.Format(ExceptionMessages.DeviceDeviceOutputDeviceOutputIdRequired,
                                      new ResourceManager(typeof(DeviceOutputType)).GetString(item.DeviceConfigurationOutputTypeId.ToString()))));
                }

                foreach (var item in deviceConfiguration.DeviceConfigurationOutputs
                    .Where(x => x.DeviceConfigurationOutputId.HasValue &&
                                Constants.DeviceConfigurationOutputTypes.First(t => t.DeviceConfigurationOutputTypeId == x.DeviceConfigurationOutputTypeId).DeviceConfigurationInputOutputIdTypeId.Equals(DeviceConfigurationInputOutputIdTypeId.None)))
                {
                    validationResults.Add(new ValidationResult(
                        string.Format(ExceptionMessages.DeviceDeviceOutputDeviceOutputIdNone,
                        new ResourceManager(typeof(DeviceOutputType)).GetString(item.DeviceConfigurationOutputTypeId.ToString()))));
                }

                if (deviceConfiguration.DeviceConfigurationOutputs
                    .GroupBy(x => new { x.DeviceConfigurationOutputTypeId, x.DeviceConfigurationOutputId })
                    .Any(x => x.Count() > 1))
                {
                    validationResults.Add(new ValidationResult(ExceptionMessages.DeviceDeviceOutputDuplicate));
                }

                if (validationResults.Any())
                {
                    throw new ValidationException(string.Join(" ", validationResults.Select(x => x.ErrorMessage)));
                }
            }
        }


        public async IAsyncEnumerable<DeviceList> ListAsync(int limit, int offset)
        {
            var query = RepositoryDbContext.Devices
                .Where(x => x.TenantId == HttpContextOptions.TenantId)
                .OrderBy(x => x.Name);

            var response = ListAsync(limit, offset, query);

            await foreach (var entity in response)
            {
                yield return Mapper.Map<DeviceList>(entity);
            }
        }


        public async Task<DeviceCommissioningCertificateResponse> CertificateRequest(DeviceCommissioningCertificateRequest request)
        {
            var signingCertificate = (await _certificateService.GetAllCertificatesAsync
            (
                new[] { "?" }
            )).First();

            using (var rsa = RSA.Create())
            {
                var now = DateTimeOffset.UtcNow;

                var serialNumber = new byte[32];

                var certificateRequest = System.Security.Cryptography.X509Certificates.CertificateRequest.LoadSigningRequestPem(request.CertificateRequestPem, HashAlgorithmName.SHA256, CertificateRequestLoadOptions.Default, RSASignaturePadding.Pkcs1);
                var certificate = certificateRequest.Create(signingCertificate, now, signingCertificate.NotAfter, serialNumber);
                var certificatePem = certificate.ExportCertificatePem();
                var cn = certificate.SubjectName;

                var entity = new DeviceEntity
                {
                    TenantId = HttpContextOptions.TenantId,
                    Id = new Guid(certificate.SubjectName.EnumerateRelativeDistinguishedNames().Single()!.GetSingleElementValue()!),
                    Name  = request.Name
                };
                RepositoryDbContext.Add(entity);
                await RepositoryDbContext.SaveChangesAsync().ConfigureAwait(false);

                return new DeviceCommissioningCertificateResponse
                {
                    CertificatePem = certificatePem
                };
            }
        }
    }
}
