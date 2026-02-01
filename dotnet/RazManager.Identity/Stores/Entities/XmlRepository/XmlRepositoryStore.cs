using Microsoft.AspNetCore.DataProtection.Repositories;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;


namespace RazManager.Identity.Stores.Entities.XmlRepository
{
    public class XmlRepositoryStore : IXmlRepository
    {
        private readonly IServiceScopeFactory _serviceScopeFactory;


        public XmlRepositoryStore(IServiceScopeFactory serviceScopeFactory)
        {
            _serviceScopeFactory = serviceScopeFactory;
        }


        public IReadOnlyCollection<XElement> GetAllElements()
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Context.IdentityDbContext>();
                var response = dbContext.XmlRepositories.ToList();
                return response.Select(x => XElement.Parse(x.Element)).ToList();
            }
        }


        public void StoreElement(XElement element, string friendlyName)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Context.IdentityDbContext>();
                var entity = new XmlRepositoryEntity
                {
                    FriendlyName = friendlyName,
                    Element = element.ToString(SaveOptions.DisableFormatting),
                    TimeToLiveAt = DateTime.UtcNow.AddDays(100)  // Need to be longer than the longest refresh tokens lifetime
                };
                dbContext.XmlRepositories.Add(entity);
                dbContext.SaveChanges();
            }
        }
    }
}
