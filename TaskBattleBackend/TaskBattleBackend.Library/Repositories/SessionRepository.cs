using System;
using System.Collections.Generic;
using System.Linq;
using TaskBattleBackend.Library.DbContext;
using TaskBattleBackend.Library.Models;

namespace TaskBattleBackend.Library.Repositories
{
    public class SessionRepository : IBaseRepository<Session>
    {
        private readonly TaskBattleContext _context;

        public SessionRepository(TaskBattleContext context)
        {
            _context = context;
        }

        public Session Add(Session entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            _context.Sessions.Add(entity);
            _context.SaveChanges();

            return entity;
        }

        public Session Delete(Session entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            var existingEntity = _context.Sessions.Find(entity.Id);
            if (existingEntity == null)
            {
                throw new InvalidOperationException("Session not found.");
            }

            _context.Sessions.Remove(existingEntity);
            _context.SaveChanges();

            return existingEntity;
        }

        public List<Session> Get()
        {
            return _context.Sessions.ToList();
        }

        public Session GetById(Guid id)
        {
            var session = _context.Sessions.Find(id);

            if (session == null)
            {
                throw new KeyNotFoundException($"Session with id {id} not found.");
            }

            return session;
        }

        public Session Update(Session entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            var existingEntity = _context.Sessions.Find(entity.Id);

            if (existingEntity == null)
            {
                throw new InvalidOperationException("Session not found.");
            }

            _context.Entry(existingEntity).CurrentValues.SetValues(entity);
            _context.SaveChanges();

            return existingEntity;
        }
    }
}
