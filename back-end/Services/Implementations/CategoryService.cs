using Microsoft.EntityFrameworkCore;
using Ataa_Mobile_Application.Common.Exceptions;
using Ataa_Mobile_Application.Data;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Models;
using Ataa_Mobile_Application.Services.Interfaces;

namespace Ataa_Mobile_Application.Services.Implementations
{
    public class CategoryService(AppDbContext context) : ICategoryService
    {
        private readonly AppDbContext _context = context;
        private static readonly string[] AllowedCategories = 
        [
            "food", "clothes", "books", "medicine", 
            "furniture", "electronics", "toys", "others"
        ];

        public async Task<IEnumerable<CategoryResponseDto>> GetAllAsync(bool includeInactive = false)
        {
            var query = _context.Categories.AsQueryable();
            if (!includeInactive) query = query.Where(c => c.IsActive);
            return await query.OrderBy(c => c.Name).Select(c => ToDto(c)).ToListAsync();
        }

        public async Task<CategoryResponseDto?> GetByIdAsync(int id)
        {
            var category = await _context.Categories.FindAsync(id) ?? throw new ApiException("Category not found", StatusCodes.Status404NotFound);
            return ToDto(category);
        }

        public async Task<CategoryResponseDto> CreateAsync(CreateCategoryDto dto)
        {
            var name = dto.Name.Trim();
            var nameLower = name.ToLower();

            // التحقق من أن التصنيف ضمن الفئات المعتمدة
            if (!AllowedCategories.Contains(nameLower))
                throw new ApiException("Invalid category. Allowed categories are: Food, Clothes, Books, Medicine, Furniture, Electronics, Toys, Others.", StatusCodes.Status400BadRequest);

            if (await _context.Categories.AnyAsync(c => c.Name.Equals(nameLower, StringComparison.CurrentCultureIgnoreCase)))
                throw new ApiException("Category already exists", StatusCodes.Status409Conflict);
            
            var category = new Category { Name = name, Description = dto.Description?.Trim(), IsActive = dto.IsActive, CreatedAt = DateTime.UtcNow };
            _context.Categories.Add(category);
            await _context.SaveChangesAsync();
            
            return ToDto(category);
        }

        public async Task<CategoryResponseDto> UpdateAsync(int id, UpdateCategoryDto dto)
        {
            var category = await _context.Categories.FindAsync(id) ?? throw new ApiException("Category not found", StatusCodes.Status404NotFound);
            var name = dto.Name.Trim();
            var nameLower = name.ToLower();

            // التحقق من أن التصنيف الجديد ضمن الفئات المعتمدة
            if (!AllowedCategories.Contains(nameLower))
                throw new ApiException("Invalid category. Allowed categories are: Food, Clothes, Books, Medicine, Furniture, Electronics, Toys, Others.", StatusCodes.Status400BadRequest);

            if (await _context.Categories.AnyAsync(c => c.Name.Equals(nameLower, StringComparison.CurrentCultureIgnoreCase) && c.Id != id))
                throw new ApiException("Category already exists", StatusCodes.Status409Conflict);
            
            category.Name = name;
            category.Description = dto.Description?.Trim();
            category.IsActive = dto.IsActive;
            await _context.SaveChangesAsync();
            
            return ToDto(category);
        }

        public async Task<bool> SetActiveAsync(int id, bool isActive)
        {
            var category = await _context.Categories.FindAsync(id) ?? throw new ApiException("Category not found", StatusCodes.Status404NotFound);
            category.IsActive = isActive;
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> DeleteAsync(int id)
        {
            var category = await _context.Categories.FindAsync(id) ?? throw new ApiException("Category not found", StatusCodes.Status404NotFound);
            if (await _context.Donations.AnyAsync(d => d.CategoryId == id))
                throw new ApiException("Category is used by donations. Deactivate it instead", StatusCodes.Status409Conflict);
            _context.Categories.Remove(category);
            await _context.SaveChangesAsync();
            return true;
        }

        private static CategoryResponseDto ToDto(Category c) => new() { Id = c.Id, Name = c.Name, Description = c.Description, IsActive = c.IsActive, CreatedAt = c.CreatedAt };
    }
}
