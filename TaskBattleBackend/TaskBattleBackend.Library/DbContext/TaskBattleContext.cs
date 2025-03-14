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
            modelBuilder.Entity<SessionParticipant>()
                .HasKey(sp => new { sp.ParticipantId, sp.SessionId });

            modelBuilder.Entity<SessionParticipant>()
                .HasOne(sp => sp.Participant)
                .WithMany(u => u.SessionParticipants)
                .HasForeignKey(sp => sp.ParticipantId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<SessionParticipant>()
                .HasOne(sp => sp.Session)
                .WithMany(s => s.SessionParticipants)
                .HasForeignKey(sp => sp.SessionId)
                .OnDelete(DeleteBehavior.Cascade);




            modelBuilder.Entity<Friendship>()
                .HasOne(f => f.FriendFirst)
                .WithMany(u => u.Friendships)
                .HasForeignKey(f => f.FriendFirstId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Friendship>()
                .HasOne(f => f.FriendSecond)
                .WithMany()
                .HasForeignKey(f => f.FriendSecondId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<User>()
                .Navigation(u => u.Friendships)
                .AutoInclude(false);

            modelBuilder.Entity<Session>()
                .Navigation(s => s.Messages)
                .AutoInclude(false);

            modelBuilder.Entity<Message>()
                .HasOne(m => m.Sender)
                .WithMany()
                .HasForeignKey(m => m.SenderId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Message>()
                .HasOne(m => m.Session)
                .WithMany()
                .HasForeignKey(m => m.SessionId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
