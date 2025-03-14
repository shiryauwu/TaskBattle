using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using TaskBattleBackend.Library.Models;
using TaskBattleBackend.Library.Repositories;
using static System.Net.Mime.MediaTypeNames;

namespace TaskBattleBackend.WebApi.Hubs
{
    [Authorize]
    public class ChatHub : Hub
    {
        private readonly MessageRepository _messageRepository;
        private readonly UserRepository _userRepository;
        
        public ChatHub(MessageRepository messageRepository, UserRepository userRepository)
        {
            _messageRepository = messageRepository;
            _userRepository = userRepository;
        }

        public override async Task OnConnectedAsync()
        {
            try
            {
                var user = Context.User?.Identity?.Name;

                if (user == null)
                {
                    Console.WriteLine("Authorization failed");
                    Context.Abort();
                }

                await base.OnConnectedAsync();
            } catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public async Task JoinSession(string sessionId)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, sessionId);

            var messages = _messageRepository.GetBySessionId(Guid.Parse(sessionId));
            await Clients.Caller.SendAsync("LoadMessages", messages);
        }

        public async Task SendMessage(string sessionId, string senderId, string text)
        {
            var message = new Message
            {
                Id = Guid.NewGuid(),
                SessionId = Guid.Parse(sessionId),
                SenderId = Guid.Parse(senderId),
                Text = text,
                CreatedAt = DateTime.UtcNow
            };

            _messageRepository.Add(message);

            await Clients.Group(sessionId.ToString()).SendAsync("ReceiveMessage", senderId, text);
        }

        public async Task Rate(string sessionId, string senderId, int rating)
        {
            var message = new Message
            {
                Id = Guid.NewGuid(),
                SessionId = Guid.Parse(sessionId),
                SenderId = Guid.Parse(senderId),
                Rating = rating,
                CreatedAt = DateTime.UtcNow
            };

            _messageRepository.Add(message);

            await Clients.Group(sessionId.ToString()).SendAsync("ReceiveMessage", senderId, rating);
        }

        public async Task LeaveSession(Guid sessionId)
        {
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, sessionId.ToString());
        }
    }
}
