using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Context
{
    public class RepositoryDbContextFactory : IDesignTimeDbContextFactory<RepositoryDbContext>
    {
        RepositoryDbContext IDesignTimeDbContextFactory<RepositoryDbContext>.CreateDbContext(string[] args)
        {

            var optionsBuilder = new DbContextOptionsBuilder<RepositoryDbContext>()
                .UseNpgsql(options => options.UseQuerySplittingBehavior(QuerySplittingBehavior.SplitQuery));
            return new RepositoryDbContext(optionsBuilder.Options);
        }
    }
}
