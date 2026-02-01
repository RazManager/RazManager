using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Identity.Stores.Context
{
    public class IdentityDbContextFactory : IDesignTimeDbContextFactory<IdentityDbContext>
    {
        IdentityDbContext IDesignTimeDbContextFactory<IdentityDbContext>.CreateDbContext(string[] args)
        {

            var optionsBuilder = new DbContextOptionsBuilder<IdentityDbContext>()
                .UseNpgsql();
            return new IdentityDbContext(optionsBuilder.Options);
        }
    }
}
