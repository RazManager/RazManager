using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;


namespace RazManager.Silo.Repository.Stores.Context
{
    public class SiloDbContextFactory : IDesignTimeDbContextFactory<SiloDbContext>
    {
        SiloDbContext IDesignTimeDbContextFactory<SiloDbContext>.CreateDbContext(string[] args)
        {

            var optionsBuilder = new DbContextOptionsBuilder<SiloDbContext>()
                .UseNpgsql();
            return new SiloDbContext(optionsBuilder.Options);
        }
    }
}
