using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TaskBattleBackend.Library.Models;

namespace TaskBattleBackend.Library.DbContext
{
    public class TaskBattleContext : Microsoft.EntityFrameworkCore.DbContext
    {
        public TaskBattleContext(DbContextOptions<TaskBattleContext> options)
            : base(options)
        {
            
        }

        public DbSet<User> Users { get; set; }
        public DbSet<Session> Sessions { get; set; }
        public DbSet<Friendship> Friendships { get; set; }
        public DbSet<Message> Messages { get; set; }
        public DbSet<SessionParticipant> SessionParticipants { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Message>()
                .HasOne(m => m.Sender)
                .WithMany()
                .HasForeignKey(m => m.SenderId)
                .OnDelete(DeleteBehavior.Restrict); // Если удаление запрещено, иначе можно Cascade

            modelBuilder.Entity<Message>()
                .HasOne(m => m.Session)
                .WithMany()
                .HasForeignKey(m => m.SessionId)
                .OnDelete(DeleteBehavior.Cascade); // Удаление связанных сообщений при удалении сессии
        }
    }
}
