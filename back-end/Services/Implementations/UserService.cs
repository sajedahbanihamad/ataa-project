using Microsoft.EntityFrameworkCore;
using Ataa_Mobile_Application.Common.Exceptions;
using Ataa_Mobile_Application.Data;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Services.Interfaces;
using Ataa_Mobile_Application.Models;

namespace Ataa_Mobile_Application.Services.Implementations
{
    public class UserService(AppDbContext context) : IUserService
    {
        private readonly AppDbContext _context = context;
        private static readonly string[] AllowedRoles = { "IndividualDonor", "BusinessDonor", "Charity", "Admin" };
        private IQueryable<UserResponseDto> UserMap => 
            _context.Users.Select(u => new UserResponseDto
            {
                Id = u.Id,
                Name = u.Name,
                Email = u.Email,
                Role = u.Role,
                AgreeToTerms = u.AgreeToTerms,
                IsActive = u.IsActive
            });
        public async Task<IEnumerable<UserResponseDto>> GetAllAsync()
        {
            return await UserMap.ToListAsync();
        }

        public async Task<UserResponseDto?> GetByIdAsync(int id)
        {
            var user = await UserMap.FirstOrDefaultAsync(u => u.Id == id) ?? throw new ApiException("User not found", StatusCodes.Status404NotFound);
            return user;
        }

        public async Task<UserResponseDto> CreateAsync(CreateUserDto dto)
        {
            var role = NormalizeRole(dto.Role);
            if (!AllowedRoles.Contains(role))
                throw new ApiException("Role is invalid", StatusCodes.Status400BadRequest);

            var email = dto.Email.Trim().ToLower();
            if (await _context.Users.AnyAsync(u => u.Email == email))
                throw new ApiException("Email already exists", StatusCodes.Status400BadRequest);

            var user = new User
            {
                Name = dto.Name.Trim(),
                Email = email,
                PasswordHash = BCrypt.Net.BCrypt.HashPassword(dto.Password),
                Role = role,
                AgreeToTerms = dto.AgreeToTerms,
                IsActive = true
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return await UserMap.FirstAsync(u => u.Id == user.Id);
        }

        public async Task<bool> UpdateAsync(int id, UpdateUserDto dto)
        {
            var user = await _context.Users.FindAsync(id) ?? throw new ApiException("User not found", StatusCodes.Status404NotFound);
            var role = NormalizeRole(dto.Role);
            if (!AllowedRoles.Contains(role))
                throw new ApiException("Role is invalid", StatusCodes.Status400BadRequest);

            var email = dto.Email.Trim().ToLower();
            if (await _context.Users.AnyAsync(u => u.Email == email && u.Id != id))
                throw new ApiException("Email already exists", StatusCodes.Status400BadRequest);

            user.Name = dto.Name.Trim();
            user.Email = email;
            user.Role = role;
            user.AgreeToTerms = dto.AgreeToTerms;
            user.IsActive = dto.IsActive;

            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> DeleteAsync(int id)
        {
            var affectedRows = await _context.Users.Where(u => u.Id == id).ExecuteDeleteAsync();
            
            if (affectedRows == 0)
                throw new ApiException("User not found", StatusCodes.Status404NotFound);

            return true;
        }

        public async Task<ProfileResponseDto?> GetProfileAsync(int userId)
        {
            var userProfile = await _context.Users
                .Where(u => u.Id == userId)
                .Select(u => new
                {
                    u.Id,
                    u.Email,
                    u.Role,
                    MealsDonated = _context.Donations.Count(d => d.DonorUserId == userId && d.Status == "Completed"),
                    FoodSaved = _context.Donations.Where(d => d.DonorUserId == userId && d.Status == "Completed").Sum(d => (int?)d.Quantity) ?? 0,
                    TotalRatings = _context.Ratings.Count(r => r.DonorUserId == userId),
                    AverageRating = _context.Ratings.Where(r => r.DonorUserId == userId).Average(r => (double?)r.Score) ?? 0
                })
                .FirstOrDefaultAsync() ?? throw new ApiException("User not found", StatusCodes.Status404NotFound);
            return new ProfileResponseDto
            {
                UserId = userProfile.Id,
                Email = userProfile.Email,
                Role = userProfile.Role,
                MealsDonated = userProfile.MealsDonated,
                FoodSaved = userProfile.FoodSaved,
                Rating = Math.Round(userProfile.AverageRating, 2),
                TotalRatings = userProfile.TotalRatings
            };
        }

        private static string NormalizeRole(string role)
        {
            if (string.IsNullOrWhiteSpace(role)) return string.Empty;
            
            role = role.Trim().ToLower();
            return role switch
            {
                "individualdonor" or "individual donor" => "IndividualDonor",
                "businessdonor" or "business donor" => "BusinessDonor",
                "charity" => "Charity",
                "admin" => "Admin",
                _ => role
            };
        }
    }
}
