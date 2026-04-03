using Google.Protobuf;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Razmanager.Protobuf.Public.V1;
using System;
using System.IO;
using System.Security.Cryptography.X509Certificates;
using System.Text.Json;
using System.Threading.Channels;
using System.Threading.Tasks;


namespace RazManager.IO.Services.Settings
{
    public class SettingsService : ISettingsService
    {
        private readonly IHostApplicationLifetime _hostApplicationLifetime;
        private readonly ILogger<SettingsService> _logger;
        private string _filename = "";
        private SettingsDto _settings = new();
        private readonly JsonSerializerOptions _jsonSerializerOptions = new()
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
        };


        public SettingsService(IHostApplicationLifetime hostApplicationLifetime,
                               ILogger<SettingsService> logger)
        {
            _hostApplicationLifetime = hostApplicationLifetime;
            _logger = logger;

            try
            {
                var snapUserCommon = Environment.GetEnvironmentVariable("SNAP_USER_COMMON");
                if (!string.IsNullOrEmpty(snapUserCommon))
                {
                    _filename = $"{snapUserCommon}/";
                }
                _filename += "settings.json";
                _logger.LogInformation($"_filename={_filename}");

                try
                {
                    _settings = JsonSerializer.Deserialize<SettingsDto>(File.ReadAllText(_filename), _jsonSerializerOptions) ?? new();
                }
                catch (System.IO.FileNotFoundException)
                {
                }

                //if (!_settings.DeviceConfigurations.Any())
                //{
                //    _settings.DeviceConfigurations.Add(new DeviceConfiguration
                //    {
                //        Id = Guid.NewGuid()
                //    });
                //}
            }
            catch (Exception exception)
            {
                _logger.LogCritical(exception, exception.Message);
                throw;
            }
        }


        public bool IsCommissioned
        {
            get { return !string.IsNullOrEmpty(_settings.CertificatePem); }
        }


        public SettingsDto Settings { get { return _settings; } }


        //public X509Certificate2 Certificate => new X509Certificate2(X509Certificate2.CreateFromPem(_settings.CertificatePem!, _settings.KeyPem!).Export(X509ContentType.Pfx));
        public X509Certificate2 Certificate
        {
            get
            {
                //return X509Certificate2.CreateFromPem(_settings.CertificatePem, _settings.KeyPem);

                var certificate = X509Certificate2.CreateFromPem(_settings.CertificatePem, _settings.KeyPem);

                if (System.Environment.OSVersion.Platform == System.PlatformID.Win32NT)
                {
                    certificate = X509CertificateLoader.LoadPkcs12(certificate.Export(X509ContentType.Pkcs12, "password"), "password");
                }

                return certificate;
            }
        }


        public DeviceSettings DeviceSettings
        {
            get
            {
                if (string.IsNullOrEmpty(_settings.DeviceSettingsBase64))
                {
                    return new DeviceSettings();
                }

                var parser = DeviceSettings.Descriptor.Parser;
                var proto = parser.ParseFrom(Convert.FromBase64String(_settings.DeviceSettingsBase64)) as DeviceSettings;
                if (proto is null)
                {
                    return new DeviceSettings();
                }
                else
                {
                    return proto;
                }
            }
            set
            {
                _settings.DeviceSettingsBase64 = Convert.ToBase64String(value.ToByteArray());
            }
        }


        public async Task SaveAsync()
        {
            File.WriteAllText(_filename, JsonSerializer.Serialize(_settings, _jsonSerializerOptions));
            _logger.LogInformation($"{_filename} saved.");
            _hostApplicationLifetime.StopApplication();
        }
    }
}
