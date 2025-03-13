using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TaskBattleBackend.Library.Repositories
{
    public interface IBaseRepository<T>
    {
        public List<T> Get();
        public T GetById(Guid Id);
        public T Update(T entity);
        public T Add(T entity);
        public T Delete(T entity);
    }
}
