// See https://aka.ms/new-console-template for more information
using IdentityModel.Client;
using System;
using System.Net.Http;
using static System.Net.WebRequestMethods;

Console.WriteLine("Hello, World!");

var client = new HttpClient();
//client.BaseAddress = new Uri("http://identity.razmanager.localhost");

//var disco = await client.GetDiscoveryDocumentAsync("http://identity.razmanager.localhost");
//if (disco.IsError) throw new Exception(disco.Error);

var passwordTokenRequest = new IdentityModel.Client.PasswordTokenRequest
{
    Address = "http://identity.razmanager.localhost/connect/token",
    //GrantType = IdentityModel.OidcConstants.GrantTypes.Password,
    ClientId = "user",
    Scope = IdentityModel.OidcConstants.StandardScopes.OpenId,
    UserName = "anders@razlogic.se",
    Password = "London12"
};

var tokenReponse = await client.RequestPasswordTokenAsync(passwordTokenRequest);

Console.WriteLine();
