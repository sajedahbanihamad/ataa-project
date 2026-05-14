using Microsoft.EntityFrameworkCore;
using Ataa_Mobile_Application.Common.Exceptions;
using Ataa_Mobile_Application.Data;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Services.Interfaces;
using Ataa_Mobile_Application.Models;

namespace Ataa_Mobile_Application.Services.Implementations
{
    public class AdminService(AppDbContext context) : IAdminService
    {
        private readonly AppDbContext _context = context;
        private static readonly string[] Statuses = ["Pending", "Assigned", "Completed"];

        public async Task<IEnumerable<UserResponseDto>> GetUsersAsync(string? role = null)
        {
            var query = _context.Users.AsQueryable();
            if (!string.IsNullOrWhiteSpace(role)) 
                query = query.Where(u => u.Role == NormalizeRole(role));
                
            return await query.Select(u => MapToUserResponseDto(u)).ToListAsync();
        }

        public async Task<IEnumerable<DonationResponseDto>> GetDonationsAsync() =>
            await _context.Donations.Include(d => d.Category).Select(d => new DonationResponseDto 
            { 
                Id = d.Id, 
                DonorUserId = d.DonorUserId, 
                CategoryId = d.CategoryId, 
                Category = d.Category.Name, 
                Description = d.Description, 
                Quantity = d.Quantity, 
                AvailabilityTime = d.AvailabilityTime, 
                PickupLocation = d.PickupLocation, 
                Latitude = d.Latitude, 
                Longitude = d.Longitude, 
                Status = d.Status, 
                CreatedAt = d.CreatedAt, 
                UseAiMatching = d.UseAiMatching, 
                TargetCharityUserId = d.TargetCharityUserId 
            }).ToListAsync();
        public async Task<IEnumerable<ReservationResponseDto>> GetReservationsAsync() =>
            await _context.Reservations.Select(r => new ReservationResponseDto 
            { 
                Id = r.Id, 
                DonationId = r.DonationId, 
                CharityUserId = r.CharityUserId, 
                ReservationDate = r.ReservationDate, 
                Status = r.Status 
            }).ToListAsync();
        public async Task<bool> SetUserActiveAsync(int userId, bool isActive)
        {
            var user = await _context.Users.FindAsync(userId) ?? throw new ApiException("User not found", StatusCodes.Status404NotFound);
            user.IsActive = isActive;
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> UpdateDonationStatusAsync(int donationId, string status)
        {
            status = NormalizeStatus(status);
            var donation = await _context.Donations.FindAsync(donationId) ?? throw new ApiException("Donation not found", StatusCodes.Status404NotFound);
            donation.Status = status;
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<AdminStatsDto> GetStatsAsync() => new()
        {
            TotalUsers = await _context.Users.CountAsync(),
            TotalDonations = await _context.Donations.CountAsync(),
            CompletedDonations = await _context.Donations.CountAsync(d => d.Status == "Completed"),
            ActiveDonations = await _context.Donations.CountAsync(d => d.Status == "Pending" || d.Status == "Assigned")
        };

        private static string NormalizeStatus(string status)
        {
            var value = status.Trim();
            if (!Statuses.Contains(value)) throw new ApiException("Validation failed", StatusCodes.Status400BadRequest, ["Status must be Pending, Assigned, or Completed"]);
            return value;
        }

        private static string NormalizeRole(string role) => role.Trim().ToLower() switch
        {
            "donor" => "Donor",
            "individualdonor" or "individual donor" => "IndividualDonor",
            "businessdonor" or "business donor" => "BusinessDonor",
            "charity" => "Charity",
            "admin" => "Admin",
            _ => role.Trim()
        };
        public async Task<IEnumerable<UserResponseDto>> GetDonorsAsync()
        {
            // هون إحنا بنفلتر جوا الداتا بيز مباشرة، وهاد أسرع بكثير!
            return await _context.Users
                .Where(u => u.Role == "IndividualDonor" || u.Role == "BusinessDonor")
                .Select(u => MapToUserResponseDto(u))
                .ToListAsync();
        }
        private static UserResponseDto MapToUserResponseDto(User u) => new() 
        { 
            Id = u.Id, Name = u.Name, Email = u.Email, Role = u.Role, 
            AgreeToTerms = u.AgreeToTerms, IsActive = u.IsActive 
        };
    }
}
