using Azure.Identity;
using Azure.Monitor.OpenTelemetry.AspNetCore;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using RazManager.Repository.Utilities;
using RazManager.Utilities.Grpc;
using RazManager.Utilities.Host;
using System.ComponentModel.DataAnnotations;
using System.IdentityModel.Tokens.Jwt;

var builder = WebApplication.CreateBuilder(args);

builder.WebHost.ConfigureKestrel((webHostBuilderContext, kestrelServerOptions) =>
{
    kestrelServerOptions.ListenAnyIP(8080, listenOptions =>
    {
        listenOptions.Protocols = Microsoft.AspNetCore.Server.Kestrel.Core.HttpProtocols.Http2;
    });
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

builder.Services.AddSingleton<ICertificateService, CertificateService>();

builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<IHttpContextOptions, HttpContextOptions>();

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
    //.AddJwtBearer("admin_api", options =>
    //{
    //    options.Authority = identityValidationOptions!.IdentityAuthority.ToString();
    //    options.RequireHttpsMetadata = builder.Environment.IsProduction();
    //    options.Audience = "admin_api";
    //    // In development, the client uses a different IdentityAuthority URL compared to the backend
    //    options.TokenValidationParameters.ValidateIssuer = builder.Environment.IsProduction();
    //})

builder.Services.AddAuthorization();

//builder.Services.AddAuthorization(options =>
//{
//    options.DefaultPolicy = new Microsoft.AspNetCore.Authorization.AuthorizationPolicyBuilder()
//        .RequireAuthenticatedUser()
//        //.AddAuthenticationSchemes("app_api", "admin_api")
//        //.AddAuthenticationSchemes("app_api", CertificateAuthenticationDefaults.AuthenticationScheme)
//        .AddAuthenticationSchemes(CertificateAuthenticationDefaults.AuthenticationScheme)
//        .Build();
//});

builder.Services.AddGrpc(options =>
{
    options.EnableDetailedErrors = true;
    options.MaxReceiveMessageSize = null;
    options.MaxSendMessageSize = null;
    options.Interceptors.Add<GrpcServerInterceptor>();
});

builder.Services.AddDbContextPool<RazManager.Repository.Stores.Context.RepositoryDbContext>(options =>
{
    options.UseNpgsql(
        databaseOptions!.DbContextConnectionStringRepository,
        npqsqlOptions => {
            npqsqlOptions.EnableRetryOnFailure();
        });
    if (builder.Environment.IsDevelopment())
    {
        options.EnableSensitiveDataLogging();
    }
});

builder.Services.AddScoped<RazManager.Repository.CrudServices.Entities.Car.ICarStore, RazManager.Repository.CrudServices.Entities.Car.CarStore>();
builder.Services.AddScoped<RazManager.Repository.CrudServices.Entities.CarTag.ICarTagStore, RazManager.Repository.CrudServices.Entities.CarTag.CarTagStore>();
builder.Services.AddScoped<RazManager.Repository.CrudServices.Entities.Device.IDeviceStore, RazManager.Repository.CrudServices.Entities.Device.DeviceStore>();
builder.Services.AddScoped<RazManager.Repository.CrudServices.Entities.Event.IEventStore, RazManager.Repository.CrudServices.Entities.Event.EventStore>();
builder.Services.AddScoped<RazManager.Repository.CrudServices.Entities.HeatIndicatorStint.IHeatIndicatorStintStore, RazManager.Repository.CrudServices.Entities.HeatIndicatorStint.HeatIndicatorStintStore>();
builder.Services.AddScoped<RazManager.Repository.CrudServices.Entities.Race.IRaceStore, RazManager.Repository.CrudServices.Entities.Race.RaceStore>();
builder.Services.AddScoped<RazManager.Repository.CrudServices.Entities.Tenant.ITenantStore, RazManager.Repository.CrudServices.Entities.Tenant.TenantStore>();
builder.Services.AddScoped<RazManager.Repository.CrudServices.Entities.Track.ITrackStore, RazManager.Repository.CrudServices.Entities.Track.TrackStore>();
builder.Services.AddScoped<RazManager.Repository.CrudServices.Entities.User.IUserStore, RazManager.Repository.CrudServices.Entities.User.UserStore>();

builder.Services.AddAutoMapper(
    cfg => { },
    typeof(RazManager.Repository.CrudServices.Entities.CarTag.CarTagMap).Assembly,
    typeof(RazManager.Utilities.Protobuf.EmptyGuidToProtoResolver).Assembly
);

//builder.Services.AddHostedService<RazManager.Repository.Host.TimeToLiveAtService>();

var app = builder.Build();

app.UseAuthentication();
app.UseAuthorization();

app.MapGrpcService<RazManager.Repository.CrudServices.Entities.Car.CarService>();
app.MapGrpcService<RazManager.Repository.CrudServices.Entities.CarTag.CarTagService>();
//app.MapGrpcService<RazManager.Repository.Logic.CrudServices.Entities.Autopilot.AutopilotService>();
app.MapGrpcService<RazManager.Repository.CrudServices.Entities.Device.DeviceService>();
app.MapGrpcService<RazManager.Repository.CrudServices.Entities.DeviceConfiguration.DeviceConfigurationService>();
app.MapGrpcService<RazManager.Repository.CrudServices.Entities.Event.EventService>();
app.MapGrpcService<RazManager.Repository.CrudServices.Entities.HeatIndicatorStint.HeatIndicatorStintService>();
//app.MapGrpcService<RazManager.Repository.Logic.CrudServices.Entities.PointsScheme.PointsSchemeService>();
app.MapGrpcService<RazManager.Repository.CrudServices.Entities.Race.RaceService>();
app.MapGrpcService<RazManager.Repository.CrudServices.Entities.RaceFormatType.RaceFormatTypeService>();
app.MapGrpcService<RazManager.Repository.CrudServices.Entities.Tenant.TenantService>();
app.MapGrpcService<RazManager.Repository.CrudServices.Entities.TenantUser.TenantUserService>();
//app.MapGrpcService<RazManager.Repository.Logic.CrudServices.Entities.TenantSystemAdmin.TenantSystemAdminService>();
app.MapGrpcService<RazManager.Repository.CrudServices.Entities.Track.TrackService>();
app.MapGrpcService<RazManager.Repository.CrudServices.Entities.TrackConfiguration.TrackConfigurationService>();
//app.MapGrpcService<RazManager.Repository.Logic.CrudServices.Entities.UserSystemAdmin.UserSystemAdminService>();
app.MapGrpcService<RazManager.Repository.CrudServices.Entities.User.UserService>();
app.MapGrpcService<RazManager.Repository.DeviceServices.Entities.Device.DeviceService>();
app.MapGrpcService<RazManager.Repository.PublicServices.Entities.Heat.HeatService>();
app.MapGrpcService<RazManager.Repository.PublicServices.Entities.Race.RaceService>();
app.MapGrpcService<RazManager.Repository.PublicServices.Entities.Version.VersionService>();
app.MapGrpcService<RazManager.Repository.SystemServices.Entities.Device.DeviceService>();
app.MapGrpcService<RazManager.Repository.SystemServices.Entities.DeviceConfiguration.DeviceConfigurationService>();
app.MapGrpcService<RazManager.Repository.SystemServices.Entities.Event.EventService>();
app.MapGrpcService<RazManager.Repository.SystemServices.Entities.HeatWithoutStint.HeatWithoutStintsService>();
app.MapGrpcService<RazManager.Repository.SystemServices.Entities.HeatWithStint.HeatWithStintsService>();
app.MapGrpcService<RazManager.Repository.SystemServices.Entities.HeatIndicatorStint.HeatIndicatorStintService>();
app.MapGrpcService<RazManager.Repository.SystemServices.Entities.Race.RaceService>();
app.MapGrpcService<RazManager.Repository.SystemServices.Entities.RaceSession.RaceSessionService>();
app.MapGrpcService<RazManager.Repository.SystemServices.Entities.Stint.StintService>();
app.MapGrpcService<RazManager.Repository.SystemServices.Entities.Tenant.TenantService>();
app.MapGrpcService<RazManager.Repository.SystemServices.Entities.Track.TrackService>();
app.MapGrpcService<RazManager.Repository.SystemServices.Entities.TrackConfiguration.TrackConfigurationService>();
app.MapGrpcService<RazManager.Repository.SystemServices.Entities.User.UserService>();
//app.MapGrpcService<RazManager.Repository.Logic.UserServices.Entities.Device.DeviceService>();
app.MapGrpcService<RazManager.Repository.UserServices.Entities.Event.EventService>();
app.MapGrpcService<RazManager.Repository.UserServices.Entities.EventInvite.EventInviteService>();
//app.MapGrpcService<RazManager.Repository.Logic.UserServices.Entities.Heat.HeatService>();
app.MapGrpcService<RazManager.Repository.UserServices.Entities.HeatIndicator.HeatIndicatorService>();
//app.MapGrpcService<RazManager.Repository.Logic.UserServices.Entities.Race.RaceService>();
app.MapGrpcService<RazManager.Repository.UserServices.Entities.Tenant.TenantService>();
app.MapGrpcService<RazManager.Repository.UserServices.Entities.TenantInvite.TenantInviteService>();
//app.MapGrpcService<RazManager.Repository.Logic.UserServices.Entities.User.UserService>();

using (var scope = app.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider.GetRequiredService<RazManager.Repository.Stores.Context.RepositoryDbContext>();
    dbContext.Database.Migrate();
}

app.Run();