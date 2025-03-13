using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using TaskBattleBackend.Library.Models;
using TaskBattleBackend.Library.Repositories;
using TaskBattleBackend.WebApi.DTO;

namespace TaskBattleBackend.WebApi.Controllers
{
    [Route("api/v1/[controller]")]
    public class SessionController : Controller
    {
        private readonly SessionRepository _sessionRepository;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private Guid _currentUserId;

        public SessionController(SessionRepository sessionRepository, IHttpContextAccessor httpContextAccessor)
        {
            _sessionRepository = sessionRepository;
            _httpContextAccessor = httpContextAccessor;
        }

        [Authorize]
        [HttpPost("add-session")]
        public IActionResult AddSession([FromBody] SessionDto session)
        {
            _sessionRepository.Add(new Session
            {
                Id = Guid.NewGuid(),
                Name = session.Name,
                Type = session.Type,
                Description = session.Description,
            });

            return Ok(new { session.Name, session.Description});
        }

        [Authorize]
        [HttpPut("update-session")]
        public IActionResult UpdateSession([FromBody] Session session)
        {
            _sessionRepository.Update(session);

            return Ok(session);
        }

        [Authorize]
        [HttpDelete("delete-session")]
        public IActionResult DeleteSession([FromBody] Session session)
        {
            _sessionRepository.Delete(session);

            return NoContent();
        }

        [Authorize]
        [HttpGet("get_sessions")]
        public IActionResult GetSessions()
        {
            _currentUserId = Guid.Parse(_httpContextAccessor.HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);

            return Ok(_sessionRepository.Get(_currentUserId));
        }

        [Authorize]
        [HttpGet("get-session-by-id")]
        public IActionResult GetSessionById(Guid id) 
        { 
            return Ok(_sessionRepository.GetById(id));
        }
    }
}
