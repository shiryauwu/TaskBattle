using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using TaskBattleBackend.Library.Models;
using TaskBattleBackend.Library.Repositories;
using TaskBattleBackend.WebApi.DTO;

namespace TaskBattleBackend.WebApi.Controllers
{
    [Route("api/v1/[controller]")]
    public class UserController : Controller
    {
        private readonly UserRepository _userRepository;

        private readonly IHttpContextAccessor _httpContextAccessor;
        private Guid _currentUserId;

        public UserController(UserRepository userRepository, IHttpContextAccessor httpContextAccessor)
        {
            _userRepository = (UserRepository?)userRepository;
            _httpContextAccessor = httpContextAccessor;
            
        }

        [HttpPost("register")]
        public IActionResult Register([FromBody] UserDto dto)
        {
            if (string.IsNullOrEmpty(dto.Username) || string.IsNullOrEmpty(dto.Email) || string.IsNullOrEmpty(dto.Password))
                return BadRequest("All fields are required.");

            try
            {
                var user = new User
                {
                    Id = Guid.NewGuid(),
                    Username = dto.Username,
                    Email = dto.Email,
                    Password = dto.Password
                };

                var createdUser = _userRepository.Add(user);
                return Ok(new { id = createdUser.Id, username = createdUser.Username });
            }
            catch (InvalidOperationException ex)
            {
                return Conflict(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        [HttpPost("authorize")]
        public IActionResult Authorize([FromBody] UserLoginDto dto)
        {
            if (string.IsNullOrEmpty(dto.Username) || string.IsNullOrEmpty(dto.Password))
                return BadRequest("All fields are required.");

            try
            {
                var token = _userRepository.Authorize(dto.Username, dto.Password);

                return Ok(new { token });
            }
            catch (InvalidOperationException ex)
            {
                return Unauthorized(401);
            }
        }

        [Authorize]
        [HttpPut("update-user")]
        public IActionResult Update([FromBody] User user)
        {
            return Ok(_userRepository.Update(user));
        }

        [Authorize]
        [Consumes("multipart/form-data")]
        [HttpPut("update-user-photo")]
        public async Task<IActionResult> UpdatePhoto([FromForm] IFormFile file)
        {
            _currentUserId = Guid.Parse(_httpContextAccessor.HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            var user = _userRepository.GetById(_currentUserId);

            using (var memoryStream = new MemoryStream())
            {
                await file.CopyToAsync(memoryStream);
                user.Image = memoryStream.ToArray();
            }

            return Ok(_userRepository.Update(user));
        }

        [Authorize]
        [HttpGet("get-users")]
        public IActionResult GetUsers()
        {
            _currentUserId = Guid.Parse(_httpContextAccessor.HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);

            return Ok(_userRepository.Get(_currentUserId));
        }

        [Authorize]
        [HttpGet("get-user-by-id")]
        public IActionResult GetUserById(Guid id)
        {
            return Ok(_userRepository.GetById(id));
        }

        [Authorize]
        [HttpDelete("delete-user")]
        public IActionResult DeleteUser(User user)
        {
            return Ok(_userRepository.Delete(user));
        }
    }
}
