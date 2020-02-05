using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace AspNet.Legacy
{
    /// <summary>
    /// This service returns a "Hellow Universe" greeting for a specific language and a list of languages. 
    /// This is meant to represent a legacy ASP.NET SOAP service which you cannot change due to some constraint.
    /// </summary>
    [WebService(Namespace = "http://container-demo.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class GreetingService : System.Web.Services.WebService
    {
        [WebMethod]
        public string Greet(string language)
        {
            var repository = new GreetingsRepo(HttpContext.Current.Server.MapPath("data.csv"));

            if (string.IsNullOrEmpty(language))
            {
                var all = repository.GetAll();
                var randmoizer = new Random(DateTime.UtcNow.Millisecond);
                var index = randmoizer.Next(0, all.Count() - 1);
                return all.ElementAt(index).Greeting;
            }

            return repository.Get(language);
        }

        [WebMethod]
        public string[] Languages()
        {
            var repository = new GreetingsRepo(HttpContext.Current.Server.MapPath("data.csv"));

            return repository.GetAll().Select(x => x.Language).ToArray();
        }
    }
}
