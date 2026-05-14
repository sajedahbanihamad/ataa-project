using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Services.Interfaces;
using Ataa_Mobile_Application.Common.Exceptions;
using System.Security.Claims;

namespace Ataa_Mobile_Application.Controllers
{
    [Authorize(Roles = "Charity")]
    [Route("api/[controller]")]
    [ApiController]
    public class RatingsController(IRatingService ratingService) : ControllerBase
    {
        private readonly IRatingService _ratingService = ratingService;

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateRatingDto dto)
        {
            var result = await _ratingService.CreateAsync(dto, CurrentUserId());

            if (result == null)
                return BadRequest(new { message = "Unable to create rating. Reservation must be yours, completed, score 1-5, and not rated before." });

            return StatusCode(StatusCodes.Status201Created, result);
        }

        [Authorize(Roles = "IndividualDonor,BusinessDonor,Charity,Admin")]
        [HttpGet("donor/{donorUserId}")]
        public async Task<IActionResult> GetByDonorUserId(int donorUserId)
        {
            var result = await _ratingService.GetByDonorUserIdAsync(donorUserId);
            return Ok(result);
        }

        // التعديل 2: حماية استخراج الـ ID
        private int CurrentUserId()
        {
            var claim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (int.TryParse(claim, out int userId))
            {
                return userId;
            }
            
            throw new ApiException("Invalid or missing User ID in token.", 401);
        }
    }
}
