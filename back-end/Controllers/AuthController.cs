using Microsoft.AspNetCore.Mvc;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Services.Interfaces;

namespace Ataa_Mobile_Application.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController(IAuthService authService) : ControllerBase
    {
        private readonly IAuthService _authService = authService;

        [HttpPost("register-individual-donor")]
        public async Task<IActionResult> RegisterIndividualDonor([FromBody] IndividualDonorRegisterDto dto)
        {
            var result = await _authService.RegisterIndividualDonorAsync(dto);
            return Ok(result);
        }

        [HttpPost("register-business-donor")]
        public async Task<IActionResult> RegisterBusinessDonor([FromBody] BusinessDonorRegisterDto dto)
        {
            var result = await _authService.RegisterBusinessDonorAsync(dto);
            return Ok(result);
        }

        [HttpPost("register-charity")]
        public async Task<IActionResult> RegisterCharity([FromBody] CharityRegisterDto dto)
        {
            var result = await _authService.RegisterCharityAsync(dto);
            return Ok(result);
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginDto dto)
        {
            var result = await _authService.LoginAsync(dto);
            return Ok(result);
        }
    }
}
