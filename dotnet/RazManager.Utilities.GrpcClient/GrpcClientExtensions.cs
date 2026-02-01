using Grpc.Core;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Net.Http;


namespace RazManager.Utilities.GrpcClient
{
    public static partial class GrpcClientExtensions
    {
        public static void AddGrpcClientWithoutAuthentication<TClient>(this IServiceCollection services, Uri address)
            where TClient : ClientBase
        {
            services.AddGrpcClient<TClient>(options =>
            {
                options.Address = address;
                //options.ChannelOptionsActions.
            })
            .ConfigureChannel(grpcChannelOptions =>
            {
                grpcChannelOptions.MaxReceiveMessageSize = 100 * 1024 * 1024;
            })
            .ConfigurePrimaryHttpMessageHandler(serviceProvider =>
            {
                var httpClientHandler = new HttpClientHandler
                {
                    ServerCertificateCustomValidationCallback = HttpClientHandler.DangerousAcceptAnyServerCertificateValidator
                };

                return httpClientHandler;
            });
        }
    }
}
