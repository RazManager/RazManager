using Orleans;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.Track
{
    public interface ITrackGrain : IGrainWithGuidKey
    {
        Task RefreshAsync();
    }
}
