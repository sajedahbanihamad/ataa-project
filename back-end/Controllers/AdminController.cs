using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Services.Interfaces;

namespace Ataa_Mobile_Application.Controllers
{
    [Authorize(Roles = "Admin")]
    [Route("api/[controller]")]
    [ApiController]
    public class AdminController : ControllerBase
    {
        private readonly IAdminService _adminService;
        
        public AdminController(IAdminService adminService) 
        {
            _adminService = adminService;
        }

        [HttpGet("users")] 
        public async Task<IActionResult> GetUsers() => Ok(await _adminService.GetUsersAsync());
        
        [HttpGet("donors")] 
        public async Task<IActionResult> GetDonors() => Ok(await _adminService.GetDonorsAsync());
        
        [HttpGet("charities")] 
        public async Task<IActionResult> GetCharities() => Ok(await _adminService.GetUsersAsync("Charity"));
        
        [HttpGet("donations")] 
        public async Task<IActionResult> GetDonations() => Ok(await _adminService.GetDonationsAsync());
        
        [HttpGet("reservations")] 
        public async Task<IActionResult> GetReservations() => Ok(await _adminService.GetReservationsAsync());
        
        [HttpGet("statistics")] 
        public async Task<IActionResult> GetStats() => Ok(await _adminService.GetStatsAsync());

        [HttpPut("users/{id}/active/{isActive}")]
        public async Task<IActionResult> SetUserActive(int id, bool isActive)
        {
            var success = await _adminService.SetUserActiveAsync(id, isActive);
            if (!success)
                return BadRequest(new { message = "Failed to update user status. User might not exist." });

            return Ok(new { message = "User status updated successfully." });
        }

        [HttpPut("donations/{id}/status")]
        public async Task<IActionResult> UpdateDonationStatus(int id, [FromBody] UpdateDonationStatusDto dto)
        {
            var success = await _adminService.UpdateDonationStatusAsync(id, dto.Status);
            if (!success)
                return BadRequest(new { message = "Failed to update donation status. Donation might not exist." });

            return Ok(new { message = "Donation status updated successfully." });
        }
    }
}