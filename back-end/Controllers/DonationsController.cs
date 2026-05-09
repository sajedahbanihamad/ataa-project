using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Services.Interfaces;
using Ataa_Mobile_Application.Common.Exceptions;
using System.Security.Claims;

namespace Ataa_Mobile_Application.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class DonationsController : ControllerBase
    {
        private readonly IDonationService _donationService;

        public DonationsController(IDonationService donationService)
        {
            _donationService = donationService;
        }

        [Authorize(Roles = "Admin")]
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var result = await _donationService.GetAllAsync();
            return Ok(result);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var result = await _donationService.GetByIdAsync(id, CurrentUserId(), CurrentRole());
            
            if (result == null)
                return NotFound(new { message = "Donation not found or you don't have access to view it." });

            return Ok(result);
        }

        [Authorize(Roles = "IndividualDonor,BusinessDonor")]
        [HttpGet("my-donations")]
        public async Task<IActionResult> GetMyDonations()
        {
            var result = await _donationService.GetByCurrentDonorAsync(CurrentUserId());
            return Ok(result);
        }

        [Authorize(Roles = "IndividualDonor,BusinessDonor")]
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateDonationDto dto)
        {
            var result = await _donationService.CreateAsync(dto, CurrentUserId());
            // التعديل: الأصح إرجاع 201 Created عند إنشاء مورد جديد
            return StatusCode(StatusCodes.Status201Created, result);
        }

        [Authorize(Roles = "IndividualDonor,BusinessDonor")]
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, [FromBody] UpdateDonationDto dto)
        {
            await _donationService.UpdateAsync(id, dto, CurrentUserId());
            return Ok(new { message = "Donation updated successfully" });
        }

        [Authorize(Roles = "IndividualDonor,BusinessDonor")]
        [HttpPut("{id}/cancel")]
        public async Task<IActionResult> Cancel(int id)
        {
            await _donationService.CancelAsync(id, CurrentUserId());
            return Ok(new { message = "Donation cancelled successfully" });
        }

        [Authorize(Roles = "Charity")]
        [HttpGet("dashboard")]
        public async Task<IActionResult> GetDashboardDonations()
        {
            var result = await _donationService.GetDashboardDonationsAsync(CurrentUserId());
            return Ok(result);
        }

        [HttpPost("filter")]
        public async Task<IActionResult> Filter([FromBody] DonationFilterDto filter)
        {
            var result = await _donationService.FilterDonationsAsync(filter, CurrentUserId(), CurrentRole());
            return Ok(result);
        }

        // التعديل: حماية استخراج الـ ID من الـ Crash
        private int CurrentUserId()
        {
            var claim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (int.TryParse(claim, out int userId))
            {
                return userId;
            }
            
            // إذا التوكن مضروب أو ما فيه ID، بنرمي الإيرور اللي عملناه عشان الـ Middleware يمسكه كـ 401
            throw new ApiException("Invalid or missing User ID in token.", 401);
        }

       // التعديل: حماية استخراج الـ Role
        private string CurrentRole()
        {
            var role = User.FindFirstValue(ClaimTypes.Role);
            if (string.IsNullOrEmpty(role))
            {
                throw new ApiException("User role is missing from token.", 403);
            }
            return role;
        }
    }
}
