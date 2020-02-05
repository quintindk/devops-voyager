using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AspNet.Legacy
{
    public interface IRepository<T> where T : class
    {
        string Get(string key);
        IEnumerable<T> GetAll();
    }
}