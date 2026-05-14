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
    public class ReservationsController(IReservationService reservationService) : ControllerBase
    {
        private readonly IReservationService _reservationService = reservationService;

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var result = await _reservationService.GetAllAsync(CurrentUserId());
            return Ok(result);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var result = await _reservationService.GetByIdAsync(id, CurrentUserId());

            if (result == null)
                return NotFound(new { message = "Reservation not found or you do not have permission to access it" });

            return Ok(result);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateReservationDto dto)
        {
            var result = await _reservationService.CreateAsync(dto, CurrentUserId());

            if (result == null)
                return BadRequest(new { message = "Invalid reservation request. Donation must be assigned to your charity and not already reserved." });

            return StatusCode(StatusCodes.Status201Created, result);
        }

        [HttpPut("{id}/confirm")]
        public async Task<IActionResult> Confirm(int id)
        {
            var result = await _reservationService.ConfirmReceiptAsync(id, CurrentUserId());

            if (!result)
                return BadRequest(new { message = "Reservation not found, not yours, or cannot be completed" });

            return Ok(new { message = "Donation marked as completed" });
        }

        // التعديل 2: حماية استخراج الـ ID من الـ Crash
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
