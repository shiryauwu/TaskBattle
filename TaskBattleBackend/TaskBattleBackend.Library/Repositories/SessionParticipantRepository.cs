using System;
using System.Collections.Generic;
using System.Linq;
using TaskBattleBackend.Library.DbContext;
using TaskBattleBackend.Library.Models;

namespace TaskBattleBackend.Library.Repositories
{
    public class SessionParticipantRepository
    {
        private readonly TaskBattleContext _context;

        public SessionParticipantRepository(TaskBattleContext context)
        {
            _context = context;
        }

        public SessionParticipant Add(Guid participantId, Guid sessionId)
        {
            if (Guid.Empty == participantId || sessionId == Guid.Empty) throw new ArgumentNullException();

            var sessionParticipant = new SessionParticipant
            {
                ParticipantId = participantId,
                SessionId = sessionId
            };

            _context.SessionParticipants.Add(sessionParticipant);
            _context.SaveChanges();

            return sessionParticipant;
        }

        public SessionParticipant Delete(SessionParticipant entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            var existingEntity = _context.SessionParticipants
                .FirstOrDefault(p => (p.ParticipantId == entity.ParticipantId) && (p.SessionId == entity.SessionId));

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
