using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Services.Interfaces;

namespace Ataa_Mobile_Application.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AiMatchingController : ControllerBase
    {
        private readonly IAiMatchingService _aiMatchingService;

        public AiMatchingController(IAiMatchingService aiMatchingService)
        {
            _aiMatchingService = aiMatchingService;
        }

        [HttpPost("match")]
        public async Task<IActionResult> MatchDonation([FromBody] MatchRequestDto request)
        {
            // التحقق من صحة البيانات المرسلة
            if (request == null || string.IsNullOrWhiteSpace(request.Description) || request.Charities.Count == 0)
            {
                return BadRequest("Invalid request data. Description and charities are required.");
            }

            var result = await _aiMatchingService.GetBestMatchAsync(request);

            if (result == null || result.Match == null)
            {
                return NotFound(new { Message = "No strong match found or AI service is down." });
            }

            return Ok(result);
        }
    }
}