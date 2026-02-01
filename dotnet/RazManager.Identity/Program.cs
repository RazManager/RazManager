using Azure.Identity;
using Azure.Monitor.OpenTelemetry.AspNetCore;
using Duende.IdentityServer.Models;
using Duende.IdentityServer.Stores;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.DataProtection.KeyManagement;
using Microsoft.AspNetCore.DataProtection.Repositories;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Options;
using RazManager.Identity.Utilities;
using RazManager.Utilities.GrpcClient;
using RazManager.Utilities.Host;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


var builder = WebApplication.CreateBuilder(args);

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

var repositoryClientOptions = builder.Configuration.Get<RepositoryClientOptions>();
Validator.ValidateObject(repositoryClientOptions!, new ValidationContext(repositoryClientOptions!), true);

var databaseOptions = builder.Configuration.Get<DatabaseOptions>();
Validator.ValidateObject(databaseOptions!, new ValidationContext(databaseOptions!), true);

var identityServerOptions = builder.Configuration.Get<IdentityServerOptions>();
Validator.ValidateObject(identityServerOptions!, new ValidationContext(identityServerOptions!), true);

builder.Services.Configure<ForwardedHeadersOptions>(options =>
{
    options.KnownIPNetworks.Clear();
    options.KnownProxies.Clear();
    options.ForwardedHeaders = ForwardedHeaders.All;
});

builder.Services.AddIdentityServer(options =>
    {
        options.LicenseKey = identityServerOptions!.IdentityServerLicenseKey;
        options.KeyManagement.Enabled = false;
    })
    .AddInMemoryIdentityResources(new List<IdentityResource>
        {
            new IdentityResources.OpenId()
        })
    .AddInMemoryApiScopes(new List<ApiScope>
    {
                    new ApiScope("app_api", ["tenantId", "eventId", "role"]),
                    new ApiScope("admin_api", [])
    })
    .AddInMemoryApiResources(new List<ApiResource>
    {
                    new ApiResource("app_api") { Scopes = { "app_api" } },
                    new ApiResource("admin_api") { Scopes = { "admin_api" } }
    })
    .AddInMemoryClients(RazManager.Identity.IdentityServer.Clients.List)
    .AddResourceOwnerValidator<RazManager.Identity.IdentityServer.ResourceOwnerPasswordValidator>()
    .AddCustomTokenRequestValidator<RazManager.Identity.IdentityServer.CustomTokenRequestValidator>()
    .AddProfileService<RazManager.Identity.IdentityServer.ProfileService>()
    .AddPersistedGrantStore<RazManager.Identity.Stores.Entities.PersistedGrant.PersistedGrantStore>();

builder.Services.AddSingleton<ICertificateService, CertificateService>();
builder.Services.AddSingleton<ISigningCredentialStore>(serviceProvider =>
    new RazManager.Identity.IdentityServer.SigningValidationStore
    (
        serviceProvider.GetRequiredService<ICertificateService>()
    ));
builder.Services.AddSingleton<IValidationKeysStore>(serviceProvider =>
    new RazManager.Identity.IdentityServer.SigningValidationStore
    (
        serviceProvider.GetRequiredService<ICertificateService>()
    ));

builder.Services.AddSingleton<IXmlRepository, RazManager.Identity.Stores.Entities.XmlRepository.XmlRepositoryStore>();
builder.Services.AddSingleton<IConfigureOptions<KeyManagementOptions>>(serviceProvider =>
{
    return new ConfigureOptions<KeyManagementOptions>(options =>
    {
        options.XmlRepository = serviceProvider.GetRequiredService<IXmlRepository>();
    });
});


builder.Services.AddDbContextPool<RazManager.Identity.Stores.Context.IdentityDbContext>(options =>
    options.UseNpgsql(
        databaseOptions!.DbContextConnectionStringIdentity,
        npqsqlOptions => {
            npqsqlOptions.EnableRetryOnFailure();
        }));

builder.Services.AddAutoMapper(
    cfg => { },
    typeof(RazManager.Identity.Stores.Entities.PersistedGrant.PersistedGrantMap).Assembly
);

builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.Tenant.TenantService.TenantServiceClient>(repositoryClientOptions!.RepositoryClientAddress);
builder.Services.AddGrpcClientWithoutAuthentication<Razmanager.Protobuf.Internal.Repository.SystemServices.User.UserService.UserServiceClient>(repositoryClientOptions!.RepositoryClientAddress);

var app = builder.Build();

app.UseForwardedHeaders();
app.UseRouting();
app.UseIdentityServer();

using (var scope = app.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider.GetRequiredService<RazManager.Identity.Stores.Context.IdentityDbContext>();
    dbContext.Database.Migrate();
}

app.Run();