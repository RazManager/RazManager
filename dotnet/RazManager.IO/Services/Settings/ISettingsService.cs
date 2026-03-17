using Razmanager.Protobuf.Public.V1;
using System;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;


namespace RazManager.IO.Services.Settings
{
    public interface ISettingsService
    {
        bool IsCommissioned { get; }
        X509Certificate2 Certificate { get; }
        SettingsDto Settings { get; }
        Task SaveAsync();
        DeviceSettings DeviceSettings { get; set; }
    }
}
