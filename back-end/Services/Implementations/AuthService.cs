using Ataa_Mobile_Application.Common.Exceptions;
using Ataa_Mobile_Application.Data;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Models;
using Ataa_Mobile_Application.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Text.RegularExpressions;

namespace Ataa_Mobile_Application.Services.Implementations
{
    public class AuthService(AppDbContext context, IConfiguration configuration) : IAuthService
    {
        private readonly AppDbContext _context = context;
        private readonly IConfiguration _configuration = configuration;
        private static readonly string[] AllowedRoles = ["Admin", "IndividualDonor", "BusinessDonor", "Charity"];

        public async Task<AuthResponseDto?> RegisterIndividualDonorAsync(IndividualDonorRegisterDto dto)
        {
            if (!dto.AgreeDonorConditions)
                throw new ApiException("Validation failed", StatusCodes.Status400BadRequest, ["You must agree to donor conditions"]);

            var email = NormalizeEmail(dto.Email);
            await EnsureEmailIsUniqueAsync(email);

            using var transaction = await _context.Database.BeginTransactionAsync();

            var user = new User
            {
                Name = dto.FullName.Trim(),
                Email = email,
                PasswordHash = BCrypt.Net.BCrypt.HashPassword(dto.Password),
                Role = "IndividualDonor",
                AgreeToTerms = true,
                IsActive = true
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            var individualDonor = new IndividualDonor
            {
                UserId = user.Id,
                FullName = dto.FullName.Trim(),
                PhoneNumber = dto.PhoneNumber.Trim(),
                AgreeDonorConditions = dto.AgreeDonorConditions
            };

            _context.IndividualDonors.Add(individualDonor);
            await _context.SaveChangesAsync();
            await transaction.CommitAsync();

            return ToAuthResponse(user);
        }

        public async Task<AuthResponseDto?> RegisterBusinessDonorAsync(BusinessDonorRegisterDto dto)
        {
            var email = NormalizeEmail(dto.Email);
            await EnsureEmailIsUniqueAsync(email);

            using var transaction = await _context.Database.BeginTransactionAsync();

            var user = new User
            {
                Name = dto.BusinessName.Trim(),
                Email = email,
                PasswordHash = BCrypt.Net.BCrypt.HashPassword(dto.Password),
                Role = "BusinessDonor",
                AgreeToTerms = true,
                IsActive = true
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            var businessDonor = new BusinessDonor
            {
                UserId = user.Id,
                BusinessName = dto.BusinessName.Trim(),
                ContactPerson = dto.ContactPerson.Trim(),
                ContactPhone = dto.ContactPhone.Trim(),
                OfficeAddress = dto.OfficeAddress.Trim(),
                IdNumber = dto.IdNumber.Trim() // 🔥 هذا هو الإصلاح
            };

            _context.BusinessDonors.Add(businessDonor);
            await _context.SaveChangesAsync();

            await transaction.CommitAsync();

            return ToAuthResponse(user);
        }

        public async Task<AuthResponseDto?> RegisterCharityAsync(CharityRegisterDto dto)
        {
            if (!Regex.IsMatch(dto.IdNumber.Trim(), @"^\d{10}$"))
                throw new ApiException(
                    "Validation failed",
                    StatusCodes.Status400BadRequest,
                    ["The ID number must consist of 10 digits."]
                );
            var email = NormalizeEmail(dto.Email);
            await EnsureEmailIsUniqueAsync(email);

            using var transaction = await _context.Database.BeginTransactionAsync();

            var user = new User
            {
                Name = dto.OrganizationName.Trim(),
                Email = email,
                PasswordHash = BCrypt.Net.BCrypt.HashPassword(dto.Password),
                Role = "Charity",
                AgreeToTerms = true,
                IsActive = true
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            var charity = new Charity
            {
                UserId = user.Id,
                OrganizationName = dto.OrganizationName.Trim(),
                ContactPerson = dto.ContactPerson.Trim(),
                ContactPhone = dto.ContactPhone.Trim(),
                OfficeAddress = dto.OfficeAddress.Trim(),
                IdNumber = dto.IdNumber.Trim()
            };

            _context.Charities.Add(charity);
            await _context.SaveChangesAsync();
            await transaction.CommitAsync();

            return ToAuthResponse(user);
        }

        public async Task<AuthResponseDto?> LoginAsync(LoginDto dto)
        {
            var email = NormalizeEmail(dto.Email);

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == email);
            if (user == null || !user.IsActive || !BCrypt.Net.BCrypt.Verify(dto.Password, user.PasswordHash))
                throw new ApiException("Invalid email or password", StatusCodes.Status401Unauthorized);

            return ToAuthResponse(user);
        }

        private async Task EnsureEmailIsUniqueAsync(string email)
        {
            var existingUser = await _context.Users.AnyAsync(u => u.Email == email);
            if (existingUser)
                throw new ApiException("Validation failed", StatusCodes.Status400BadRequest, ["Email already exists"]);
        }

        private static string NormalizeEmail(string email)
        {
            return email.Trim().ToLower();
        }

        private AuthResponseDto ToAuthResponse(User user)
        {
            return new AuthResponseDto
            {
                Token = GenerateJwtToken(user),
                UserId = user.Id,
                Name = user.Name,
                Email = user.Email,
                Role = user.Role
            };
        }

        private string GenerateJwtToken(User user)
        {
            var keyValue = _configuration["Jwt:Key"];
            if (string.IsNullOrWhiteSpace(keyValue))
                throw new ApiException("JWT configuration is missing", StatusCodes.Status500InternalServerError);

            var claims = new List<Claim>
            {
                new(ClaimTypes.NameIdentifier, user.Id.ToString()),
                new(ClaimTypes.Name, user.Name ?? string.Empty),
                new(ClaimTypes.Email, user.Email),
                new(ClaimTypes.Role, user.Role)
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(keyValue));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var duration = double.TryParse(_configuration["Jwt:DurationInMinutes"], out var minutes) ? minutes : 120;

            var token = new JwtSecurityToken(
                issuer: _configuration["Jwt:Issuer"],
                audience: _configuration["Jwt:Audience"],
                claims: claims,
                expires: DateTime.UtcNow.AddMinutes(duration),
                signingCredentials: creds
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        private static string NormalizeRole(string role)
        {
            role = role.Trim();

            return role.ToLower() switch
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
