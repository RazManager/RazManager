using Azure.Identity;
using Azure.Monitor.OpenTelemetry.AspNetCore;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Options;
using Orleans.Configuration;
using Orleans.Hosting;
using Orleans.Serialization;
using RazManager.App.Utilities;
using RazManager.Utilities.AspNetCoreGrpc;
using RazManager.Utilities.Grpc;
using RazManager.Utilities.GrpcClient;
using RazManager.Utilities.Host;
using RazManager.Utilities.Speech;
using System;
using System.ComponentModel.DataAnnotations;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Threading.Tasks;


var builder = WebApplication.CreateBuilder(args);

builder.WebHost.ConfigureKestrel(kestrelServerOptions =>
{
    kestrelServerOptions.ListenAnyIP(8080, listenOptions =>
    {
        listenOptions.Protocols = Microsoft.AspNetCore.Server.Kestrel.Core.HttpProtocols.Http2;
    });
    //kestrelServerOptions.Limits.Http2.KeepAlivePingDelay = TimeSpan.FromSeconds(30);
    //kestrelServerOptions.Limits.Http2.KeepAlivePingTimeout = TimeSpan.FromMinutes(1);
});

if (builder.Environment.IsProduction())
{
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

var identityValidationOptions = builder.Configuration.Get<IdentityValidationOptions>();
Validator.ValidateObject(identityValidationOptions!, new ValidationContext(identityValidationOptions!), true);

var databaseOptions = builder.Configuration.Get<DatabaseOptions>();
Validator.ValidateObject(databaseOptions!, new ValidationContext(databaseOptions!), true);

var repositoryClientOptions = builder.Configuration.Get<RepositoryClientOptions>();
Validator.ValidateObject(repositoryClientOptions!, new ValidationContext(repositoryClientOptions!), true);

var speechConfigOptions = builder.Configuration.Get<SpeechConfigOptions>();
Validator.ValidateObject(speechConfigOptions!, new ValidationContext(speechConfigOptions!), true);

builder.Services.AddSingleton<SpeechConfigOptions>(speechConfigOptions!);

builder.Services.AddHttpContextAccessor();
//builder.Services.AddScoped<IHttpContextOptions, HttpContextOptions>();

builder.Services.Configure<ForwardedHeadersOptions>(options =>
{
    options.KnownIPNetworks.Clear();
    options.KnownProxies.Clear();
    options.ForwardedHeaders = ForwardedHeaders.All;
});

JwtSecurityTokenHandler.DefaultInboundClaimTypeMap.Clear();

builder.Services.AddAuthentication()
    .AddJwtBearer("app_api", options =>
    {
        options.Authority = identityValidationOptions!.IdentityAuthority.ToString();
        options.RequireHttpsMetadata = builder.Environment.IsProduction();
        options.Audience = "app_api";
        // In development, the client uses a different IdentityAuthority URL compared to the backend
        options.TokenValidationParameters.ValidateIssuer = builder.Environment.IsProduction();
    });

builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("TenantAdministrator", policy =>
    {
        policy.RequireClaim(ClaimTypes.Role, "TenantAdministrator");
    });
});

builder.Services.AddGrpc(options =>
{
    options.EnableDetailedErrors = true;
    options.MaxReceiveMessageSize = null;
    options.MaxSendMessageSize = null;
    options.Interceptors.Add<GrpcServerInterceptor>();
});

builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.CrudServices.Car.CarService.CarServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.CrudServices.CarTag.CarTagService.CarTagServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.CrudServices.Device.DeviceService.DeviceServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.CrudServices.DeviceConfiguration.DeviceConfigurationService.DeviceConfigurationServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.CrudServices.Event.EventService.EventServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.CrudServices.HeatIndicatorStint.HeatIndicatorStintService.HeatIndicatorStintServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.CrudServices.Race.RaceService.RaceServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.CrudServices.RaceFormatType.RaceFormatTypeService.RaceFormatTypeServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.CrudServices.Tenant.TenantService.TenantServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.CrudServices.TenantUser.TenantUserService.TenantUserServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.CrudServices.Track.TrackService.TrackServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.CrudServices.TrackConfiguration.TrackConfigurationService.TrackConfigurationServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.CrudServices.User.UserService.UserServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.UserServices.Event.EventService.EventServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.UserServices.EventInvite.EventInviteService.EventInviteServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.UserServices.HeatIndicator.HeatIndicatorService.HeatIndicatorServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.UserServices.Tenant.TenantService.TenantServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Internal.Repository.UserServices.TenantInvite.TenantInviteService.TenantInviteServiceClient>(repositoryClientOptions!.RepositoryClientAddress);

builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Public.V1.HeatService.HeatServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientAccessToken<Razmanager.Protobuf.Public.V1.RaceService.RaceServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Public.V1.VersionService.VersionServiceClient>(repositoryClientOptions!.RepositoryClientAddress);

builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.HeatIndicatorStint.HeatIndicatorStintService.HeatIndicatorStintServiceClient>(repositoryClientOptions!.RepositoryClientAddress);

