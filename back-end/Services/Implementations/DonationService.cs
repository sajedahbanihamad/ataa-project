using Microsoft.EntityFrameworkCore;
using Ataa_Mobile_Application.Common.Exceptions;
using Ataa_Mobile_Application.Data;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Models;
using Ataa_Mobile_Application.Services.Interfaces;

namespace Ataa_Mobile_Application.Services.Implementations
{
    public class DonationService(AppDbContext context) : IDonationService
    {
        private readonly AppDbContext _context = context;

        private static readonly string[] DonorRoles = ["IndividualDonor", "BusinessDonor"];
        private static readonly string[] DonationStatuses = ["Pending", "Assigned", "Completed", "Cancelled"];

        private IQueryable<DonationResponseDto> DonationProjectedQuery =>
            _context.Donations
                .Include(d => d.Category)
                .Select(d => new DonationResponseDto
                {
                    Id = d.Id,
                    DonorUserId = d.DonorUserId,
                    CategoryId = d.CategoryId,
                    Category = d.Category != null ? d.Category.Name : string.Empty,
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
                });

        public async Task<IEnumerable<DonationResponseDto>> GetAllAsync()
        {
            return await DonationProjectedQuery.ToListAsync();
        }

        public async Task<DonationResponseDto?> GetByIdAsync(int id, int currentUserId, string role)
        {
            var query = DonationProjectedQuery.Where(d => d.Id == id);

            if (DonorRoles.Contains(role))
                query = query.Where(d => d.DonorUserId == currentUserId);
            else if (role == "Charity")
                query = query.Where(d => d.TargetCharityUserId == currentUserId);
            else if (role != "Admin")
                throw new ApiException("Forbidden", StatusCodes.Status403Forbidden);

            var donation = await query.FirstOrDefaultAsync();

            if (donation == null)
                throw new ApiException("Donation not found", StatusCodes.Status404NotFound);

            return donation;
        }

        public async Task<IEnumerable<DonationResponseDto>> GetByCurrentDonorAsync(int donorUserId)
        {
            return await _context.Donations
                .Include(d => d.Category)
                .Where(d => d.DonorUserId == donorUserId)
                .Select(d => ToResponseDto(d))
                .ToListAsync();
        }

        public async Task<DonationResponseDto?> CreateAsync(CreateDonationDto dto, int donorUserId)
        {
            var donor = await _context.Users.FindAsync(donorUserId);

            if (donor == null || !DonorRoles.Contains(donor.Role) || !donor.IsActive)
                throw new ApiException("Only active donors can create donations", StatusCodes.Status403Forbidden);

            await ValidateDonationRequest(
                dto.CategoryId,
                dto.Description,
                dto.Quantity,
                dto.AvailabilityTime,
                dto.PickupLocation,
                dto.UseAiMatching,
                dto.TargetCharityUserId
            );

            var donation = new Donation
            {
                DonorUserId = donorUserId,
                CategoryId = dto.CategoryId,
                Description = dto.Description.Trim(),
                Quantity = dto.Quantity,
                AvailabilityTime = dto.AvailabilityTime,
                PickupLocation = dto.PickupLocation.Trim(),
                Latitude = dto.Latitude,
                Longitude = dto.Longitude,
                CreatedAt = DateTime.UtcNow,
                UseAiMatching = dto.UseAiMatching,
                TargetCharityUserId = dto.UseAiMatching ? null : dto.TargetCharityUserId,
                Status = dto.UseAiMatching ? "Pending" : "Assigned"
            };

            _context.Donations.Add(donation);

            // مهم: نحفظ التبرع أولاً حتى يتولد donation.Id
            await _context.SaveChangesAsync();

            // بعد ما يتولد Id نضيف الإشعار
            await AddAssignmentNotificationAsync(donation);

            await _context.Entry(donation)
                .Reference(d => d.Category)
                .LoadAsync();

            return ToResponseDto(donation);
        }

        public async Task<bool> UpdateAsync(int id, UpdateDonationDto dto, int donorUserId)
        {
            var donation = await _context.Donations
                .FirstOrDefaultAsync(d => d.Id == id && d.DonorUserId == donorUserId);

            if (donation == null)
                throw new ApiException("Donation not found", StatusCodes.Status404NotFound);

            if (donation.Status == "Completed")
                throw new ApiException("Completed donations cannot be updated", StatusCodes.Status400BadRequest);

            await ValidateDonationRequest(
                dto.CategoryId,
                dto.Description,
                dto.Quantity,
                dto.AvailabilityTime,
                dto.PickupLocation,
                dto.UseAiMatching,
                dto.TargetCharityUserId
            );

            donation.CategoryId = dto.CategoryId;
            donation.Description = dto.Description.Trim();
            donation.Quantity = dto.Quantity;
            donation.AvailabilityTime = dto.AvailabilityTime;
            donation.PickupLocation = dto.PickupLocation.Trim();
            donation.Latitude = dto.Latitude;
            donation.Longitude = dto.Longitude;
            donation.UseAiMatching = dto.UseAiMatching;
            donation.TargetCharityUserId = dto.UseAiMatching ? null : dto.TargetCharityUserId;
            donation.Status = dto.UseAiMatching ? "Pending" : "Assigned";

            await _context.SaveChangesAsync();

            return true;
        }

