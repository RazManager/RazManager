using Grpc.Core;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Device;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.Device;
using System.Collections.Generic;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.Device
{
    public interface IDeviceStore : IEntityCrudStore<DeviceEntity, DeviceRead, DeviceCreateUpdate, DeviceCreateUpdate>
    {
        IAsyncEnumerable<DeviceList> ListAsync(int limit, int offset);
        Task<DeviceCommissioningCertificateResponse> CertificateRequest(DeviceCommissioningCertificateRequest request);
    }
}