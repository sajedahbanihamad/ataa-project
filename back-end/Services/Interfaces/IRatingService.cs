using Ataa_Mobile_Application.DTOs;

namespace Ataa_Mobile_Application.Services.Interfaces
{
    public interface IRatingService
    {
        Task<RatingResponseDto?> CreateAsync(CreateRatingDto dto, int charityUserId);
        Task<IEnumerable<RatingResponseDto>> GetByDonorUserIdAsync(int donorUserId);
    }
}
