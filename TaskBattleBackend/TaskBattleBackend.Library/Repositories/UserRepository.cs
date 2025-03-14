using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using Microsoft.AspNetCore.Http;
using Org.BouncyCastle.Crypto.Generators;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using TaskBattleBackend.Library.DbContext;
using TaskBattleBackend.Library.Models;
using TaskBattleBackend.Library.Services;

namespace TaskBattleBackend.Library.Repositories
{
    public class UserRepository
    {
        private readonly TaskBattleContext _context;
        private readonly AuthService _authService;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public UserRepository(TaskBattleContext context, AuthService authService, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _authService = authService;
            _httpContextAccessor = httpContextAccessor;
        }

        public string Authorize(string username, string password)
        {
            var existingUser = _context.Users.FirstOrDefault(u => u.Username == username);
            var hash = HashPassword(password);

            if (existingUser == null || hash != existingUser.Password)
            {
                throw new InvalidOperationException("Invalid username or password");
            }

            return _authService.GenerateJwtToken(existingUser);
        }

        public User Add(User entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            if (_context.Users.Any(u => u.Email == entity.Email))
            {
                throw new InvalidOperationException("User with this email already exists.");
            }

            if (_context.Users.Any(u => u.Username == entity.Username))
            {
                throw new InvalidOperationException("User with this username already exists.");
            }

            entity.Password = HashPassword(entity.Password);

            _context.Users.Add(entity);
            _context.SaveChanges();

            return entity;
        }

        public User Delete(User entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            var existingEntity = _context.Users.Find(entity.Id);

            if (existingEntity == null)
            {
                throw new InvalidOperationException("User not found.");
            }

            _context.Users.Remove(existingEntity);
            _context.SaveChanges();

            return existingEntity;
        }

        public List<User> Get(Guid userId)
        {
            return _context.Friendships
                .Where(p => p.FriendFirstId == userId)
                .Select(p => p.FriendSecond).ToList();
        }

        public List<User> GetAll()
        {
            return _context.Users.ToList();
        }

        public User GetById(Guid id)
        {
            var user = _context.Users.Find(id);

            if (user == null)
            {
                throw new KeyNotFoundException($"User with id {id} not found.");
            }

            return user;
        }

        public User Update(User entity)
        {
            if (entity == null) throw new ArgumentNullException(nameof(entity));

            var existingEntity = _context.Users.Find(entity.Id);

            if (existingEntity == null)
            {
                throw new InvalidOperationException("User not found.");
            }

            _context.Entry(existingEntity).CurrentValues.SetValues(entity);
            _context.SaveChanges();

            return existingEntity;
        }

        private string HashPassword(string password)
        {
            byte[] salt;

            using (var sha256 = SHA256.Create())
            {
                salt = sha256.ComputeHash(Encoding.UTF8.GetBytes(password + "superpassword12345"));
            }

            return Convert.ToBase64String(KeyDerivation.Pbkdf2(
                password: password,
                salt: salt,
                prf: KeyDerivationPrf.HMACSHA256,
                iterationCount: 10000,
                numBytesRequested: 256 / 8));
        }
    }
}
