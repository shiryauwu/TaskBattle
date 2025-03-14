using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TaskBattleBackend.Library.Models
{
    public class Session
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string? Description { get; set; }
        public List<SessionParticipant>? SessionParticipants { get; set; }
        public List<Message> Messages { get; set; }

    }
}
