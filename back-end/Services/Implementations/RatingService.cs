using Microsoft.EntityFrameworkCore;
using Ataa_Mobile_Application.Common.Exceptions;
using Ataa_Mobile_Application.Data;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Services.Interfaces;
using Ataa_Mobile_Application.Models;

namespace Ataa_Mobile_Application.Services.Implementations
{
    public class RatingService(AppDbContext context) : IRatingService
    {
        private readonly AppDbContext _context = context;
        private IQueryable<RatingResponseDto> RatingMap => 
            _context.Ratings.Select(r => new RatingResponseDto
            {
                Id = r.Id,
                ReservationId = r.ReservationId,
                DonorUserId = r.DonorUserId,
                CharityUserId = r.CharityUserId,
                Score = r.Score,
                Stars = r.Score == 1 ? "⭐☆☆☆☆" :
                        r.Score == 2 ? "⭐⭐☆☆☆" :
                        r.Score == 3 ? "⭐⭐⭐☆☆" :
                        r.Score == 4 ? "⭐⭐⭐⭐☆" :
                        r.Score == 5 ? "⭐⭐⭐⭐⭐" : "☆☆☆☆☆",
                Comment = r.Comment,
                CreatedAt = r.CreatedAt
            });
        public async Task<RatingResponseDto?> CreateAsync(CreateRatingDto dto, int charityUserId)
        {
            if (dto.Score < 1 || dto.Score > 5)
                throw new ApiException("Score must be between 1 and 5", StatusCodes.Status400BadRequest);

            var reservation = await _context.Reservations
                .Include(r => r.Donation)
                .FirstOrDefaultAsync(r => r.Id == dto.ReservationId && r.CharityUserId == charityUserId);

            if (reservation == null || reservation.Donation == null)
                throw new ApiException("Reservation not found", StatusCodes.Status404NotFound);

            if (reservation.Status != "Completed" || reservation.Donation.Status != "Completed")
                throw new ApiException("Donation and reservation must be completed before rating", StatusCodes.Status400BadRequest);

            if (reservation.Donation.TargetCharityUserId != charityUserId)
                throw new ApiException("Forbidden: You are not assigned to this donation", StatusCodes.Status403Forbidden);

            if (await _context.Ratings.AnyAsync(r => r.ReservationId == dto.ReservationId))
                throw new ApiException("This reservation has already been rated", StatusCodes.Status400BadRequest);

            var rating = new Rating
            {
                ReservationId = dto.ReservationId,
                DonorUserId = reservation.Donation.DonorUserId,
                CharityUserId = charityUserId,
                Score = dto.Score,
                Comment = dto.Comment?.Trim(),
                CreatedAt = DateTime.UtcNow
            };

            _context.Ratings.Add(rating);
            await _context.SaveChangesAsync();

            return await RatingMap.FirstOrDefaultAsync(r => r.Id == rating.Id);
        }

        public async Task<IEnumerable<RatingResponseDto>> GetByDonorUserIdAsync(int donorUserId)
        {
            var donorExists = await _context.Users.AnyAsync(u => u.Id == donorUserId);
            if (!donorExists)
                throw new ApiException("Donor not found", StatusCodes.Status404NotFound);

            return await RatingMap
                .Where(r => r.DonorUserId == donorUserId)
                .ToListAsync();
        }
    }
}
