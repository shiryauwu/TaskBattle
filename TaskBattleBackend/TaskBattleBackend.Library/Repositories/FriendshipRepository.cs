using System;
using System.Collections.Generic;
using System.Linq;
using TaskBattleBackend.Library.DbContext;
using TaskBattleBackend.Library.Models;

namespace TaskBattleBackend.Library.Repositories
{
    public class FriendshipRepository : IBaseRepository<Friendship>
    {
        private readonly TaskBattleContext _context;

        public FriendshipRepository(TaskBattleContext context)
        {
            _context = context;
        }

        public Friendship Add(Friendship entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            _context.Friendships.Add(entity);
            _context.SaveChanges();

            return entity;
        }

        public Friendship Delete(Friendship entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            var existingEntity = _context.Friendships.Find(entity.Id);

            if (existingEntity == null)
            {
                throw new InvalidOperationException("Friendship not found.");
            }

            _context.Friendships.Remove(existingEntity);
            _context.SaveChanges();

            return existingEntity;
        }

        public List<Friendship> Get()
        {
            return _context.Friendships.ToList();
        }

        public Friendship GetById(Guid id)
        {
            var friendship = _context.Friendships.Find(id);

            if (friendship == null)
            {
                throw new KeyNotFoundException($"Friendship with id {id} not found.");
            }

            return friendship;
        }

        public Friendship Update(Friendship entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            var existingEntity = _context.Friendships.Find(entity.Id);

            if (existingEntity == null)
            {
                throw new InvalidOperationException("Friendship not found.");
            }

            _context.Entry(existingEntity).CurrentValues.SetValues(entity);
            _context.SaveChanges();

            return existingEntity;
        }
    }
}
