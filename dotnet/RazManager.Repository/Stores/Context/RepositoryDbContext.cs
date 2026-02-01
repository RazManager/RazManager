using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;
using System.Threading;
using System;
using System.Linq;


namespace RazManager.Repository.Stores.Context
{
    public class RepositoryDbContext : RazManager.Utilities.EntityFramework.DbContextBase<RepositoryDbContext>
    {
        public RepositoryDbContext(DbContextOptions<RepositoryDbContext> options) : base(options) { }

        public DbSet<Entities.Autopilot.AutopilotEntity> Autopilots { get; set; }
        public DbSet<Entities.AutopilotImage.AutopilotImageEntity> AutopilotImages { get; set; }
        public DbSet<Entities.Car.CarEntity> Cars { get; set; }
        public DbSet<Entities.CarImage.CarImageEntity> CarImages { get; set; }
        public DbSet<Entities.CarTag.CarTagEntity> CarTags { get; set; }
        public DbSet<Entities.CarCarTag.CarCarTagEntity> CarCarTags { get; set; }
        //public DbSet<Entities.CarTrackConfiguration.CarTrackConfigurationEntity> CarTrackConfigurations { get; set; }
        public DbSet<Entities.Device.DeviceEntity> Devices { get; set; }
        //public DbSet<Store.Entities.DeviceProperty.DevicePropertyEntity> DeviceProperties { get; set; }
        public DbSet<Entities.DeviceConfiguration.DeviceConfigurationEntity> DeviceConfigurations { get; set; }
        public DbSet<Entities.DeviceConfigurationFeature.DeviceConfigurationFeatureEntity> DeviceConfigurationFeatures { get; set; }
        public DbSet<Entities.DeviceConfigurationInput.DeviceConfigurationInputEntity> DeviceConfigurationInputs { get; set; }
        public DbSet<Entities.DeviceConfigurationOutput.DeviceConfigurationOutputEntity> DeviceConfigurationOutputs { get; set; }
        public DbSet<Entities.Event.EventEntity> Events { get; set; }
        public DbSet<Entities.EventImage.EventImageEntity> EventImages { get; set; }
        public DbSet<Entities.EventInvite.EventInviteEntity> EventInvites { get; set; }
        public DbSet<Entities.EventUser.EventUserEntity> EventUsers { get; set; }
        public DbSet<Entities.EventUserImage.EventUserImageEntity> EventUserImages { get; set; }
        public DbSet<Entities.Heat.HeatEntity> Heats { get; set; }
        public DbSet<Entities.HeatIndicator.HeatIndicatorEntity> HeatIndicators { get; set; }
        public DbSet<Entities.HeatJournal.HeatJournalEntity> HeatJournals { get; set; }
        public DbSet<Entities.HeatIndicatorStint.HeatIndicatorStintEntity> HeatIndicatorStints { get; set; }
        public DbSet<Entities.PointsScheme.PointsSchemeEntity> PointsSchemas { get; set; }
        public DbSet<Entities.PointsSchemePosition.PointsSchemePositionEntity> PointsSchemePositions { get; set; }
        public DbSet<Entities.Race.RaceEntity> Races { get; set; }
        public DbSet<Entities.RaceEventUser.RaceEventUserEntity> RaceEventUsers { get; set; }
        public DbSet<Entities.RaceIndicator.RaceIndicatorEntity> RaceIndicators { get; set; }
        public DbSet<Entities.RaceIndicatorEventUser.RaceIndicatorEventUserEntity> RaceIndicatorEventUsers { get; set; }
        public DbSet<Entities.Tenant.TenantEntity> Tenants { get; set; }
        public DbSet<Entities.TenantImage.TenantImageEntity> TenantImages { get; set; }
        public DbSet<Entities.TenantInvite.TenantInviteEntity> TenantInvites { get; set; }
        public DbSet<Entities.TenantUser.TenantUserEntity> TenantUsers { get; set; }
        public DbSet<Entities.Track.TrackEntity> Tracks { get; set; }
        public DbSet<Entities.TrackImage.TrackImageEntity> TrackImages { get; set; }
        public DbSet<Entities.TrackConfiguration.TrackConfigurationEntity> TrackConfigurations { get; set; }
        public DbSet<Entities.TrackConfigurationDeviceConfiguration.TrackConfigurationDeviceConfigurationEntity> TrackConfigurationDeviceConfigurations { get; set; }
        public DbSet<Entities.TrackConfigurationIndicator.TrackConfigurationIndicatorEntity> TrackConfigurationIndicators { get; set; }
        public DbSet<Entities.TrackConfigurationRaceFormat.TrackConfigurationRaceFormatEntity> TrackConfigurationRaceFormats { get; set; }
        public DbSet<Entities.User.UserEntity> Users { get; set; }
        public DbSet<Entities.UserImage.UserImageEntity> UserImages { get; set; }
        public DbSet<Entities.Version.VersionEntity> Versions { get; set; }
        public DbSet<Entities.VersionNote.VersionNoteEntity> VersionNotes { get; set; }
        public DbSet<Entities.VersionPlatform.VersionPlatformEntity> VersionPlatforms { get; set; }


