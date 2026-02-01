namespace RazManager.Silo.Grains.Entities.Track
{
    public class TrackGrain : Grain, ITrackGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Track.TrackService.TrackServiceClient _serviceClient;


        public TrackGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.Track.TrackService.TrackServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public async Task RefreshAsync()
        {
            var proto = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
            var trackConfigurationIds = proto.TrackConfigurationIds.Select(x => new Guid(x));

            foreach (var trackConfigurationId in trackConfigurationIds)
            {
                await GrainFactory.GetGrain<TrackConfiguration.ITrackConfigurationGrain>(trackConfigurationId).RefreshAsync();
            }
        }
    }
}
