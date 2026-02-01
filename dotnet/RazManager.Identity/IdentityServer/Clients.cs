using Duende.IdentityServer.Models;
using System.Collections.Generic;


namespace RazManager.Identity.IdentityServer
{
    public static class Clients
    {
        public static IEnumerable<Client> List =>
            [
                new Client
                {
                    ClientId = "app",
                    //ClientSecrets = { new Secret("secret".Sha256()) },
                    RequireClientSecret = false,

                    AllowedGrantTypes = GrantTypes.ResourceOwnerPassword,
                    AllowOfflineAccess = true,
                    UpdateAccessTokenClaimsOnRefresh = true,
                    AllowedScopes = { "app_api" }
                },             
            ];
    }
}
