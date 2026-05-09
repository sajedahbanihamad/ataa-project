using System.ComponentModel.DataAnnotations;

namespace Ataa_Mobile_Application.DTOs
{
    public class CreateCategoryDto
    {
        [Required, StringLength(100)] public string Name { get; set; } = string.Empty;
        [StringLength(300)] public string? Description { get; set; }
        public bool IsActive { get; set; } = true;
    }

    public class UpdateCategoryDto : CreateCategoryDto { }

    public class CategoryResponseDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string? Description { get; set; }
        public bool IsActive { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
