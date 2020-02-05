using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace AspNet.Legacy
{
    public class GreetingsRepo : IRepository<Greetings>
    {
        private readonly string _path;
        Greetings[] _greetings;

        public GreetingsRepo(string path)
        {
            if (string.IsNullOrWhiteSpace(path))
                throw new ArgumentNullException(nameof(path));

            _path = path;
        }

        private Greetings[] Greetings 
        { 
            get 
            {
                if (_greetings == null)
                {
                    var lines = File.ReadAllLines(_path);
                    _greetings = lines.Skip(1).Select(x => new Greetings { Language = x.Split('\"')[1], Greeting = x.Split('\"')[3] }).ToArray();
                }
                return _greetings;
            } 
        }

        public string Get(string key)
        {
            var greeting = Greetings.Where(x => x.Language == key).FirstOrDefault();
            return greeting?.Greeting;
        }        

        public IEnumerable<Greetings> GetAll()
        {
            return Greetings;
        }
    }
}