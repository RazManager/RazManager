using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using RazManager.IO.Services.CpuInfo;
using RazManager.IO.Services.OsRelease;
using RazManager.IO.Utilities;
using System;
using System.Threading.Tasks;


namespace RazManager.IO.Services.SystemInformation
{
    public class SystemInformationService : Razmanager.Protobuf.Internal.Io.SystemInformation.SystemInformationService.SystemInformationServiceBase
    {
        private readonly ICpuInfoService _cpuInfoService;
        private readonly IOsReleaseService _osReleaseService;


        public SystemInformationService(ICpuInfoService cpuInfoService,
                                        IOsReleaseService osReleaseService)
        {
            _cpuInfoService = cpuInfoService;
            _osReleaseService = osReleaseService;
        }


        public override Task<Razmanager.Protobuf.Internal.Io.SystemInformation.SystemInformationRead> Read(Empty request, ServerCallContext context)
        {
            Console.WriteLine("++++++++++++++ SystemInformationService Read");
            var result = new Razmanager.Protobuf.Internal.Io.SystemInformation.SystemInformationRead
            {
                HardwareModel = _cpuInfoService.CpuInfo.Model,
                HardwareProcessor = _cpuInfoService.CpuInfo.ModelName,
                SoftwareAssemblyVersion = System.Reflection.Assembly.GetEntryAssembly()?.GetName()?.Version?.ToString(),
                SoftwareSnapVersion = Environment.GetEnvironmentVariable("SNAP_VERSION"),
                SoftwareDotNetVersion = Environment.Version.ToString(),
                SoftwareOsVersion = $"{Environment.OSVersion} ({(Environment.Is64BitOperatingSystem ? "64-bit" : "32-bit")})",
                SoftwareOsReleaseVersion = _osReleaseService.OsRelease.PrettyName,
            };
            result.NetworkIpAddresses.AddRange(NetworkInformation.IPAddresses());
            return Task.FromResult(result);
        }
    }
}