builder.UseOrleansClient(clientBuilder =>
{
    clientBuilder.Configure<Orleans.Configuration.ConnectionOptions>(options =>
    {
        options.ConnectionRetryDelay = TimeSpan.FromSeconds(30);
    });
    clientBuilder.Configure<ClientMessagingOptions>(options =>
     {
         options.ResponseTimeout = TimeSpan.FromMinutes(2);
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

    //siloBuilder.UseDevelopmentClustering()

    //siloBuilder
    //    .ConfigureEndpoints
    //    (
    //        siloPort: Orleans.Configuration.EndpointOptions.DEFAULT_SILO_PORT,
    //        gatewayPort: Orleans.Configuration.EndpointOptions.DEFAULT_GATEWAY_PORT,
    //        listenOnAnyHostAddress: true
    //    );
    //.UseAzureStorageClustering(options => options.ConfigureTableServiceClient(azureStorageOptions.AzureStorageConnectionString))
    //.AddStateStorageBasedLogConsistencyProvider()
    //.AddLogStorageBasedLogConsistencyProvider()
    //.AddCustomStorageBasedLogConsistencyProvider("CustomStorage")
    //.AddStateStorageBasedLogConsistencyProviderAsDefault()
    //.AddCustomStorageBasedLogConsistencyProviderAsDefault()
    //.AddAzureTableGrainStorage("PubSubStore", options => options.ConfigureTableServiceClient(azureStorageOptions.AzureStorageConnectionString))
    //.AddAzureQueueStreams(RazManager.EventCluster.Grains.Constants.StreamProvider, configurator =>
    //{
    //    configurator.ConfigureAzureQueue(ob => ob.Configure(options =>
    //    {
    //        options.ConfigureQueueServiceClient(azureStorageOptions.AzureStorageConnectionString);
    //        options.QueueNames = new List<string> { RazManager.EventCluster.Grains.Constants.StreamProvider };
    //    }));
    //})
    //.UseAzureTableReminderService(azureStorageOptions.AzureStorageConnectionString);
});

builder.Services.AddDbContextPool<RazManager.Silo.Repository.Stores.Context.SiloDbContext>(options =>
    options.UseNpgsql(
        databaseOptions!.DbContextConnectionStringSilo,
        npqsqlOptions => {
            npqsqlOptions.EnableRetryOnFailure();
        }));

builder.Services.AddSingleton<RazManager.Utilities.Speech.IEventSpeech, RazManager.Utilities.Speech.EventSpeech>();

var app = builder.Build();

app.UseForwardedHeaders();
app.UseAuthentication();
app.UseAuthorization();

app.MapGrpcService<RazManager.App.CrudServices.Entities.Car.CarService>();
app.MapGrpcService<RazManager.App.CrudServices.Entities.CarTag.CarTagService>();
//app.MapGrpcService<RazManager.Repository.Logic.CrudServices.Entities.Autopilot.AutopilotService>();
app.MapGrpcService<RazManager.App.CrudServices.Entities.Device.DeviceService>();
app.MapGrpcService<RazManager.App.CrudServices.Entities.DeviceConfiguration.DeviceConfigurationService>();
app.MapGrpcService<RazManager.App.CrudServices.Entities.Event.EventService>();
app.MapGrpcService<RazManager.App.CrudServices.Entities.HeatIndicatorStint.HeatIndicatorStintService>();
//app.MapGrpcService<RazManager.Repository.Logic.CrudServices.Entities.PointsScheme.PointsSchemeService>();
app.MapGrpcService<RazManager.App.CrudServices.Entities.Race.RaceService>();
app.MapGrpcService<RazManager.App.CrudServices.Entities.RaceFormatType.RaceFormatTypeService>();
app.MapGrpcService<RazManager.App.CrudServices.Entities.Tenant.TenantService>();
app.MapGrpcService<RazManager.App.CrudServices.Entities.TenantUser.TenantUserService>();
//app.MapGrpcService<RazManager.Repository.Logic.CrudServices.Entities.TenantSystemAdmin.TenantSystemAdminService>();
app.MapGrpcService<RazManager.App.CrudServices.Entities.Track.TrackService>();
app.MapGrpcService<RazManager.App.CrudServices.Entities.TrackConfiguration.TrackConfigurationService>();
app.MapGrpcService<RazManager.App.CrudServices.Entities.User.UserService>();
//app.MapGrpcService<RazManager.Repository.Logic.CrudServices.Entities.UserSystemAdmin.UserSystemAdminService>();
//app.MapGrpcService<RazManager.Repository.Logic.CrudServices.Entities.Car.CarService>();
//app.MapGrpcService<RazManager.Repository.Logic.UserServices.Entities.Device.DeviceService>();
app.MapGrpcService<RazManager.App.PublicServices.Entities.Event.EventService>();
app.MapGrpcService<RazManager.App.PublicServices.Entities.Heat.HeatService>();
app.MapGrpcService<RazManager.App.PublicServices.Entities.Race.RaceService>();
app.MapGrpcService<RazManager.App.PublicServices.Entities.Version.VersionService>();
app.MapGrpcService<RazManager.App.UserServices.Entities.Event.EventService>();
app.MapGrpcService<RazManager.App.UserServices.Entities.EventInvite.EventInviteService>();
//app.MapGrpcService<RazManager.Repository.Logic.UserServices.Entities.Heat.HeatService>();
//app.MapGrpcService<RazManager.Repository.Logic.UserServices.Entities.Race.RaceService>();
app.MapGrpcService<RazManager.App.UserServices.Entities.HeatIndicator.HeatIndicatorService>();
app.MapGrpcService<RazManager.App.UserServices.Entities.Tenant.TenantService>();
app.MapGrpcService<RazManager.App.UserServices.Entities.TenantInvite.TenantInviteService>();
//app.MapGrpcService<RazManager.App.UserServices.UserServices.Entities.User.UserService>();
app.MapGrpcService<RazManager.App.Silo.UserServices.Entities.DeviceConfiguration.DeviceConfigurationService>();


app.Run();