using Grpc.Net.Client;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Razmanager.Protobuf.Public.V1;
using RazManager.IO.Services.Settings;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;


namespace RazManager.IO.Services.ChronoLog
{
    public class ChronoLogService : BackgroundService
    {
        private readonly ISettingsService _settingsService;
        private readonly ChronoLogOptions _chronoLogOptions;
        private readonly IHostApplicationLifetime _hostApplicationLifetime;
        private readonly ILogger<ChronoLogService> _logger;


        public ChronoLogService(Services.Settings.ISettingsService settingsService,
                                ChronoLogOptions chronoLogOptions,
                                IHostApplicationLifetime hostApplicationLifetime,
                                ILogger<ChronoLogService> logger)
        {
            _settingsService = settingsService;
            _chronoLogOptions = chronoLogOptions;
            _hostApplicationLifetime = hostApplicationLifetime;
            _logger = logger;
        }


        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            var deviceSettings = _settingsService.DeviceSettings;

            var deviceConfigurationSettings = deviceSettings.DeviceConfigurationSettings.Where(x => x.DeviceIntegrations.Any(x => x.ValueCase == DeviceIntegration.ValueOneofCase.DeviceIntegrationChronoLog)).SingleOrDefault(x => x.Id == _settingsService.Settings.DeviceConfigurationId.ToString());
            var deviceIntegrationChronoLog = deviceConfigurationSettings?.DeviceIntegrations?.SingleOrDefault(x => x.ValueCase == DeviceIntegration.ValueOneofCase.DeviceIntegrationChronoLog)?.DeviceIntegrationChronoLog;
            if (deviceIntegrationChronoLog is null)
            {
                return;
            }
            var deviceConfigurationId = deviceConfigurationSettings!.Id;

            var heatStateTypeId = HeatStateTypeId.Closed;

            var httpClientHandler = new HttpClientHandler
            {
                ServerCertificateCustomValidationCallback = HttpClientHandler.DangerousAcceptAnyServerCertificateValidator,
            };
            httpClientHandler.ClientCertificates.Add(_settingsService.Certificate);

            var grpcChannelOptions = new GrpcChannelOptions
            {
                HttpHandler = httpClientHandler,
            };

            using (var appChannel = GrpcChannel.ForAddress(_chronoLogOptions.AppClientAddress.ToString(), grpcChannelOptions))
            {
                var raceServiceClient = new Razmanager.Protobuf.Public.V1.RaceService.RaceServiceClient(appChannel);

                _logger.LogInformation($"Resetting race {_chronoLogOptions.RaceId}");
                await raceServiceClient.CommandAsync(new Razmanager.Protobuf.Public.V1.RaceCommandRequest
                {
                    Id = _chronoLogOptions.RaceId,
                    RaceCommandTypeId = Razmanager.Protobuf.Public.V1.RaceCommandTypeId.Reset
                });

                _logger.LogInformation($"Starting race {_chronoLogOptions.RaceId}");
                await raceServiceClient.CommandAsync(new Razmanager.Protobuf.Public.V1.RaceCommandRequest
                {
                    Id = _chronoLogOptions.RaceId,
                    RaceCommandTypeId = Razmanager.Protobuf.Public.V1.RaceCommandTypeId.Start
                });

                var heatServiceClient = new Razmanager.Protobuf.Public.V1.HeatService.HeatServiceClient(appChannel);

                _logger.LogInformation($"Starting heat {_chronoLogOptions.HeatId}");
                await heatServiceClient.CommandAsync(new Razmanager.Protobuf.Public.V1.HeatCommandRequest
                {
                    Id = _chronoLogOptions.HeatId,
                    HeatCommandTypeId = Razmanager.Protobuf.Public.V1.HeatCommandTypeId.Start
                });
                heatStateTypeId = HeatStateTypeId.Running;

                _logger.LogInformation($"Waiting...");
                await Task.Delay(TimeSpan.FromSeconds(10));

                _logger.LogInformation($"Starting simulation...");
            }

            var carControllerFirmwareVersions = new Dictionary<byte, List<double>>();
            var carCarFirmwareVersions = new Dictionary<byte, List<double>>();

