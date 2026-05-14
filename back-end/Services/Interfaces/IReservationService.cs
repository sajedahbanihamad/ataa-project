using Ataa_Mobile_Application.DTOs;

namespace Ataa_Mobile_Application.Services.Interfaces
{
    public interface IReservationService
    {
        Task<IEnumerable<ReservationResponseDto>> GetAllAsync(int charityUserId);
        Task<ReservationResponseDto?> GetByIdAsync(int id, int charityUserId);
        Task<ReservationResponseDto?> CreateAsync(CreateReservationDto dto, int charityUserId);
        Task<bool> ConfirmReceiptAsync(int reservationId, int charityUserId);
    }
}
