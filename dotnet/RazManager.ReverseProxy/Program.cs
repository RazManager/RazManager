using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;


var builder = WebApplication.CreateBuilder(args);

builder.WebHost.ConfigureKestrel((webHostBuilderContext, kestrelServerOptions) =>
{
    // SSL/TLS and a certificate is required when clients are using grpc.
    // Otherwise, the client won't/can't send the credentials in the metadata header.
    kestrelServerOptions.ListenAnyIP(443, listenOptions =>
    {
        //listenOptions.Protocols = Microsoft.AspNetCore.Server.Kestrel.Core.HttpProtocols.Http2;

        using (var rsa = RSA.Create())
        {
            var now = DateTimeOffset.UtcNow;
            var certificateRequest = new CertificateRequest("CN=RazManager", rsa, HashAlgorithmName.SHA256, RSASignaturePadding.Pkcs1);
            var certificate = certificateRequest.CreateSelfSigned(now, now.AddYears(50));

            listenOptions.UseHttps(certificate, options =>
            {
                options.ClientCertificateMode = Microsoft.AspNetCore.Server.Kestrel.Https.ClientCertificateMode.AllowCertificate;
                options.AllowAnyClientCertificate();
            });
        }
    });
});


builder.Services.AddReverseProxy()
    .LoadFromConfig(builder.Configuration.GetSection("ReverseProxy"));

var app = builder.Build();

app.MapReverseProxy();

app.Run();