using Ataa_Mobile_Application.DTOs;

namespace Ataa_Mobile_Application.Services.Interfaces
{
    public interface IAiMatchingService
    {
        Task<MatchResponseDto?> GetBestMatchAsync(MatchRequestDto request);
    }
}