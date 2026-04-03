using Grpc.Core;
using Grpc.Net.Client;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Razmanager.Protobuf.Public.V1;
using RazManager.IO.Services.CpuInfo;
using RazManager.IO.Services.OsRelease;
using System;
using System.IO.Ports;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.ConstrainedExecution;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Threading;
using System.Threading.Tasks;


namespace RazManager.IO.Services.Device
{
    public class DeviceService : BackgroundService
    {
        private readonly Settings.ISettingsService _settingsService;
        private readonly Utilities.ConnectionOptions _connectionOptions;
        private readonly ICpuInfoService _cpuInfoService;
        private readonly IOsReleaseService _osReleaseService;
        private readonly ILogger<DeviceService> _logger;


        public DeviceService(Settings.ISettingsService settingsService,
                             ICpuInfoService cpuInfoService,
                             IOsReleaseService osReleaseService,
                             Utilities.ConnectionOptions connectionOptions,
                             ILogger<DeviceService> logger)
        {
            _settingsService = settingsService;
            _connectionOptions = connectionOptions;
            _cpuInfoService = cpuInfoService;
            _osReleaseService = osReleaseService;
            _logger = logger;
        }


        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            var httpClientHandler = new HttpClientHandler
            {
                ServerCertificateCustomValidationCallback = HttpClientHandler.DangerousAcceptAnyServerCertificateValidator,
            };
            httpClientHandler.ClientCertificates.Add(_settingsService.Certificate);

            var grpcChannelOptions = new GrpcChannelOptions
            {
                HttpHandler = httpClientHandler,
            };

            var metadata = new Metadata
            {
                { "X-Client-Cert", WebUtility.UrlEncode(_settingsService.Settings.CertificatePem) },
            };

