using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;


namespace RazManager.Utilities.Host
{
    public class CertificateService : ICertificateService
    {
        private readonly X509Certificate2 _certificate;


        public CertificateService()
        {
            var certificatePem = @"-----BEGIN CERTIFICATE-----
MIIC4TCCAcmgAwIBAgIJALBkdSJW4FYXMA0GCSqGSIb3DQEBCwUAMBUxEzARBgNV
BAMTClJhek1hbmFnZXIwIBcNMjUwMjE3MTkzMTEyWhgPMjA3NTAyMTcxOTMxMTJa
MBUxEzARBgNVBAMTClJhek1hbmFnZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDLTA7SX4Upa63RaQDopBfxNBCOVdhCRJtjhk+W1xjZMzstPoLNB3V/
A+miX8/bjKyo5v+xu7LPpk1Mwfd9mNzEj/w4EZ4BMCWP/DgXhcBM9SM1ZDZoLY4n
lg/xxLQxnN5fNMf/RDop7vI1XnWmv9lcFP1/pOCY3fdyE/qNmCap5i5Tfv67EamK
Shwlamf7jLsqFqh5ck6/mQMBwqm1N4DvOVH46cfN9XKfWEzG5cukRqpwww6uVbLW
y+LV23mtwU8YEmbPfmgC2GpKQYfEu7Ij9bLnRCZCnur5eHE6TbsGz7Gz+Xe+cqDt
5pVYWzOuWnOirAwTkZ95bDIfLk8RQ3o7AgMBAAGjMjAwMA8GA1UdEwEB/wQFMAMB
Af8wHQYDVR0OBBYEFN/5h7+LCpfqZR0TekBfivSlgOyTMA0GCSqGSIb3DQEBCwUA
A4IBAQBHASNJGfykOp3boN6MdvtNXHjPPraUSl35GpyTUa7lFUHFZWdVvxve8764
FD0ONeM6pcq4ng20P30Yd9zFeCaimjCESEgj9wXuyglvf1klhVtFkKAHUGtKPZSt
ZuNhxs77Jc/F4IMnMDP3lr3My1uKnkRY3ygatZ1fs/e7c60wla70x4uC9dorBWEf
gwNHRi+KPCWmnK0PKfZtS6uj7cLczCnJ+lYuz4rCi7+44JSVC13wY9g9VI0EIVr5
GpWYqtLheDaFaGJx3/z7akFPE4jLcFfqDl/3QWwPOOr++T6nEPKxrD/zy2gLr6uY
amyEIPfeljygt+5GVCyW4UP17cMb
-----END CERTIFICATE-----";

            var keyPem = @"-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAy0wO0l+FKWut0WkA6KQX8TQQjlXYQkSbY4ZPltcY2TM7LT6C
zQd1fwPpol/P24ysqOb/sbuyz6ZNTMH3fZjcxI/8OBGeATAlj/w4F4XATPUjNWQ2
aC2OJ5YP8cS0MZzeXzTH/0Q6Ke7yNV51pr/ZXBT9f6TgmN33chP6jZgmqeYuU37+
uxGpikocJWpn+4y7KhaoeXJOv5kDAcKptTeA7zlR+OnHzfVyn1hMxuXLpEaqcMMO
rlWy1svi1dt5rcFPGBJmz35oAthqSkGHxLuyI/Wy50QmQp7q+XhxOk27Bs+xs/l3
vnKg7eaVWFszrlpzoqwME5GfeWwyHy5PEUN6OwIDAQABAoIBAAifg29unXYveud2
MJOC8QBfqNDIw7ayifQeQdOlmwhiJmvvCgWf/96xL/XzDMeEv4bIiZGkjbCbdA2X
RU6pWbqSsEGWlGD7hamw/+trgR0ijBRF2b2bKmZJH12uGMXpSqYM1euLctDNhwOM
K/8J2zKPMgjPLwxSOfPiSg87JBoHtetrF0Yjl/Rc0e2H8r9KOdVMZ9NDXP5GDg58
I2O8EJcBUfzB0O09mP3y904rci5p/6KTtIdExre6S41TG3fBV44bPJMo9foxG5be
UiSfv8Ggcyt11L/S0HnFDAfNIgdRvy/Gb3DCC8A6hcjIpgLvuvcakqymZz3g9osV
BY5kyfECgYEA51E5LdusnXpiWn/F56LZ49E7D3gxY8HKlcv98aF7tuqd8KjVEiVf
zI6ZaGGLvXVwiXj/3zLY01sWtA7dKHYeWpxFSGSaF1r2xOlWtKsCYRVy8R9zum3O
r76KXUbALD6dsTAlzvWZxLN5+QvUPUSkveq07c9X3zCA0oT/9Ghl8PECgYEA4P1r
7JoPzre3qGGsw5UROViPPfy9M/Ysc+IN6bYA65Q7g2Eyh8qkFe/2/6xctYbYJniV
PL76eOCP/3Y21bBTOI9AdmfNsaE6Rhyb1uWMZvSNdVZTgpBSaAZvgDBJr7WRQVCc
zHuo+MBcrW41U54OnkQMgQO1RYf31/4r5qWkHesCgYB28klYz3E/uUMCDloR9qfc
gibAmamsBmbKCI+YxNT9BkAZFHgcUKOmaF1yU1asIcuwpUvN1jOw21IdXNdUiwio
x1rJExI5mEj0kJhJZvZePc1ROD8mSnjR3kUAGfWPytMD3iJS/fAIOdIqwm5s4vNj
xWEsOEaTOjnEBygm4dgpwQKBgGfj3U/1m9MCdmXkJFhznu5x/ELNT7iMtd4UxgPj
LO2bFxgFa8XURoxysAVDW9PenjS1fYP9U785QoTd21g1AVienU+PgyXAox342+UR
PhHUXvWNlSY26jZqslXo9j2Sg647QQwTFeU3PhQ/TZR86ZcfKP7x7WRb8o/kJ/Vr
CytdAoGAXJSqh09qTfbMGrOaJM9mWuD+4kb/ij3ii9daesHqyf7EWIox08/Ubvhx
gHuASrCYylLcFDnmLt+J28Kfyk6z+ivtWiKeIj0+xTuKCc717lTpzKdbPCXoCDCk
YZbMAb9W7ccjjOEHYWVJfihHT+tWZIMrPLLzX06djtAvMKwjHk4=
-----END RSA PRIVATE KEY-----";

            _certificate = X509Certificate2.CreateFromPem(certificatePem, keyPem);

            //using (var rsa = RSA.Create())
            //{
            //    var now = DateTimeOffset.UtcNow;
            //    var certificateRequest = new CertificateRequest("CN=RazManager", rsa, HashAlgorithmName.SHA256, RSASignaturePadding.Pkcs1);
            //    _certificate = certificateRequest.CreateSelfSigned(now, now.AddYears(50));
            //}
            //var certificatePem2 = _certificate.ExportCertificatePem();
            //var privateKeyPem2 = _certificate.GetRSAPrivateKey().ExportRSAPrivateKeyPem();


            //using (var rsa = RSA.Create())
            //{
            //    var now = DateTimeOffset.UtcNow;
            //    var signingCertificateRequest = new CertificateRequest("CN=RazManager", rsa, HashAlgorithmName.SHA256, RSASignaturePadding.Pkcs1);
            //    signingCertificateRequest.CertificateExtensions.Add(new X509BasicConstraintsExtension(true, false, 0, true));
            //    signingCertificateRequest.CertificateExtensions.Add(new X509SubjectKeyIdentifierExtension(signingCertificateRequest.PublicKey, false));
            //    var signingCertificate = signingCertificateRequest.CreateSelfSigned(now, now.AddYears(50));
            //    var certificatePem2 = signingCertificate.ExportCertificatePem();
            //    var privateKeyPem2 = signingCertificate.GetRSAPrivateKey().ExportRSAPrivateKeyPem();

            //}

        }


        public Task<IEnumerable<X509Certificate2>> GetAllCertificatesAsync(string[] certificateNames)
        {
            return Task.FromResult(new List<X509Certificate2> { _certificate }.AsEnumerable());
        }


        public Task<X509Certificate2> GetLatestCertificateWithRolloverDelayAsync(string[] certificateNames, TimeSpan rolloverDelay)
        {
            return Task.FromResult(_certificate);
        }
    }
}
