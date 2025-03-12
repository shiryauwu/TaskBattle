using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TaskBattleBackend.Library.Models;
using TaskBattleBackend.Library.Repositories;
using TaskBattleBackend.WebApi.DTO;

namespace TaskBattleBackend.WebApi.Controllers
{
    [Route("api/v1/[controller]")]
    public class UserController : Controller
    {
        private readonly UserRepository _userRepository;

        public UserController(IBaseRepository<User> userRepository)
        {
            _userRepository = (UserRepository?)userRepository;
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
    }
}
