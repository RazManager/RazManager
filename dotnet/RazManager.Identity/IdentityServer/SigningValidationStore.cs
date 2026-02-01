using Duende.IdentityServer.Models;
using Duende.IdentityServer.Stores;
using Microsoft.IdentityModel.Tokens;
using RazManager.Utilities.Host;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Identity.IdentityServer
{
    public class SigningValidationStore : ISigningCredentialStore, IValidationKeysStore
    {
        private readonly ICertificateService _certificateService;


        public SigningValidationStore(ICertificateService certificateService)
        {
            _certificateService = certificateService;
        }


        public async Task<SigningCredentials> GetSigningCredentialsAsync()
        {
            var certificate = await _certificateService.GetLatestCertificateWithRolloverDelayAsync
                (
                    ["identity"],
                    TimeSpan.FromDays(7)
                );

            return new SigningCredentials(new X509SecurityKey(certificate), SecurityAlgorithms.RsaSha256);
        }


        public async Task<IEnumerable<SecurityKeyInfo>> GetValidationKeysAsync()
        {
            var certificates = await _certificateService.GetAllCertificatesAsync
                (
                    ["identity"]
                );
            return certificates.Select(x => new SecurityKeyInfo
            {
                Key = new X509SecurityKey(x),
                SigningAlgorithm = SecurityAlgorithms.RsaSha256
            });
        }
    }
}
