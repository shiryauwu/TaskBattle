using System;
using System.Collections.Generic;
using System.Linq;
using TaskBattleBackend.Library.DbContext;
using TaskBattleBackend.Library.Models;

namespace TaskBattleBackend.Library.Repositories
{
    public class SessionParticipantRepository : IBaseRepository<SessionParticipant>
    {
        private readonly TaskBattleContext _context;

        public SessionParticipantRepository(TaskBattleContext context)
        {
            _context = context;
        }

        public SessionParticipant Add(SessionParticipant entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            _context.SessionParticipants.Add(entity);
            _context.SaveChanges();

            return entity;
        }

        public SessionParticipant Delete(SessionParticipant entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            var existingEntity = _context.SessionParticipants.Find(entity.Id);

            if (existingEntity == null)
            {
                throw new InvalidOperationException("Session participant not found.");
            }

            _context.SessionParticipants.Remove(existingEntity);
            _context.SaveChanges();

            return existingEntity;
        }

        public List<SessionParticipant> Get()
        {
            return _context.SessionParticipants.ToList();
        }

        public SessionParticipant GetById(Guid id)
        {
            var participant = _context.SessionParticipants.Find(id);

            if (participant == null)
            {
                throw new KeyNotFoundException($"Session participant with id {id} not found.");
            }

            return participant;
        }

        public SessionParticipant Update(SessionParticipant entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            var existingEntity = _context.SessionParticipants.Find(entity.Id);

            if (existingEntity == null)
            {
                throw new InvalidOperationException("Session participant not found.");
            }

            _context.Entry(existingEntity).CurrentValues.SetValues(entity);
            _context.SaveChanges();

            return existingEntity;
        }
    }
}
