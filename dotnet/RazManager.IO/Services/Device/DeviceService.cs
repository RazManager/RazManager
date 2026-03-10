using Grpc.Net.Client;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;


namespace RazManager.IO.Services.Device
{
    public class DeviceService : BackgroundService
    {
        private readonly Settings.ISettingsService _settingsService;
        private readonly Utilities.ConnectionOptions _connectionOptions;
        private readonly ILogger<DeviceService> _logger;


        public DeviceService(Settings.ISettingsService settingsService,
                             Utilities.ConnectionOptions connectionOptions,
                             ILogger<DeviceService> logger)
        {
            _settingsService = settingsService;
            _connectionOptions = connectionOptions;
            _logger = logger;
        }


        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            if (!_settingsService.IsCommissioned)
            {
                _logger.LogWarning("Not yet commissioned.");
                return;
            }

            var httpClientHandler = new HttpClientHandler
            {
                ServerCertificateCustomValidationCallback = HttpClientHandler.DangerousAcceptAnyServerCertificateValidator,
            };
            httpClientHandler.ClientCertificates.Add(_settingsService.Certificate);

            var grpcChannelOptions = new GrpcChannelOptions
            {
                HttpHandler = httpClientHandler,
            };

            _logger.LogInformation("Channel creating...");
            using (var deviceChannel = GrpcChannel.ForAddress(_connectionOptions.DeviceClientAddress.ToString(), grpcChannelOptions))
            {
                _logger.LogInformation("Channel created.");

                var certificate = _settingsService.Certificate;

                var deviceInformation = new Razmanager.Protobuf.Public.V1.DeviceInformation();

                var deviceServiceClient = new Razmanager.Protobuf.Public.V1.DeviceService.DeviceServiceClient(deviceChannel);
                _logger.LogInformation("DeviceInformationAsync...");
                await deviceServiceClient.DeviceInformationAsync(deviceInformation, null, null, stoppingToken);

                _logger.LogInformation("Task.Delay...");
                await Task.Delay(Timeout.Infinite, stoppingToken);
            }
        }
    }
}