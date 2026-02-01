using Azure.Identity;
using Azure.Monitor.OpenTelemetry.AspNetCore;
using Microsoft.AspNetCore.Authentication.Certificate;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Options;
using Orleans.Hosting;
using Orleans.Serialization;
using RazManager.Device.Utilities;
using RazManager.Utilities.AspNetCoreGrpc;
using RazManager.Utilities.Grpc;
using RazManager.Utilities.Host;
using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;


namespace RazManager.Device
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            if (builder.Environment.IsProduction())
            {
                builder.WebHost.ConfigureKestrel(kestrelServerOptions =>
                {
                    kestrelServerOptions.ListenAnyIP(8080, listenOptions =>
                    {
                        listenOptions.Protocols = Microsoft.AspNetCore.Server.Kestrel.Core.HttpProtocols.Http2;
                    });
                });

                var azureKeyVaultOptions = builder.Configuration.Get<AzureKeyVaultOptions>();
                Validator.ValidateObject(azureKeyVaultOptions!, new ValidationContext(azureKeyVaultOptions!), true);

                builder.Configuration.AddAzureKeyVault(
                    azureKeyVaultOptions!.AzureKeyVaultUri,
                    new ManagedIdentityCredential(ManagedIdentityId.FromUserAssignedObjectId(azureKeyVaultOptions.AzureKeyVaultManagedIdentityObjectId)));

                var applicationInsightsOptions = builder.Configuration.Get<ApplicationInsightsOptions>();
                Validator.ValidateObject(applicationInsightsOptions!, new ValidationContext(applicationInsightsOptions!), true);

                builder.Services.AddOpenTelemetry().UseAzureMonitor(options =>
                {
                    options.ConnectionString = applicationInsightsOptions!.ApplicationInsightsConnectionString;
                });
            }
            else
            {
                builder.WebHost.ConfigureKestrel((webHostBuilderContext, kestrelServerOptions) =>
                {
                    // SSL/TLS and a certificate is required when clients are using grpc.
                    // Otherwise, the client won't/can't send the credentials in the metadata header.
                    kestrelServerOptions.ListenAnyIP(5001, listenOptions =>
                    {
                        listenOptions.Protocols = Microsoft.AspNetCore.Server.Kestrel.Core.HttpProtocols.Http2;

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
            }

            var databaseOptions = builder.Configuration.Get<DatabaseOptions>();
            Validator.ValidateObject(databaseOptions!, new ValidationContext(databaseOptions!), true);

            var repositoryClientOptions = builder.Configuration.Get<RepositoryClientOptions>();
            Validator.ValidateObject(repositoryClientOptions!, new ValidationContext(repositoryClientOptions!), true);

            builder.Services.Configure<ForwardedHeadersOptions>(options =>
            {
                options.KnownIPNetworks.Clear();
                options.KnownProxies.Clear();
                options.ForwardedHeaders = ForwardedHeaders.All;
            });

            builder.Services.AddHttpContextAccessor();
            builder.Services.AddScoped<IHttpContextOptions, HttpContextOptions>();

            var c = new CertificateService().GetAllCertificatesAsync([]).Result.First();

            builder.Services.AddAuthentication(CertificateAuthenticationDefaults.AuthenticationScheme)
                .AddCertificate(CertificateAuthenticationDefaults.AuthenticationScheme, options =>
                {
                    options.AllowedCertificateTypes = CertificateTypes.SelfSigned;
                    options.ValidateCertificateUse = false;
                    options.ChainTrustValidationMode = System.Security.Cryptography.X509Certificates.X509ChainTrustMode.CustomRootTrust;
                    options.CustomTrustStore = new System.Security.Cryptography.X509Certificates.X509Certificate2Collection(c);

                    options.Events = new CertificateAuthenticationEvents
                    {
                        OnCertificateValidated = async context =>
                        {
                            //var serviceClient = context.HttpContext.RequestServices.GetRequiredService<Razmanager.Protobuf.Internal.Repository.SystemServices.Device.DeviceService.DeviceServiceClient>();
                            //var authorizedResponse = await serviceClient.AuthorizedCertificateAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = context.ClientCertificate.Thumbprint });
                            //if (authorizedResponse.Authorized)
                            //{
                                var claims = new[]
                                {
                                    new Claim("deviceId", "123")
                                };
                                context.Principal = new ClaimsPrincipal(new ClaimsIdentity(claims, context.Scheme.Name));
                                context.Success();
                            //}
                            //else
                            //{
                            //    context.Fail($"Non-valid certificate: {context.ClientCertificate.Thumbprint}");
                            //}
                        }
                    };
                });

            builder.Services.AddAuthorization();

            builder.Services.AddGrpc(options =>
            {
                options.EnableDetailedErrors = true;
                options.Interceptors.Add<GrpcServerInterceptor>();
            });

            builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.DeviceServices.Device.DeviceService.DeviceServiceClient>(repositoryClientOptions!.RepositoryClientAddress);

            builder.UseOrleansClient(clientBuilder =>
            {
                clientBuilder.Configure<Orleans.Configuration.ConnectionOptions>(options =>
                {
                    options.ConnectionRetryDelay = TimeSpan.FromSeconds(30);
                });
                clientBuilder.UseConnectionRetryFilter((exception, cancellationToken) =>
                {
                    return Task.FromResult(true);
                });


                clientBuilder.Services.AddSingleton<Orleans.Messaging.IGatewayListProvider, RazManager.Silo.Repository.Services.GatewayListProviderRepository>();
                clientBuilder.Services.AddSingleton<Orleans.IMembershipTable, RazManager.Silo.Repository.Services.MembershipTableRepository>();
                clientBuilder.AddMemoryStreams(RazManager.Silo.Grains.Constants.StreamProvider);

                clientBuilder.Services.AddSerializer(serializerBuilder =>
                {
                    serializerBuilder.AddProtobufSerializer();
                });
            });

            builder.Services.AddDbContextPool<RazManager.Silo.Repository.Stores.Context.SiloDbContext>(options =>
                options.UseNpgsql(
                    databaseOptions!.DbContextConnectionStringSilo,
                    npqsqlOptions => {
                        npqsqlOptions.EnableRetryOnFailure();
                    }));


            var app = builder.Build();

            app.UseForwardedHeaders();
            app.UseAuthentication();
            app.UseAuthorization();

            app.MapGrpcService<RazManager.Device.Services.Device.DeviceService>();
            app.MapGrpcService<RazManager.Device.Services.DeviceConfiguration.DeviceConfigurationService>();

            app.Run();
        }
    }
}