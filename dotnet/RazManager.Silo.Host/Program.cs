using Azure.Identity;
using Azure.Monitor.OpenTelemetry.Exporter;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Orleans;
using Orleans.Configuration;
using Orleans.Hosting;
using Orleans.Serialization;
using RazManager.Silo.Host.Utilities;
using RazManager.Utilities.GrpcClient;
using RazManager.Utilities.Host;
using System;
using System.ComponentModel.DataAnnotations;


var builder = Host.CreateApplicationBuilder();

if (builder.Environment.IsProduction())
{
    var azureKeyVaultOptions = builder.Configuration.Get<AzureKeyVaultOptions>();
    Validator.ValidateObject(azureKeyVaultOptions!, new ValidationContext(azureKeyVaultOptions!), true);

    builder.Configuration.AddAzureKeyVault(
        azureKeyVaultOptions!.AzureKeyVaultUri,
        new ManagedIdentityCredential(ManagedIdentityId.FromUserAssignedObjectId(azureKeyVaultOptions.AzureKeyVaultManagedIdentityObjectId)));

    var applicationInsightsOptions = builder.Configuration.Get<ApplicationInsightsOptions>();
    Validator.ValidateObject(applicationInsightsOptions!, new ValidationContext(applicationInsightsOptions!), true);

    builder.Services.AddOpenTelemetry().UseAzureMonitorExporter(options =>
    {
        options.ConnectionString = applicationInsightsOptions!.ApplicationInsightsConnectionString;
    });
}

var databaseOptions = builder.Configuration.Get<DatabaseOptions>();
Validator.ValidateObject(databaseOptions!, new ValidationContext(databaseOptions!), true);

var repositoryClientOptions = builder.Configuration.Get<RepositoryClientOptions>();
Validator.ValidateObject(repositoryClientOptions!, new ValidationContext(repositoryClientOptions!), true);

builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.Device.DeviceService.DeviceServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.DeviceConfiguration.DeviceConfigurationService.DeviceConfigurationServiceClient>(repositoryClientOptions.RepositoryClientAddress);
builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.Event.EventService.EventServiceClient>(repositoryClientOptions.RepositoryClientAddress);
builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.HeatWithoutStints.HeatWithoutStintsService.HeatWithoutStintsServiceClient>(repositoryClientOptions.RepositoryClientAddress);
builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.HeatWithStints.HeatWithStintsService.HeatWithStintsServiceClient>(repositoryClientOptions.RepositoryClientAddress);
builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.HeatWithoutStints.HeatWithoutStintsService.HeatWithoutStintsServiceClient>(repositoryClientOptions.RepositoryClientAddress);
builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.HeatIndicatorStint.HeatIndicatorStintService.HeatIndicatorStintServiceClient>(repositoryClientOptions.RepositoryClientAddress);
builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient>(repositoryClientOptions.RepositoryClientAddress);
builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSessionWithoutStints.RaceSessionWithoutStintsService.RaceSessionWithoutStintsServiceClient>(repositoryClientOptions.RepositoryClientAddress);
builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSessionWithStints.RaceSessionWithStintsService.RaceSessionWithStintsServiceClient>(repositoryClientOptions.RepositoryClientAddress);
builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.Stint.StintService.StintServiceClient>(repositoryClientOptions.RepositoryClientAddress);
builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.Track.TrackService.TrackServiceClient>(repositoryClientOptions.RepositoryClientAddress);
builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.TrackConfiguration.TrackConfigurationService.TrackConfigurationServiceClient>(repositoryClientOptions.RepositoryClientAddress);

//services.AddHostedService<RazManager.EventClusterLogic.Host.TimeToLiveAtService>();

builder.UseOrleans(siloBuilder =>
{
    siloBuilder.Configure<Orleans.Configuration.ConnectionOptions>(options =>
    {
        options.ConnectionRetryDelay = TimeSpan.FromSeconds(30);
    });
    siloBuilder.Configure<GrainCollectionOptions>(options =>
    {
        options.ActivationTimeout = TimeSpan.FromMinutes(1);
    });
    siloBuilder.Configure<ClientMessagingOptions>(options =>
    {
        options.ResponseTimeout = TimeSpan.FromMinutes(2);
    });

    siloBuilder.Services.AddSingleton<Orleans.Messaging.IGatewayListProvider, RazManager.Silo.Repository.Services.GatewayListProviderRepository>();
    siloBuilder.Services.AddSingleton<Orleans.IMembershipTable, RazManager.Silo.Repository.Services.MembershipTableRepository>();
    siloBuilder.Services.AddKeyedSingleton<Orleans.Storage.IGrainStorage, RazManager.Silo.Repository.Services.GrainStorageRepository>("PubSubStore");
    siloBuilder.Services.AddReminders();
    siloBuilder.Services.AddSingleton<IReminderTable, RazManager.Silo.Repository.Services.ReminderTableRepository>();
    siloBuilder.AddMemoryStreams(RazManager.Silo.Grains.Constants.StreamProvider);
    siloBuilder.AddCustomStorageBasedLogConsistencyProviderAsDefault();

    //.AddStateStorageBasedLogConsistencyProvider()
    //.AddLogStorageBasedLogConsistencyProvider()
    //.AddCustomStorageBasedLogConsistencyProvider("CustomStorage")
    //.AddStateStorageBasedLogConsistencyProviderAsDefault()
    //.AddCustomStorageBasedLogConsistencyProviderAsDefault()

    siloBuilder.Services.AddSerializer(serializerBuilder =>
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

var host = builder.Build();

using (var scope = host.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider.GetRequiredService<RazManager.Silo.Repository.Stores.Context.SiloDbContext>();
    dbContext.Database.Migrate();
}

host.Run();