using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;


namespace RazManager.Utilities.EntityFramework
{
    public abstract class DbContextBase<TDbContext> : DbContext
        where TDbContext : DbContext
    {
        public DbContextBase(DbContextOptions<TDbContext> options) : base(options)
        {
            // Do not track retrieved entities by default
            ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.NoTracking;
        }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Automatically apply entity configurations when building the DbContext model
            var entityTypeConfigurationTypes = GetType().Assembly.GetTypes()
                .Where(t => t.IsClass &&
                            t.GetInterfaces().Any(i => i.IsGenericType && i.GetGenericTypeDefinition() == typeof(IEntityTypeConfiguration<>))).ToList();
            foreach (var entityTypeConfigurationType in entityTypeConfigurationTypes)
            {
                dynamic entityTypeConfiguration = Activator.CreateInstance(entityTypeConfigurationType)!;
                modelBuilder.ApplyConfiguration(entityTypeConfiguration);
            }
        }
    }
}