            _logger.LogInformation("Channel creating...");
            using (var deviceChannel = GrpcChannel.ForAddress(_chronoLogOptions.DeviceClientAddress.ToString(), grpcChannelOptions))
            {
                _logger.LogInformation("Channel created.");

                _logger.LogInformation("File opening...");
                _logger.LogInformation("_chronoLogOptions.CronoLogFilename");
                var lines = await System.IO.File.ReadAllLinesAsync(_chronoLogOptions.CronoLogFilename, stoppingToken);
                _logger.LogInformation("File opened.");
                _logger.LogInformation($"Lines={lines.Length}");

                var latestCarLaps = new Dictionary<byte, (short Laps, short? LapsDifference)>();

                var deviceServiceClient = new Razmanager.Protobuf.Public.V1.DeviceService.DeviceServiceClient(deviceChannel);
                var deviceConfigurationServiceClient = new Razmanager.Protobuf.Public.V1.DeviceConfigurationService.DeviceConfigurationServiceClient(deviceChannel);

                var timerStart = DateTime.UtcNow;
                TimeSpan lastRunningEvent = TimeSpan.Zero;

                foreach (var line in lines)
                {
                    if (stoppingToken.IsCancellationRequested)
                    {
                        break;
                    }

                    string carColumn = "";
                    string lapsColumn = "";
                    string gapsColumn = "";
                    string lastLapColumn = "";
                    string bestLapColumn = "";
                    string lastEventColumn = "";
                    string teamColumn = "";
                    string dongleDataColumn = "";

                    var columns = line.Split("\t");
                    foreach (var columnKv in columns.Select((column, index) => new { column, index }))
                    {
                        switch (columnKv.index)
                        {
                            case 0:
                                carColumn = columnKv.column.Trim();
                                break;

                            case 1:
                                lapsColumn = columnKv.column.Trim();
                                break;

                            case 2:
                                gapsColumn = columnKv.column.Trim();
                                break;

                            case 3:
                                lastLapColumn = columnKv.column.Trim().Replace(",", ".");
                                break;

                            case 4:
                                bestLapColumn = columnKv.column.Trim();
                                break;

                            case 5:
                                lastEventColumn = columnKv.column.Trim().Replace(",", ".");
                                break;

                            case 6:
                                teamColumn = columnKv.column.Trim();
                                break;

                            case 7:
                                if (_chronoLogOptions.UseDongleData)
                                {
                                    dongleDataColumn = columnKv.column.Trim();
                                }
                                break;

                            default:
                                break;
                        }
                    }

                    switch (carColumn)
                    {
                        case "START":
                        case "RESTART":
                            if (heatStateTypeId != HeatStateTypeId.Running)
                            {
                                heatStateTypeId = HeatStateTypeId.Running;

                                using (var appChannel = GrpcChannel.ForAddress(_chronoLogOptions.AppClientAddress.ToString(), grpcChannelOptions))
                                {
                                    _logger.LogInformation($"Starting heat {_chronoLogOptions.HeatId}");
                                    var heatServiceClient = new Razmanager.Protobuf.Public.V1.HeatService.HeatServiceClient(appChannel);
                                    await heatServiceClient.CommandAsync(new Razmanager.Protobuf.Public.V1.HeatCommandRequest
                                    {
                                        Id = _chronoLogOptions.HeatId,
                                        HeatCommandTypeId = Razmanager.Protobuf.Public.V1.HeatCommandTypeId.Start
                                    });
                                }
                            }

                            break;

                        case "PACE":
                            heatStateTypeId = HeatStateTypeId.Yellow;

                            using (var appChannel = GrpcChannel.ForAddress(_chronoLogOptions.AppClientAddress.ToString(), grpcChannelOptions))
                            {
                                _logger.LogInformation($"Yellow flag heat {_chronoLogOptions.HeatId}");
                                var heatServiceClient = new Razmanager.Protobuf.Public.V1.HeatService.HeatServiceClient(appChannel);
                                await heatServiceClient.CommandAsync(new Razmanager.Protobuf.Public.V1.HeatCommandRequest
                                {
                                    Id = _chronoLogOptions.HeatId,
                                    HeatCommandTypeId = Razmanager.Protobuf.Public.V1.HeatCommandTypeId.Yellow
                                });
                            }

                            break;

                        case "PAUSE":
                            heatStateTypeId = HeatStateTypeId.Red;

                            using (var appChannel = GrpcChannel.ForAddress(_chronoLogOptions.AppClientAddress.ToString(), grpcChannelOptions))
                            {
                                _logger.LogInformation($"Red flag heat {_chronoLogOptions.HeatId}");
                                var heatServiceClient = new Razmanager.Protobuf.Public.V1.HeatService.HeatServiceClient(appChannel);
                                await heatServiceClient.CommandAsync(new Razmanager.Protobuf.Public.V1.HeatCommandRequest
                                {
                                    Id = _chronoLogOptions.HeatId,
                                    HeatCommandTypeId = Razmanager.Protobuf.Public.V1.HeatCommandTypeId.Red
                                });
                            }

                            break;

                        default:
                            break;
                    }

                    if (byte.TryParse(carColumn, out byte car) && short.TryParse(lapsColumn, out short laps) && TimeSpan.TryParse(lastLapColumn, CultureInfo.InvariantCulture, out var lapTime) && TimeSpan.TryParse(lastEventColumn, CultureInfo.InvariantCulture, out var lastEvent))
                    {
                        if (laps > 0)
                        {
                            //Console.WriteLine($"{car} {laps} {lastEvent}");

                            DateTime timeStamp;
                            if (heatStateTypeId == HeatStateTypeId.Red)
                            {
                                timeStamp = timerStart.Add(lastRunningEvent);
                            }
                            else
                            {
                                timeStamp = timerStart.Add(lastEvent);
                                lastRunningEvent = lastEvent;
                            }

                            await Task.Delay(Convert.ToInt32(Math.Max(0, (timeStamp - DateTime.UtcNow).TotalMilliseconds)));

                            if (_chronoLogOptions.UseDongleData)
                            {
                                var dongleData = Convert.FromHexString(dongleDataColumn);

                                OxigenRxDeviceSoftwareReleaseOwner deviceSoftwareReleaseOwner;
                                if ((dongleData[8] & (int)Math.Pow(2, 7)) == 0)
                                {
                                    deviceSoftwareReleaseOwner = OxigenRxDeviceSoftwareReleaseOwner.controllerSoftwareRelease;
                                }
                                else
                                {
                                    deviceSoftwareReleaseOwner = OxigenRxDeviceSoftwareReleaseOwner.carSoftwareRelease;
                                }

                                if (dongleData[8] != 0)
                                {
                                    var softwareRelease = 4 + (dongleData[8] & 96) / 32.0 + (dongleData[8] & 31) / 100.0;

                                    switch (deviceSoftwareReleaseOwner)
                                    {
                                        case OxigenRxDeviceSoftwareReleaseOwner.controllerSoftwareRelease:
                                            if (!carControllerFirmwareVersions.ContainsKey(car))
                                            {
                                                carControllerFirmwareVersions.Add(car, [softwareRelease]);
                                            }
                                            else
                                            {
                                                if (!carControllerFirmwareVersions[car].Contains(softwareRelease))
                                                {
                                                    carControllerFirmwareVersions[car].Add(softwareRelease);
                                                }
                                            }
                                            break;
                                        case OxigenRxDeviceSoftwareReleaseOwner.carSoftwareRelease:
                                            if (!carCarFirmwareVersions.ContainsKey(car))
                                            {
                                                carCarFirmwareVersions.Add(car, [softwareRelease]);
                                            }
                                            else
                                            {
                                                if (!carCarFirmwareVersions[car].Contains(softwareRelease))
                                                {
                                                    carCarFirmwareVersions[car].Add(softwareRelease);
                                                }
                                            }
                                            break;
                                    }
                                }
                            }

                            var deviceConfigurationInputs = new Razmanager.Protobuf.Public.V1.DeviceConfigurationInputs();

                            var ignoreLapTime = false;
                            var ignoreLap = false;

                            short? lapDifference = null;
                            if (latestCarLaps.TryGetValue(car, out var previousLap))
                            {
                                lapDifference = Convert.ToInt16(laps - previousLap.Laps);

                                if (laps > 1 && lapDifference != 1)
                                {
                                    Console.WriteLine($"{car}\t{teamColumn}\t{laps}\t{lapDifference}\t{lastLapColumn}\t{lastEventColumn}");
                                }

                                if (car != 4 && car != 13 && car != 12)
                                {
                                    ignoreLap = laps > 1 && lapDifference <= 0;
                                    if (!ignoreLap)
                                    {
                                        if (lapDifference != 1 && laps > 0 && previousLap.LapsDifference.HasValue && lapDifference + previousLap.LapsDifference != 0)
                                        {
                                            ignoreLapTime = true;

                                            for (short i = Convert.ToInt16(previousLap.Laps + 1); i < laps; i++)
                                            {
                                                deviceConfigurationInputs.Items.Add(new Razmanager.Protobuf.Public.V1.DeviceConfigurationInput
                                                {
                                                    DeviceConfigurationId = deviceConfigurationId,
                                                    CorrelationId = Guid.NewGuid().ToString(),
                                                    Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(timeStamp),
                                                    DeviceConfigurationInputTypeId = Razmanager.Protobuf.Public.V1.DeviceConfigurationInputTypeId.StartFinishIndicatorIgnoreLapTime,
                                                    DeviceConfigurationInputId = car
                                                });
                                            }
                                        }
                                    }
                                }
                            }

                            if (!ignoreLap)
                            {
                                if (lastEvent > TimeSpan.FromMinutes(1) && laps > 5 && heatStateTypeId == HeatStateTypeId.Running)
                                {
                                    if (lapTime.TotalSeconds > _chronoLogOptions.PitLaneThreshold)
                                    {
                                        deviceConfigurationInputs.Items.Add(new Razmanager.Protobuf.Public.V1.DeviceConfigurationInput
                                        {
                                            DeviceConfigurationId = deviceConfigurationId,
                                            CorrelationId = Guid.NewGuid().ToString(),
                                            Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(timeStamp),
                                            DeviceConfigurationInputTypeId = Razmanager.Protobuf.Public.V1.DeviceConfigurationInputTypeId.PitlaneEntry,
                                            DeviceConfigurationInputId = car
                                        });
                                        deviceConfigurationInputs.Items.Add(new Razmanager.Protobuf.Public.V1.DeviceConfigurationInput
                                        {
                                            DeviceConfigurationId = deviceConfigurationId,
                                            CorrelationId = Guid.NewGuid().ToString(),
                                            Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(timeStamp),
                                            DeviceConfigurationInputTypeId = Razmanager.Protobuf.Public.V1.DeviceConfigurationInputTypeId.PitlaneExit,
                                            DeviceConfigurationInputId = car
                                        });
                                    }
                                    else if (lapTime.TotalSeconds > _chronoLogOptions.DeslotThreshold)
                                    {
                                        deviceConfigurationInputs.Items.Add(new Razmanager.Protobuf.Public.V1.DeviceConfigurationInput
                                        {
                                            DeviceConfigurationId = deviceConfigurationId,
                                            CorrelationId = Guid.NewGuid().ToString(),
                                            Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(timeStamp),
                                            DeviceConfigurationInputTypeId = Razmanager.Protobuf.Public.V1.DeviceConfigurationInputTypeId.CarOnTrack,
                                            DeviceConfigurationInputId = car,
                                            BoolValue = true
                                        });
                                        deviceConfigurationInputs.Items.Add(new Razmanager.Protobuf.Public.V1.DeviceConfigurationInput
                                        {
                                            DeviceConfigurationId = deviceConfigurationId,
                                            CorrelationId = Guid.NewGuid().ToString(),
                                            Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(timeStamp),
                                            DeviceConfigurationInputTypeId = Razmanager.Protobuf.Public.V1.DeviceConfigurationInputTypeId.CarOnTrack,
                                            DeviceConfigurationInputId = car,
                                            BoolValue = false
                                        });
                                    }
                                }

                                if (lapTime.TotalSeconds == 0)
                                {
                                    ignoreLapTime = true;
                                }
                                deviceConfigurationInputs.Items.Add(new Razmanager.Protobuf.Public.V1.DeviceConfigurationInput
                                {
                                    DeviceConfigurationId = deviceConfigurationId,
                                    CorrelationId = Guid.NewGuid().ToString(),
                                    Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(timeStamp),
                                    DeviceConfigurationInputTypeId = !ignoreLapTime ? Razmanager.Protobuf.Public.V1.DeviceConfigurationInputTypeId.StartFinishIndicator : Razmanager.Protobuf.Public.V1.DeviceConfigurationInputTypeId.StartFinishIndicatorIgnoreLapTime,
                                    DeviceConfigurationInputId = car,
                                    LapTime = ignoreLapTime ? null : lapTime.TotalSeconds
                                });

                                await deviceConfigurationServiceClient.DeviceConfigurationInputsPublishAsync(deviceConfigurationInputs, null, null, stoppingToken);

                                latestCarLaps[car] = (laps, lapDifference);
                            }
                        }
                    }
                }
            }

