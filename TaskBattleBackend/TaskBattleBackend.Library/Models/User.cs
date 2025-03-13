using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TaskBattleBackend.Library.Models
{
    public class User
    {
        public Guid Id { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        
        public byte[]? Image { get; set; }
        public string? Description { get; set; }
        public int Points { get; set; }

        public List<SessionParticipant>? SessionParticipants { get; set; }
        public List<Friendship>? Friendships { get; set; }
    }
}
