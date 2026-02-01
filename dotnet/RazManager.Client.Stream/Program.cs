using Grpc.Core;
using Grpc.Net.Client;
using System;
using System.Net.Http;


// See https://aka.ms/new-console-template for more information
Console.WriteLine("Hello, World!");

var handler = new HttpClientHandler();
handler.ServerCertificateCustomValidationCallback =
    HttpClientHandler.DangerousAcceptAnyServerCertificateValidator;

var channel = GrpcChannel.ForAddress("https://app.razmanager.localhost", new GrpcChannelOptions { HttpHandler = handler });
var client = new Razmanager.Protobuf.Internal.Silo.UserServices.DeviceConfiguration.DeviceConfigurationService.DeviceConfigurationServiceClient(channel);


using (var call = client.DeviceConfigurationInputsSubscribe(new Google.Protobuf.WellKnownTypes.StringValue {  Value = "08d02746-7828-4047-a75e-30b77d81eeee" }))
{
    await foreach (var responseStream in call.ResponseStream.ReadAllAsync())
    {
        Console.WriteLine(responseStream);
    }
}


await channel.ShutdownAsync();

Console.WriteLine("Finished.");

Console.ReadLine();