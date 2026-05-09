using Ataa_Mobile_Application.DTOs;

namespace Ataa_Mobile_Application.Services.Interfaces
{
    public interface ICategoryService
    {
        Task<IEnumerable<CategoryResponseDto>> GetAllAsync(bool includeInactive = false);
        Task<CategoryResponseDto?> GetByIdAsync(int id);
        Task<CategoryResponseDto> CreateAsync(CreateCategoryDto dto);
        Task<CategoryResponseDto> UpdateAsync(int id, UpdateCategoryDto dto);
        Task<bool> SetActiveAsync(int id, bool isActive);
        Task<bool> DeleteAsync(int id);
    }
}
