using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;
using System.Threading;
using System;


namespace RazManager.Silo.Repository.Stores.Context
{
    public class SiloDbContext : Utilities.EntityFramework.DbContextBase<SiloDbContext>
    {
        public SiloDbContext(DbContextOptions<SiloDbContext> options) : base(options) { }


        public DbSet<Entities.GrainStorage.GrainStorageEntity> GrainStorage { get; set; } = null!;
        public DbSet<Entities.Membership.MembershipEntity> Memberships { get; set; } = null!;
        public DbSet<Entities.MembershipVersion.MembershipVersionEntity> MembershipVersions { get; set; } = null!;
        public DbSet<Entities.MembershipSuspectTime.MembershipSuspectTimeEntity> MembershipSuspectTimes { get; set; } = null!;
        public DbSet<Entities.Reminder.ReminderEntity> Reminders { get; set; } = null!;


        public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            foreach (var entityEntry in ChangeTracker.Entries().Where(x => x.State == EntityState.Added || x.State == EntityState.Modified))
            {
                var grainStorageEntity = entityEntry.Entity as Entities.GrainStorage.GrainStorageEntity;
                if (grainStorageEntity != null)
                {
                    grainStorageEntity.ETag = Guid.NewGuid();
                }

                var membershipVersionEntity = entityEntry.Entity as Entities.MembershipVersion.MembershipVersionEntity;
                if (membershipVersionEntity != null)
                {
                    membershipVersionEntity.ETag = Guid.NewGuid();
                }

                var membershipEntity = entityEntry.Entity as Entities.Membership.MembershipEntity;
                if (membershipEntity != null)
                {
                    membershipEntity.ETag = Guid.NewGuid();
                }

                var reminderEntity = entityEntry.Entity as Entities.Reminder.ReminderEntity;
                if (reminderEntity != null)
                {
                    reminderEntity.ETag = Guid.NewGuid();
                }
            }

            return base.SaveChangesAsync(cancellationToken);
        }
    }
}
