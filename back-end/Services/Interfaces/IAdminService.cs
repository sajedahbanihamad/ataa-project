using Ataa_Mobile_Application.DTOs;

namespace Ataa_Mobile_Application.Services.Interfaces
{
    public interface IAdminService
    {
        Task<IEnumerable<UserResponseDto>> GetUsersAsync(string? role = null);
        Task<IEnumerable<DonationResponseDto>> GetDonationsAsync();
        Task<IEnumerable<UserResponseDto>> GetDonorsAsync();
        Task<IEnumerable<ReservationResponseDto>> GetReservationsAsync();
        Task<bool> SetUserActiveAsync(int userId, bool isActive);
        Task<bool> UpdateDonationStatusAsync(int donationId, string status);
        Task<AdminStatsDto> GetStatsAsync();
    }
}
