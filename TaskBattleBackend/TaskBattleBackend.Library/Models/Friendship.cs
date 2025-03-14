﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TaskBattleBackend.Library.Models
{
    public class Friendship
    {
        public Guid Id { get; set; }

        public Guid? FriendFirstId { get; set; }
        public User? FriendFirst { get; set; }

        public Guid FriendSecondId { get; set; }
        public User? FriendSecond { get; set; }
    }
}