        public async Task<bool> CancelAsync(int id, int donorUserId)
        {
            var donation = await _context.Donations
                .FirstOrDefaultAsync(d => d.Id == id && d.DonorUserId == donorUserId);

            if (donation == null)
                throw new ApiException("Donation not found", StatusCodes.Status404NotFound);

            if (donation.Status == "Completed")
                throw new ApiException("Completed donations cannot be cancelled", StatusCodes.Status400BadRequest);

            donation.Status = "Cancelled";
            donation.TargetCharityUserId = null;

            await _context.SaveChangesAsync();

            return true;
        }

        public async Task<IEnumerable<DonationResponseDto>> FilterDonationsAsync(DonationFilterDto filter, int currentUserId, string role)
        {
            var query = _context.Donations
                .Include(d => d.Category)
                .AsQueryable();

            if (DonorRoles.Contains(role))
                query = query.Where(d => d.DonorUserId == currentUserId);
            else if (role == "Charity")
                query = query.Where(d => d.TargetCharityUserId == currentUserId);
            else if (role != "Admin")
                throw new ApiException("Forbidden", StatusCodes.Status403Forbidden);

            if (filter.CategoryId.HasValue)
                query = query.Where(d => d.CategoryId == filter.CategoryId.Value);

            if (!string.IsNullOrWhiteSpace(filter.Category))
                query = query.Where(d => d.Category.Name.Contains(filter.Category.Trim()));

            if (!string.IsNullOrWhiteSpace(filter.Location))
                query = query.Where(d => d.PickupLocation.Contains(filter.Location.Trim()));

            if (filter.AvailabilityTime.HasValue)
                query = query.Where(d => d.AvailabilityTime.Date == filter.AvailabilityTime.Value.Date);

            if (!string.IsNullOrWhiteSpace(filter.Status))
            {
                var status = NormalizeStatus(filter.Status);
                query = query.Where(d => d.Status == status);
            }

            return await query
                .Select(d => ToResponseDto(d))
                .ToListAsync();
        }

        public async Task<IEnumerable<DonationDashboardDto>> GetDashboardDonationsAsync(int charityUserId)
        {
            return await _context.Donations
                .Include(d => d.Category)
                .Where(d => d.TargetCharityUserId == charityUserId && d.Status == "Assigned")
                .Select(d => new DonationDashboardDto
                {
                    Id = d.Id,
                    DonorUserId = d.DonorUserId,
                    CategoryId = d.CategoryId,
                    Category = d.Category.Name,
                    Description = d.Description,
                    Quantity = d.Quantity,
                    AvailabilityTime = d.AvailabilityTime,
                    PickupLocation = d.PickupLocation,
                    Status = d.Status,
                    UseAiMatching = d.UseAiMatching,
                    TargetCharityUserId = d.TargetCharityUserId
                })
                .ToListAsync();
        }

        private async Task ValidateDonationRequest(
            int categoryId,
            string description,
            int quantity,
            DateTime availabilityTime,
            string pickupLocation,
            bool useAiMatching,
            int? targetCharityUserId)
        {
            var errors = new List<string>();

            if (!await _context.Categories.AnyAsync(c => c.Id == categoryId && c.IsActive))
                errors.Add("Category must exist and be active");

            if (string.IsNullOrWhiteSpace(description))
                errors.Add("Description is required");

            if (quantity <= 0)
                errors.Add("Quantity must be greater than zero");

            if (availabilityTime <= DateTime.UtcNow)
                errors.Add("AvailabilityTime must be in the future");

            if (string.IsNullOrWhiteSpace(pickupLocation))
                errors.Add("PickupLocation is required");

            if (!useAiMatching)
            {
                if (targetCharityUserId == null)
                {
                    errors.Add("TargetCharityUserId is required when UseAiMatching is false");
                }
                else if (!await _context.Users.AnyAsync(u =>
                             u.Id == targetCharityUserId &&
                             u.Role == "Charity" &&
                             u.IsActive))
                {
                    errors.Add("TargetCharityUserId must belong to an active Charity user");
                }
            }

            if (errors.Count != 0)
                throw new ApiException("Validation failed", StatusCodes.Status400BadRequest, errors);
        }

        private static string NormalizeStatus(string status)
        {
            var value = status.Trim();

            var matchedStatus = DonationStatuses
                .FirstOrDefault(s => s.Equals(value, StringComparison.OrdinalIgnoreCase));

            if (matchedStatus == null)
                throw new ApiException(
                    "Validation failed",
                    StatusCodes.Status400BadRequest,
                    ["Status must be Pending, Assigned, Completed, or Cancelled"]
                );

            return matchedStatus;
        }

        private async Task AddAssignmentNotificationAsync(Donation donation)
        {
            if (!donation.TargetCharityUserId.HasValue)
                return;

            var notification = new Notification
            {
                UserId = donation.TargetCharityUserId.Value,
                DonationId = donation.Id,
                NotificationType = "DonationAssigned",
                Message = "New donation assigned to you",
                IsRead = false,
                CreatedAt = DateTime.UtcNow
            };

            _context.Notifications.Add(notification);
            await _context.SaveChangesAsync();
        }

        private static DonationResponseDto ToResponseDto(Donation d)
        {
            return new DonationResponseDto
            {
                Id = d.Id,
                DonorUserId = d.DonorUserId,
                CategoryId = d.CategoryId,
                Category = d.Category != null ? d.Category.Name : string.Empty,
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
            };
        }
    }
}