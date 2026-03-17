using Grpc.Net.Client;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Razmanager.Protobuf.Public.V1;
using RazManager.IO.Services.CpuInfo;
using RazManager.IO.Services.OsRelease;
using System;
using System.Collections.Generic;
using System.IO.Ports;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;


namespace RazManager.IO.Services.LapMaster
{
    public class LapMasterService : BackgroundService
    {
        private readonly Settings.ISettingsService _settingsService;
        private readonly Utilities.ConnectionOptions _connectionOptions;
        private readonly ILogger<LapMasterService> _logger;
        private string _deviceConfigurationId;
        private SerialPort? _serialPort;
        private Queue<byte>? _dataQueue;
        private GrpcChannel? _grpcChannel;


        public LapMasterService(Settings.ISettingsService settingsService,
                             ICpuInfoService cpuInfoService,
                             IOsReleaseService osReleaseService,
                             Utilities.ConnectionOptions connectionOptions,
                             ILogger<LapMasterService> logger)
        {
            _settingsService = settingsService;
            _connectionOptions = connectionOptions;
            _logger = logger;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            var deviceSettings = _settingsService.DeviceSettings;

            var deviceConfigurationSettings = deviceSettings.DeviceConfigurationSettings.Where(x => x.DeviceIntegrations.Any(x => x.ValueCase == DeviceIntegration.ValueOneofCase.DeviceIntegrationLapMaster)).SingleOrDefault();
            var deviceIntegrationLapMaster = deviceConfigurationSettings?.DeviceIntegrations?.SingleOrDefault(x => x.ValueCase == DeviceIntegration.ValueOneofCase.DeviceIntegrationLapMaster)?.DeviceIntegrationLapMaster;
            if (deviceIntegrationLapMaster is null)
            {
                return;
            }
            _deviceConfigurationId = deviceConfigurationSettings!.Id;

            _logger.LogInformation($"Opening {deviceIntegrationLapMaster.SerialPortName}...");
            _serialPort = new SerialPort(deviceIntegrationLapMaster.SerialPortName)
            {
                BaudRate = 9600,
                //DataBits = 8,
                //Parity = Parity.None,
                //StopBits = StopBits.One,
                //ReceivedBytesThreshold = 6
            };
            //_serialPort.ReadBufferSize = 65536;
            //serialPort.ReadTimeout = 300;
            //_serialPort.Handshake = Handshake.XOnXOff;
            //_serialPort.DtrEnable = true;
            //_serialPort.RtsEnable = false;
            _serialPort.DataReceived += serialPort_Rx;
            _serialPort.ErrorReceived += serialPort_ErrorReceived;
            _serialPort.Open();
            Console.WriteLine($"{_serialPort.PortName} opened.");

            _serialPort.Write(">R");
            _serialPort.Write([Convert.ToByte('>'), Convert.ToByte('M'), 255], 0, 3);
            _serialPort.Write(">F");
            _serialPort.Write([Convert.ToByte('>'), Convert.ToByte('M'), 255], 0, 3);
            _serialPort.Write(">N");

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
            _grpcChannel = GrpcChannel.ForAddress(_connectionOptions.DeviceClientAddress.ToString(), grpcChannelOptions);
            _logger.LogInformation("Channel created.");


            //    var deviceServiceClient = new Razmanager.Protobuf.Public.V1.DeviceService.DeviceServiceClient(deviceChannel);
            //    _logger.LogInformation("DeviceInformationAsync...");
            //    await deviceServiceClient.DeviceInformationAsync(deviceInformation, null, null, stoppingToken);


            //    await Task.Delay(Timeout.Infinite, stoppingToken);
            //}
            await Task.Delay(Timeout.Infinite, stoppingToken);
        }

        private void serialPort_Rx(object sender, SerialDataReceivedEventArgs e)
        {
            try
            {
                var now = DateTime.Now;
                var buffer = new byte[_serialPort!.BytesToRead];
                _serialPort.Read(buffer, 0, buffer.Length);
                Console.WriteLine($"{buffer.Length} bytes received.");

                if (_dataQueue is null)
                {
                    var chars = Encoding.ASCII.GetChars(buffer);
                    Console.WriteLine(chars);
                    _dataQueue = new();
                }
                else
                {
                    for (int i = 0; i < buffer.Length; i++)
                    {
                        _dataQueue.Enqueue(buffer[i]);
                    }

                    char firstChar;
                    do
                    {
                        firstChar = Convert.ToChar(_dataQueue.Peek());
                        if (firstChar != '>')
                        {
                            _dataQueue.Dequeue();
                        }

                    } while (firstChar != '>' && _dataQueue.Count > 0);

                    if (_dataQueue.Count >= 6)
                    {
                        var message = new byte[6];
                        for (int i = 0; i < message.Length; i++)
                        {
                            message[i] = _dataQueue.Dequeue();
                        }

                        Console.WriteLine(Convert.ToHexString(message));

                        var preamble = Convert.ToChar(message[0]);
                        var response = Convert.ToChar(message[1]);

                        switch (response)
                        {
                            case 'A':
                            case 'D':
                            case 'N':
                            case 'F':
                            case '1':
                            case '2':
                            case '3':
                            case '4':
                            case '5':
                            case '6':
                            case '7':
                            case '8':
                                Console.Write(preamble);
                                Console.Write(response);
                                Console.Write(" ");
                                var timer = message[2] * 16777216 + message[3] * 65536 + message[4] * 256 + message[5];
                                Console.Write(timer);
                                Console.Write(" \t");



                                //if (_latestTimers.ContainsKey(response))
                                //{
                                //    var previousTimer = _latestTimers[response];
                                //    var lapTime = (timer - previousTimer) / 1000.0;
                                //    Console.WriteLine(lapTime.ToString());
                                //}
                                //else
                                //{
                                //    Console.WriteLine();
                                //}
                                //_latestTimers[response] = timer;

                                Console.WriteLine();

                                if (response >= '1' && response <= '8')
                                {
                                    var deviceConfigurationInputs = new DeviceConfigurationInputs();
                                    deviceConfigurationInputs.Items.Add(new DeviceConfigurationInput
                                    {
                                        DeviceConfigurationId = _deviceConfigurationId,
                                        CorrelationId = Guid.NewGuid().ToString(),
                                        Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(DateTime.UtcNow),
                                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.StartFinishIndicator,
                                        DeviceConfigurationInputId = Convert.ToByte(response.ToString())
                                    });

                                    var deviceConfigurationServiceClient = new Razmanager.Protobuf.Public.V1.DeviceConfigurationService.DeviceConfigurationServiceClient(_grpcChannel);
                                    deviceConfigurationServiceClient.DeviceConfigurationInputsPublish(deviceConfigurationInputs);
                                }

                                break;
                            default:
                                var chars = Encoding.ASCII.GetChars(message);
                                Console.WriteLine(chars);
                                break;
                        }

                    }
                }
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception.Message);
            }
        }


        private void serialPort_ErrorReceived(object sender, SerialErrorReceivedEventArgs e)
        {
            Console.WriteLine(e.EventType);
        }



    }
}
