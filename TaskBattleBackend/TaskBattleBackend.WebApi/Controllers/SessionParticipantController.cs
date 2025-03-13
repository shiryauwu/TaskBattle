using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TaskBattleBackend.Library.Models;
using TaskBattleBackend.Library.Repositories;
using TaskBattleBackend.WebApi.DTO;

namespace TaskBattleBackend.WebApi.Controllers
{
    [Route("api/v1/[controller]")]
    public class SessionParticipantController : Controller
    {
        private readonly SessionParticipantRepository _sessionParticipantRepository;

        public SessionParticipantController(SessionParticipantRepository sessionParticipantRepository)
        {
            _sessionParticipantRepository = sessionParticipantRepository;
        }

        [Authorize]
        [HttpGet("get-participants")]
        public IActionResult Get() 
        {
            return Ok(_sessionParticipantRepository.Get());
        }

        [Authorize]
        [HttpPost("add-participant")]
        public IActionResult AddParticipant([FromBody] ParticipantDto participant)
        {
            return Ok(_sessionParticipantRepository.Add(participant.ParticipantId, participant.SessionId));
        }

        [Authorize]
        [HttpDelete("delete-participant")]
        public IActionResult DeleteParticipant([FromBody] SessionParticipant participant)
        {
            return Ok(_sessionParticipantRepository.Delete(participant));
        }
    }
}