            await Task.Delay(TimeSpan.FromMinutes(1));

            using (var channel = GrpcChannel.ForAddress(_chronoLogOptions.AppClientAddress, grpcChannelOptions))
            {
                var heatServiceClient = new Razmanager.Protobuf.Public.V1.HeatService.HeatServiceClient(channel);

                _logger.LogInformation("Ending race");
                await heatServiceClient.CommandAsync(new Razmanager.Protobuf.Public.V1.HeatCommandRequest
                {
                    Id = _chronoLogOptions.HeatId,
                    HeatCommandTypeId = Razmanager.Protobuf.Public.V1.HeatCommandTypeId.End
                }, null, DateTime.UtcNow.AddMinutes(2));

                _logger.LogInformation($"Waiting...");

                await Task.Delay(TimeSpan.FromMinutes(1));

                _logger.LogInformation("Closing race");
                await heatServiceClient.CommandAsync(new Razmanager.Protobuf.Public.V1.HeatCommandRequest
                {
                    Id = _chronoLogOptions.HeatId,
                    HeatCommandTypeId = Razmanager.Protobuf.Public.V1.HeatCommandTypeId.Close
                });

                foreach (var car in carControllerFirmwareVersions.Keys.OrderBy(x => x))
                {
                    Console.WriteLine($"{car} {string.Join(", ", carControllerFirmwareVersions[car])}");
                }
                foreach (var car in carCarFirmwareVersions.Keys.OrderBy(x => x))
                {
                    Console.WriteLine($"{car} {string.Join(", ", carCarFirmwareVersions[car])}");
                }
            }

            _hostApplicationLifetime.StopApplication();
        }
    }
}
