using Microsoft.EntityFrameworkCore;
using Ataa_Mobile_Application.Common.Exceptions;
using Ataa_Mobile_Application.Data;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Models;
using Ataa_Mobile_Application.Services.Interfaces;

namespace Ataa_Mobile_Application.Services.Implementations
{
    public class ReservationService(AppDbContext context) : IReservationService
    {
        private readonly AppDbContext _context = context;
        private IQueryable<ReservationResponseDto> ReservationMap => 
            _context.Reservations.Select(r => new ReservationResponseDto
            {
                Id = r.Id,
                DonationId = r.DonationId,
                CharityUserId = r.CharityUserId,
                ReservationDate = r.ReservationDate,
                Status = r.Status
            });
        public async Task<IEnumerable<ReservationResponseDto>> GetAllAsync(int charityUserId)
        {
            return await ReservationMap
                .Where(r => r.CharityUserId == charityUserId)
                .ToListAsync();
        }

        public async Task<ReservationResponseDto?> GetByIdAsync(int id, int charityUserId)
        {
            var reservation = await ReservationMap
                .FirstOrDefaultAsync(r => r.Id == id && r.CharityUserId == charityUserId) ?? throw new ApiException("Reservation not found", StatusCodes.Status404NotFound);
            return reservation;
        }

        public async Task<ReservationResponseDto?> CreateAsync(CreateReservationDto dto, int charityUserId)
        {
            if (!await _context.Users.AnyAsync(u => u.Id == charityUserId && u.Role == "Charity"))
                throw new ApiException("Only charities can reserve donations", StatusCodes.Status403Forbidden);

            var donation = await _context.Donations.FindAsync(dto.DonationId) ?? throw new ApiException("Donation not found", StatusCodes.Status404NotFound);
            if (donation.Status != "Assigned")
                throw new ApiException("Donation is not available for reservation", StatusCodes.Status400BadRequest);

            if (donation.TargetCharityUserId != charityUserId)
                throw new ApiException("This donation is not assigned to your charity", StatusCodes.Status403Forbidden);

            if (await _context.Reservations.AnyAsync(r => r.DonationId == dto.DonationId))
                throw new ApiException("Donation already has a reservation", StatusCodes.Status400BadRequest);

            var reservation = new Reservation
            {
                DonationId = dto.DonationId,
                CharityUserId = charityUserId,
                ReservationDate = DateTime.UtcNow,
                Status = "Reserved" 
            };

            _context.Reservations.Add(reservation);
            await _context.SaveChangesAsync();

            return await ReservationMap.FirstOrDefaultAsync(r => r.Id == reservation.Id);
        }

        public async Task<bool> ConfirmReceiptAsync(int reservationId, int charityUserId)
        {
            var reservation = await _context.Reservations
                .Include(r => r.Donation)
                .FirstOrDefaultAsync(r => r.Id == reservationId && r.CharityUserId == charityUserId);

            if (reservation == null || reservation.Donation == null)
                throw new ApiException("Reservation not found", StatusCodes.Status404NotFound);

            if (reservation.Status == "Completed")
                throw new ApiException("Reservation is already completed", StatusCodes.Status400BadRequest);

            reservation.Status = "Completed";
            reservation.Donation.Status = "Completed";

            await _context.SaveChangesAsync();
            return true;
        }
    }
}
