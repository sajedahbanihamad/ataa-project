using Ataa_Mobile_Application.DTOs;

namespace Ataa_Mobile_Application.Services.Interfaces
{
    public interface IAuthService
    {
        Task<AuthResponseDto?> RegisterIndividualDonorAsync(IndividualDonorRegisterDto dto);
        Task<AuthResponseDto?> RegisterBusinessDonorAsync(BusinessDonorRegisterDto dto);
        Task<AuthResponseDto?> RegisterCharityAsync(CharityRegisterDto dto);
        Task<AuthResponseDto?> LoginAsync(LoginDto dto);
    }
}
