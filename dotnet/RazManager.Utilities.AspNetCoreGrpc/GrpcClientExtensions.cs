using Grpc.Core;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Net.Http;
using System.Threading.Tasks;


namespace RazManager.Utilities.AspNetCoreGrpc
{
    public static partial class GrpcClientExtensions
    {
        public static void AddGrpcClientAccessToken<TClient>(this IServiceCollection services, Uri address)
            where TClient : ClientBase
        {
            services.AddGrpcClient<TClient>(typeof(TClient).Namespace + "." + typeof(TClient).Name, options =>
            {
                options.Address = address;
            })
            .ConfigurePrimaryHttpMessageHandler(serviceProvider => new HttpClientHandler
            {
                ServerCertificateCustomValidationCallback = HttpClientHandler.DangerousAcceptAnyServerCertificateValidator
            })
            .ConfigureChannel((serviceProvider, options) =>
            {
                var credentials = CallCredentials.FromInterceptor((context, metadata) =>
                {
                    var authorization = serviceProvider.GetRequiredService<IHttpContextAccessor>()
                                            .HttpContext.Request.Headers[Microsoft.Net.Http.Headers.HeaderNames.Authorization];
                    if (authorization.Count > 0)
                    {
                        metadata.Add(Microsoft.Net.Http.Headers.HeaderNames.Authorization, authorization.ToString());
                    }
                    return Task.CompletedTask;
                });
                options.Credentials = ChannelCredentials.Create(new SslCredentials(), credentials);
                options.MaxReceiveMessageSize = 10 * 1024 * 1024;
                options.MaxSendMessageSize = 10 * 1024 * 1024;
            });
        }
    }
}
