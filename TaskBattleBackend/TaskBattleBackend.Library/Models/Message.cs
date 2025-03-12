using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TaskBattleBackend.Library.Models
{
    public class Message
    {
        public Guid Id { get; set; }
        public string? Text { get; set; }
        public Guid SenderId { get; set; }
        [ForeignKey("SenderId")]
        public virtual User Sender { get; set; }

        public Guid SessionId { get; set; }
        [ForeignKey("SessionId")]
        public virtual Session Session { get; set; }
        public string? SessionStatus { get; set; }
        public int Rating { get; set; }
    }
}
