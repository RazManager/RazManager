using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Razmanager.Protobuf.Internal.Io.Commissioning;
using System;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;


namespace RazManager.IO.Services.Commissioning
{
    public class CommissioningService : Razmanager.Protobuf.Internal.Io.Commissioning.CommissioningService.CommissioningServiceBase
    {
        private readonly CpuInfo.ICpuInfoService _cpuInfoService;
        private readonly Settings.ISettingsService _settingsService;


        public CommissioningService(CpuInfo.ICpuInfoService cpuInfoService,
                                    Services.Settings.ISettingsService settingsService)
        {
            _cpuInfoService = cpuInfoService;
            _settingsService = settingsService;
        }


        public override Task<CommissioningCertificateRequest> CertificateRequest(Empty request, ServerCallContext context)
        {
            if (_settingsService.IsCommissioned)
            {
                throw new RpcException(new Status(StatusCode.FailedPrecondition, "The device is already commissioned."));
            }

            var id = Guid.NewGuid();

            string name = "";
            if (!string.IsNullOrEmpty(_cpuInfoService.CpuInfo.ModelName))
            {
                name += " " + _cpuInfoService.CpuInfo.ModelName;
                name = name.Trim();
            }
            if (!string.IsNullOrEmpty(_cpuInfoService.CpuInfo.Serial))
            {
                name += " " + _cpuInfoService.CpuInfo.Serial;
                name = name.Trim();
            }
            if (string.IsNullOrEmpty(name))
            {
                var now = DateTime.Now;
                name = now.ToShortDateString() + " " + now.ToShortTimeString();
            }

            using (var rsa = RSA.Create())
            {
                //_settingsService.Settings.ClientId = id;
                _settingsService.Settings.DeviceName = name;
                _settingsService.Settings.KeyPem = rsa.ExportPkcs8PrivateKeyPem();
                var certificateRequest = new CertificateRequest($"CN={id}", rsa, HashAlgorithmName.SHA256, RSASignaturePadding.Pkcs1);
                certificateRequest.CertificateExtensions.Add(new X509BasicConstraintsExtension(false, false, 0,false));
                certificateRequest.CertificateExtensions.Add(new X509SubjectKeyIdentifierExtension(certificateRequest.PublicKey, true));
                certificateRequest.CertificateExtensions.Add(new X509KeyUsageExtension(X509KeyUsageFlags.NonRepudiation, false));
                return Task.FromResult(new CommissioningCertificateRequest
                {
                    CertificateRequestPem = certificateRequest.CreateSigningRequestPem(),
                    Name = name
                });
            }
        }


        public override async Task<Empty> CertificateResponse(CommissioningCertificateResponse request, ServerCallContext context)
        {
            _settingsService.Settings.CertificatePem = request.CertificatePem;
            await _settingsService.SaveAsync(true);
            return new Empty();
        }
    }
}