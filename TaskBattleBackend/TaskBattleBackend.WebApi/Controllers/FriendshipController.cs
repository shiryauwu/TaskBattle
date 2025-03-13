using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TaskBattleBackend.Library.Models;
using TaskBattleBackend.Library.Repositories;
using TaskBattleBackend.WebApi.DTO;

namespace TaskBattleBackend.WebApi.Controllers
{
    [Route("api/v1/[controller]")]
    public class FriendshipController : Controller
    {
        private readonly FriendshipRepository _friendshipRepository;

        public FriendshipController(FriendshipRepository friendshipRepository)
        {
            _friendshipRepository = friendshipRepository;
        }

        [Authorize]
        [HttpGet("get-friendships")]
        public IActionResult Get()
        {
            return Ok(_friendshipRepository.Get());
        }

        [Authorize]
        [HttpPost("add-friend")]
        public IActionResult AddParticipant([FromBody] FriendshipDto friendship)
        {
            return Ok(_friendshipRepository.Add(friendship.FriendFirstId, friendship.FriendSecondId));
        }

        [Authorize]
        [HttpDelete("delete-friend")]
        public IActionResult DeleteParticipant([FromBody] Friendship friendship)
        {
            return Ok(_friendshipRepository.Delete(friendship));
        }
    }
}
