using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MusicSchoolProject.Startup))]
namespace MusicSchoolProject
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
