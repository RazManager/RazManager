using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using RazManager.IO.Services.Commissioning;
using RazManager.IO.Services.Settings;
using RazManager.IO.Services.SystemInformation;
using System;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Text.Json;
using System.Threading.Channels;


namespace RazManager.IO
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var x = System.Environment.GetEnvironmentVariables();

            string contentRootPath;
            var snap = System.Environment.GetEnvironmentVariable("SNAP");
            if (string.IsNullOrEmpty(snap))
            {
                contentRootPath = System.AppDomain.CurrentDomain.BaseDirectory;
            }
            else
            {
                contentRootPath = snap;
            }

            string filename;
            var snapUserCommon = Environment.GetEnvironmentVariable("SNAP_USER_COMMON");
            if (string.IsNullOrEmpty(snapUserCommon))
            {
                filename = contentRootPath;
            }
            else
            {
                filename = $"{snapUserCommon}/";
            }

            filename += "settings.json";

            var allowCommissioning = true;
            try
            {
                 var jsonSerializerOptions = new JsonSerializerOptions
                 {
                    PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                };
                var settings = JsonSerializer.Deserialize<SettingsDto>(File.ReadAllText(filename), jsonSerializerOptions) ?? new();
                allowCommissioning = string.IsNullOrEmpty(settings.KeyPem);
            }
            catch (System.IO.FileNotFoundException)
            {
            }

            if (allowCommissioning)
            {
                var builder = WebApplication.CreateBuilder(new WebApplicationOptions
                {
                    ContentRootPath = contentRootPath
                });

                builder.WebHost.ConfigureKestrel((webHostBuilderContext, kestrelServerOptions) =>
                {
                    kestrelServerOptions.ListenAnyIP(3302, listenOptions =>
                    {
                        listenOptions.Protocols = Microsoft.AspNetCore.Server.Kestrel.Core.HttpProtocols.Http2;

                        using (var rsa = RSA.Create())
                        {
                            var now = DateTimeOffset.UtcNow;
                            var certificateRequest = new CertificateRequest("CN=RazManager", rsa, HashAlgorithmName.SHA256, RSASignaturePadding.Pkcs1);
                            var certificate = certificateRequest.CreateSelfSigned(now, now.AddYears(50));

                            if (System.Environment.OSVersion.Platform == System.PlatformID.Win32NT)
                            {
                                certificate = X509CertificateLoader.LoadPkcs12(certificate.Export(X509ContentType.Pkcs12, "password"), "password");
                            }

                            listenOptions.UseHttps(certificate);
                        }
                    });
                });

                builder.Services.AddSingleton<Services.CpuInfo.ICpuInfoService>(serviceProvider =>
                    new Services.CpuInfo.CpuInfoService(serviceProvider.GetRequiredService<ILogger<Services.CpuInfo.CpuInfoService>>())
                );

                builder.Services.AddSingleton<Services.OsRelease.IOsReleaseService>(serviceProvider =>
                    new Services.OsRelease.OsReleaseService(serviceProvider.GetRequiredService<ILogger<Services.OsRelease.OsReleaseService>>())
                );

                builder.Services.AddSingleton<Services.Settings.ISettingsService>(serviceProvider =>
                    new Services.Settings.SettingsService
                    (
                        serviceProvider.GetRequiredService<Microsoft.Extensions.Hosting.IHostApplicationLifetime>(),
                        serviceProvider.GetRequiredService<ILogger<Services.Settings.SettingsService>>()
                    )
                );

                builder.Services.AddGrpc(opt =>
                {
                    opt.EnableDetailedErrors = true;
                });

                var app = builder.Build();

                app.MapGrpcService<CommissioningService>();
                app.MapGrpcService<SystemInformationService>();

                app.Run();
            }
            else
            {
                var builder = Host.CreateDefaultBuilder().UseContentRoot(contentRootPath);

                builder.ConfigureServices((hostBuilderContext, services) =>
                {
                    var connectionOptions = hostBuilderContext.Configuration.Get<Utilities.ConnectionOptions>();
                    Validator.ValidateObject(connectionOptions!, new ValidationContext(connectionOptions!), true);
                    services.AddSingleton<Utilities.ConnectionOptions>(connectionOptions!);

                    var chronoLogOptions = hostBuilderContext.Configuration.Get<Services.ChronoLog.ChronoLogOptions>();
                    Validator.ValidateObject(chronoLogOptions!, new ValidationContext(chronoLogOptions!), true);
                    services.AddSingleton<Services.ChronoLog.ChronoLogOptions>(chronoLogOptions!);

                    services.AddSingleton(serviceProvider =>
                        Channel.CreateUnbounded<bool>(new UnboundedChannelOptions
                        {
                            SingleWriter = false,
                            SingleReader = true
                        })
                    );

                    services.AddSingleton<Services.CpuInfo.ICpuInfoService>(serviceProvider =>
                        new Services.CpuInfo.CpuInfoService(serviceProvider.GetRequiredService<ILogger<Services.CpuInfo.CpuInfoService>>())
                    );

                    services.AddSingleton<Services.OsRelease.IOsReleaseService>(serviceProvider =>
                        new Services.OsRelease.OsReleaseService(serviceProvider.GetRequiredService<ILogger<Services.OsRelease.OsReleaseService>>())
                    );

                    services.AddSingleton<Services.Settings.ISettingsService>(serviceProvider =>
                        new Services.Settings.SettingsService
                        (
                            serviceProvider.GetRequiredService<Microsoft.Extensions.Hosting.IHostApplicationLifetime>(),
                            serviceProvider.GetRequiredService<ILogger<Services.Settings.SettingsService>>()
                        )
                    );

                    services.Configure<HostOptions>(hostOptions =>
                    {
                        hostOptions.BackgroundServiceExceptionBehavior = BackgroundServiceExceptionBehavior.Ignore;
                    });

                    services.AddHostedService<RazManager.IO.Services.Device.DeviceService>();
                    services.AddHostedService<RazManager.IO.Services.LapMaster.LapMasterService>();
                    services.AddHostedService<RazManager.IO.Services.ChronoLog.ChronoLogService>();
                    services.AddHostedService<RazManager.IO.Services.PerformanceTest.PerformanceTestService>();
                });

                var app = builder.Build();
                app.Run();
            }
        }
    }
}