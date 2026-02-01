using System.Collections.Generic;
using System.Linq;


namespace RazManager.IO.Utilities
{
    public class NetworkInformation
    {

        public static IEnumerable<string> IPAddresses()
        {
            foreach (var networkInterface in System.Net.NetworkInformation.NetworkInterface.GetAllNetworkInterfaces()
                .Where(x => x.OperationalStatus == System.Net.NetworkInformation.OperationalStatus.Up &&
                            x.NetworkInterfaceType != System.Net.NetworkInformation.NetworkInterfaceType.Loopback &&
                            !x.Description.ToLower().Contains("virtual")))
            {
                foreach (var ip in networkInterface.GetIPProperties().UnicastAddresses
                    .Where(x => x.Address.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork))
                {
                    yield return ip.Address.ToString();
                }
            }
        }
    }
}