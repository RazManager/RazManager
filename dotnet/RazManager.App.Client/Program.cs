using Grpc.Net.Client;
using System;
using System.Net.Http;


var handler = new HttpClientHandler();
handler.ServerCertificateCustomValidationCallback = HttpClientHandler.DangerousAcceptAnyServerCertificateValidator;


var channel = GrpcChannel.ForAddress("https://app.razmanager.localhost", new GrpcChannelOptions { HttpHandler = handler });
//var channel = GrpcChannel.ForAddress("https://localhost", new GrpcChannelOptions { HttpHandler = handler });
var client = new Razmanager.Protobuf.Internal.Repository.CrudServices.CarTag.CarTagService.CarTagServiceClient(channel);

var response = await client.InitializeAsync(new Google.Protobuf.WellKnownTypes.Empty());


Console.WriteLine(response);