            _logger.LogInformation("Channel creating...");
            using (var deviceChannel = GrpcChannel.ForAddress(_connectionOptions.DeviceClientAddress.ToString(), grpcChannelOptions))
            {
                _logger.LogInformation("Channel created.");

                // Polly...


                var certificate = _settingsService.Certificate;
                var deviceSettings = _settingsService.DeviceSettings;

                var deviceInformation = new Razmanager.Protobuf.Public.V1.DeviceInformation();

                foreach (var deviceConfigurationSettings in deviceSettings.DeviceConfigurationSettings)
                {
                    var deviceConfiguration = new Razmanager.Protobuf.Public.V1.DeviceConfiguration
                    {
                        Id = deviceConfigurationSettings.Id,
                        Name = deviceConfigurationSettings.Name
                    };

                    foreach (var deviceIntegration in deviceConfigurationSettings.DeviceIntegrations)
                    {
                        switch (deviceIntegration.ValueCase)
                        {
                            case DeviceIntegration.ValueOneofCase.DeviceIntegrationGpio:
                                break;

                            case DeviceIntegration.ValueOneofCase.DeviceIntegrationOxigen:
                                for (uint i = 1; i <= deviceIntegration.DeviceIntegrationOxigen.MaxControllerId; i++)
                                {
                                    deviceConfiguration.DeviceConfigurationInputs.Add(new DeviceDeviceConfigurationInput { DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.StartFinishIndicator, DeviceConfigurationInputId = i });
                                }
                                break;

                            case DeviceIntegration.ValueOneofCase.DeviceIntegrationScalextricArc:
                                break;

                            case DeviceIntegration.ValueOneofCase.DeviceIntegrationScalextricApb:
                                break;

                            case DeviceIntegration.ValueOneofCase.DeviceIntegrationScalextricPitPro:
                                break;

                            case DeviceIntegration.ValueOneofCase.DeviceIntegrationPhilipsHue:
                                break;

                            case DeviceIntegration.ValueOneofCase.DeviceIntegrationRgb:
                                break;

                            case DeviceIntegration.ValueOneofCase.DeviceIntegrationLapMaster:
                                for (uint i = 1; i <= deviceIntegration.DeviceIntegrationLapMaster.Lanes; i++)
                                {
                                    deviceConfiguration.DeviceConfigurationInputs.Add(new DeviceDeviceConfigurationInput { DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.StartFinishIndicator, DeviceConfigurationInputId = i });
                                }
                                deviceConfiguration.DeviceConfigurationFeatures.AddRange([
                                    Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.LaneBasedId,
                                ]);
                                break;

                            case DeviceIntegration.ValueOneofCase.DeviceIntegrationChronoLog:
                                for (uint i = 1; i <= 20; i++)
                                {
                                    deviceConfiguration.DeviceConfigurationInputs.Add(new DeviceDeviceConfigurationInput { DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.StartFinishIndicator, DeviceConfigurationInputId = i });
                                }
                                deviceConfiguration.DeviceConfigurationFeatures.AddRange([
                                    Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.Pitstop,
                                    Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.CarOnTrack,
                                    Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.ControllerBasedId,
                                ]);

                                break;

                            case DeviceIntegration.ValueOneofCase.DeviceIntegrationPerformanceTest:
                                deviceConfiguration.DeviceConfigurationInputs.Add(new DeviceDeviceConfigurationInput { DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.StartFinishIndicator, DeviceConfigurationInputId = 1 });
                                deviceConfiguration.DeviceConfigurationFeatures.AddRange([
                                    Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.ControllerBasedId,
                                ]);

                                break;

                            default:
                                break;
                        }
                    }

                    deviceInformation.DeviceConfigurations.Add(deviceConfiguration);
                }

                var deviceServiceClient = new Razmanager.Protobuf.Public.V1.DeviceService.DeviceServiceClient(deviceChannel);
                _logger.LogInformation("DeviceInformationAsync...");
                await deviceServiceClient.DeviceInformationAsync(deviceInformation, metadata, null, stoppingToken);

                // Polly...

                using (var call = deviceServiceClient.DeviceResponseRequest(metadata, null, stoppingToken))
                {
                    await foreach (var deviceRequest in call.ResponseStream.ReadAllAsync(stoppingToken))
                    {
                        switch (deviceRequest.ValueCase)
                        {
                            case Razmanager.Protobuf.Public.V1.DeviceRequest.ValueOneofCase.DeviceSystemInformationRequest:
                                var result = new Razmanager.Protobuf.Public.V1.DeviceSystemInformationResponse
                                {
                                    HardwareModel = _cpuInfoService.CpuInfo.Model,
                                    HardwareProcessor = _cpuInfoService.CpuInfo.ModelName,
                                    SoftwareAssemblyVersion = System.Reflection.Assembly.GetEntryAssembly()?.GetName()?.Version?.ToString(),
                                    SoftwareSnapVersion = Environment.GetEnvironmentVariable("SNAP_VERSION"),
                                    SoftwareDotNetVersion = Environment.Version.ToString(),
                                    SoftwareOsVersion = $"{Environment.OSVersion} ({(Environment.Is64BitOperatingSystem ? "64-bit" : "32-bit")})",
                                    SoftwareOsReleaseVersion = _osReleaseService.OsRelease.PrettyName,
                                };
                                result.SerialPortNames.AddRange(SerialPort.GetPortNames().OrderBy(x => x));

                                await call.RequestStream.WriteAsync(new Razmanager.Protobuf.Public.V1.DeviceResponse
                                {
                                    CorrelationId = deviceRequest.CorrelationId,
                                    DeviceSystemInformationResponse = result
                                });

                                break;

                            case Razmanager.Protobuf.Public.V1.DeviceRequest.ValueOneofCase.DeviceSettingsReadRequest:
                                await call.RequestStream.WriteAsync(new Razmanager.Protobuf.Public.V1.DeviceResponse
                                {
                                    CorrelationId = deviceRequest.CorrelationId,
                                    DeviceSettingsResponse = new DeviceSettingsResponse
                                    {
                                        DeviceSettings = _settingsService.DeviceSettings
                                    }
                                });
                                break;

                            case Razmanager.Protobuf.Public.V1.DeviceRequest.ValueOneofCase.DeviceSettingsUpsertRequest:
                                _settingsService.DeviceSettings = deviceRequest.DeviceSettingsUpsertRequest.DeviceSettings;
                                await call.RequestStream.WriteAsync(new Razmanager.Protobuf.Public.V1.DeviceResponse
                                {
                                    CorrelationId = deviceRequest.CorrelationId,
                                    DeviceSettingsResponse = new DeviceSettingsResponse
                                    {
                                        DeviceSettings = _settingsService.DeviceSettings
                                    }
                                });

                                await _settingsService.SaveAsync();
                                break;

                            default:
                                break;
                        }
                    }

                    await call.RequestStream.CompleteAsync();
                }

                await Task.Delay(Timeout.Infinite, stoppingToken);
            }
        }
    }
}