using Ataa_Mobile_Application.DTOs;

namespace Ataa_Mobile_Application.Services.Interfaces
{
    public interface IUserService
    {
        Task<IEnumerable<UserResponseDto>> GetAllAsync();
        Task<UserResponseDto?> GetByIdAsync(int id);
        Task<UserResponseDto> CreateAsync(CreateUserDto dto);
        Task<bool> UpdateAsync(int id, UpdateUserDto dto);
        Task<bool> DeleteAsync(int id);
        Task<ProfileResponseDto?> GetProfileAsync(int userId);
    }
}