using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using RazManager.IO.Services.Commissioning;
using RazManager.IO.Services.SystemInformation;
using System;
using System.ComponentModel.DataAnnotations;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Channels;


namespace RazManager.IO
{
    public class Program
    {
        public static void Main(string[] args)
        {
            WebApplicationBuilder builder;

            var snap = System.Environment.GetEnvironmentVariable("SNAP");
            if (string.IsNullOrEmpty(snap))
            {
                builder = WebApplication.CreateBuilder();
            }
            else
            {
                builder = WebApplication.CreateBuilder(new WebApplicationOptions
                {
                    ContentRootPath = snap
                });
            }

            var connectionOptions = builder.Configuration.Get<Utilities.ConnectionOptions>();
            Validator.ValidateObject(connectionOptions!, new ValidationContext(connectionOptions!), true);
            builder.Services.AddSingleton<Utilities.ConnectionOptions>(connectionOptions!);

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

            builder.Services.AddSingleton(serviceProvider =>
                Channel.CreateUnbounded<bool>(new UnboundedChannelOptions
                {
                    SingleWriter = false,
                    SingleReader = true
                })
            );

            builder.Services.AddSingleton<Services.CpuInfo.ICpuInfoService>(serviceProvider =>
                new Services.CpuInfo.CpuInfoService(serviceProvider.GetRequiredService<ILogger<Services.CpuInfo.CpuInfoService>>())
            );

            builder.Services.AddSingleton<Services.OsRelease.IOsReleaseService>(serviceProvider =>
                new Services.OsRelease.OsReleaseService(serviceProvider.GetRequiredService<ILogger<Services.OsRelease.OsReleaseService>>())
            );

            builder.Services.AddSingleton<Services.Settings.ISettingsService>(serviceProvider =>
                new Services.Settings.SettingsService
                (
                    serviceProvider.GetRequiredService<Channel<bool>>(),
                    serviceProvider.GetRequiredService<ILogger<Services.Settings.SettingsService>>()
                )
            );

            builder.Services.AddGrpc(opt =>
            {
                opt.EnableDetailedErrors = true;
            });

            builder.Services.AddHostedService<RazManager.IO.Services.Device.DeviceService>();

            var app = builder.Build();

            app.MapGrpcService<CommissioningService>();
            app.MapGrpcService<SystemInformationService>();

            app.Run();
        }
    }
}