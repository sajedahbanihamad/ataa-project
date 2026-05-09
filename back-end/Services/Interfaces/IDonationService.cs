using Ataa_Mobile_Application.DTOs;

namespace Ataa_Mobile_Application.Services.Interfaces
{
    public interface IDonationService
    {
        Task<IEnumerable<DonationResponseDto>> GetAllAsync();
        Task<DonationResponseDto?> GetByIdAsync(int id, int currentUserId, string role);
        Task<IEnumerable<DonationResponseDto>> GetByCurrentDonorAsync(int donorUserId);
        Task<DonationResponseDto?> CreateAsync(CreateDonationDto dto, int donorUserId);
        Task<bool> UpdateAsync(int id, UpdateDonationDto dto, int donorUserId);
        Task<bool> CancelAsync(int id, int donorUserId);
        Task<IEnumerable<DonationResponseDto>> FilterDonationsAsync(DonationFilterDto filter, int currentUserId, string role);
        Task<IEnumerable<DonationDashboardDto>> GetDashboardDonationsAsync(int charityUserId);
    }
}
