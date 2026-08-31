using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Grpc.Net.Client;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Razmanager.Protobuf.Public.V1;
using System;
using System.Diagnostics;
using System.Linq;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;


namespace RazManager.IO.Services.PerformanceTest
{
    public class PerformanceTestService : BackgroundService
    {
        private readonly Settings.ISettingsService _settingsService;
        private readonly Utilities.ConnectionOptions _connectionOptions;
        private readonly ILogger<PerformanceTestService> _logger;
        private string _deviceConfigurationId;
        private GrpcChannel? _grpcChannel;
        private string _correlationId;
        private Stopwatch _correlationIdStopwatch = new();


        public PerformanceTestService(Settings.ISettingsService settingsService,
                                      Utilities.ConnectionOptions connectionOptions,
                                      ILogger<PerformanceTestService> logger)
        {
            _settingsService = settingsService;
            _connectionOptions = connectionOptions;
            _logger = logger;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            try
            {
                var deviceSettings = _settingsService.DeviceSettings;

                var deviceConfigurationSettings = deviceSettings.DeviceConfigurationSettings.Where(x => x.DeviceIntegrations.Any(x => x.ValueCase == DeviceIntegration.ValueOneofCase.DeviceIntegrationPerformanceTest)).SingleOrDefault(x => x.Id == _settingsService.Settings.DeviceConfigurationId.ToString());
                var deviceIntegrationPerformanceTest = deviceConfigurationSettings?.DeviceIntegrations?.SingleOrDefault(x => x.ValueCase == DeviceIntegration.ValueOneofCase.DeviceIntegrationPerformanceTest)?.DeviceIntegrationPerformanceTest;
                if (deviceIntegrationPerformanceTest is null)
                {
                    return;
                }
                _deviceConfigurationId = deviceConfigurationSettings!.Id;

                var httpClientHandler = new HttpClientHandler
                {
                    ServerCertificateCustomValidationCallback = HttpClientHandler.DangerousAcceptAnyServerCertificateValidator,
                };
                httpClientHandler.ClientCertificates.Add(_settingsService.Certificate);

                var grpcChannelOptions = new GrpcChannelOptions
                {
                    HttpHandler = httpClientHandler,
                };

                var appTask = Task.Run(async () =>  
                {
                    using (var channel = GrpcChannel.ForAddress(_connectionOptions.AppClientAddress.ToString(), grpcChannelOptions))
                    {
                        var heatWithoutStintsServiceClient = new Razmanager.Protobuf.Public.V1.HeatWithoutStintsService.HeatWithoutStintsServiceClient(channel);
                            
                        using (var call = heatWithoutStintsServiceClient.LeaderboardSubscribe(new StringValue{ Value = "019d2979-dcbf-7460-bb0e-9eae1e1d5b6e" }, null, null, stoppingToken))
                        {
                            await foreach (var heatLeaderboard in call.ResponseStream.ReadAllAsync(stoppingToken))
                            {
                                if (_correlationId == heatLeaderboard.CorrelationId)
                                {
                                    _logger.LogInformation($"{_correlationIdStopwatch.Elapsed.TotalSeconds}");
                                }
                                else
                                {
                                    _logger.LogInformation("CorrelationIds don't match.");
                                }
                            }
                        }
                    }

                }, stoppingToken);

                _logger.LogInformation("Channel creating...");
                _grpcChannel = GrpcChannel.ForAddress(_connectionOptions.DeviceClientAddress.ToString(), grpcChannelOptions);
                _logger.LogInformation("Channel created.");

                var deviceConfigurationServiceClient = new Razmanager.Protobuf.Public.V1.DeviceConfigurationService.DeviceConfigurationServiceClient(_grpcChannel);

                do
                {
                    _correlationIdStopwatch.Restart();
                    _correlationId = Guid.NewGuid().ToString();
                    var deviceConfigurationInputs = new DeviceConfigurationInputs();
                    deviceConfigurationInputs.Items.Add(new DeviceConfigurationInput
                    {
                        DeviceConfigurationId = _deviceConfigurationId,
                        CorrelationId = _correlationId,
                        Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(DateTime.UtcNow),
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.StartFinishIndicator,
                        DeviceConfigurationInputId = 1
                    });
                    deviceConfigurationServiceClient.DeviceConfigurationInputsPublish(deviceConfigurationInputs);

                    await Task.Delay(TimeSpan.FromSeconds(10), stoppingToken);

                } while (!stoppingToken.IsCancellationRequested);

            }
            catch (Exception exception)
            {
                _logger.LogError(exception, exception.Message);
            }
            finally
            {
                _grpcChannel?.Dispose();
            }
        }
    }
}
