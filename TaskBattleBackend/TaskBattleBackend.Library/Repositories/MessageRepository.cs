using System;
using System.Collections.Generic;
using System.Linq;
using TaskBattleBackend.Library.DbContext;
using TaskBattleBackend.Library.Models;

namespace TaskBattleBackend.Library.Repositories
{
    public class MessageRepository
    {
        private readonly TaskBattleContext _context;

        public MessageRepository(TaskBattleContext context)
        {
            _context = context;
        }

        public Message Add(Message entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            _context.Messages.Add(entity);
            _context.SaveChanges();

            return entity;
        }

        public Message Delete(Message entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            var existingEntity = _context.Messages.Find(entity.Id);

            if (existingEntity == null)
            {
                throw new InvalidOperationException("Message not found.");
            }

            _context.Messages.Remove(existingEntity);
            _context.SaveChanges();

            return existingEntity;
        }

        public List<Message> GetBySessionId(Guid id) 
        {
            return _context.Messages
                .Where(m => m.SessionId == id)
                .OrderBy(m => m.CreatedAt)
                .ToList();
        }

        public List<Message> Get()
        {
            return _context.Messages.ToList();
        }

        public Message GetById(Guid id)
        {
            var message = _context.Messages.Find(id);

            if (message == null)
            {
                throw new KeyNotFoundException($"Message with id {id} not found.");
            }

            return message;
        }

        public Message Update(Message entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            var existingEntity = _context.Messages.Find(entity.Id);

            if (existingEntity == null)
            {
                throw new InvalidOperationException("Message not found.");
            }

            _context.Entry(existingEntity).CurrentValues.SetValues(entity);
            _context.SaveChanges();

            return existingEntity;
        }
    }
}
