using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TaskBattleBackend.Library.Models
{
    public class SessionParticipant
    {
        public Guid Id { get; set; }
        public Guid ParticipantId { get; set; }
        public User? Participant { get; set; }

        public Guid SessionId { get; set; }
        public Session? Session { get; set; }
    }
}
