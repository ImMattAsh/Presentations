using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TeamCityOctopusDemo.Web.Startup))]
namespace TeamCityOctopusDemo.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
