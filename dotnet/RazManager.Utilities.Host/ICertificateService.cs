using System;
using System.Collections.Generic;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;


namespace RazManager.Utilities.Host
{
    public interface ICertificateService
    {
        Task<IEnumerable<X509Certificate2>> GetAllCertificatesAsync(string[] certificateNames);
        Task<X509Certificate2> GetLatestCertificateWithRolloverDelayAsync(string[] certificateNames, TimeSpan rolloverDelay);
    }
}