        //protected override void OnModelCreating(ModelBuilder modelBuilder)
        //{
        //    base.OnModelCreating(modelBuilder);
        //    //modelBuilder.HasDefaultSchema("Repository");
        //}

        //protected override void OnModelCreating(ModelBuilder modelBuilder)
        //{
        //    base.OnModelCreating(modelBuilder);

        //    foreach (var entityType in modelBuilder.Model.GetEntityTypes().Where(x => x is EntityStore.Utilities.ILogEntity))
        //    {
        //        foreach (var property in entityType.GetProperties().Where(x => x.Name == "RowVersion"))
        //        {
        //            property.IsConcurrencyToken = true;
        //            property.val .compu
        //            property.sql
        //            //.comp .SetComputedColumnSql
        //        }
        //    }
        //}


        //.ValueGeneratedOnAdd().HasValueGenerator<GuidValueGenerator>();

        //        var concurrencyTokenEntries = ChangeTracker.Entries<IVersionedEntity>();
        //foreach (var entry in concurrencyTokenEntries)
        //{
        //    if (entry.State == EntityState.Unchanged)
        //    {
        //        continue;
        //    }
        //    entry.Entity.Version = Guid.NewGuid();
        //}


        //builder.Property(t => t.Id) // type of Id is Guid
        //        .ValueGeneratedOnAdd()
        //        .HasDefaultValueSql("(uuid())");

        //foreach (var entityType in modelBuilder.Model.GetEntityTypes())
        //{
        //    foreach (var property in entityType.GetProperties())
        //    {
        //        if (property.ClrType == typeof(bool) || property.ClrType == typeof(bool?))             
        //            property.SetValueConverter(new BoolToZeroOneConverter<Int16>());
        //    }
        //}

        public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            foreach (var entityEntry in ChangeTracker.Entries().Where(x => x.State == EntityState.Added || x.State == EntityState.Modified))
            {
                var logEntity = entityEntry.Entity as Utilities.IEntity;
                if (logEntity != null)
                {
                    logEntity.ETag = Guid.NewGuid();
                }


                //var validationResults = new List<ValidationResult>();
                //if (!Validator.TryValidateObject(entityEntry.Entity, new ValidationContext(entityEntry.Entity), validationResults, true))
                //{
                //    throw new Server.Utilities.ValidationException(validationResults);
                //}

                //foreach (var property in entityEntry.CurrentValues.Properties.Where(x => x.ClrType == typeof(string) && x.IsNullable))
                //{
                //    var x = entityEntry.CurrentValues.GetValue<string?>(property);
                //    if (string.IsNullOrWhiteSpace(x))
                //    {
                //        var xx = new Dictionary<string, string?>();
                //        xx.Add(property.Name, "TEST");
                //        entityEntry.CurrentValues.SetValues(xx);
                //    }
                //}
            }

            return base.SaveChangesAsync(cancellationToken);
        }
    }
}
