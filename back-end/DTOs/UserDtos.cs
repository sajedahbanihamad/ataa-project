using System.ComponentModel.DataAnnotations;

namespace Ataa_Mobile_Application.DTOs
{
    public class CreateUserDto 
    { 
        [Required] 
        public string Name { get; set; } = string.Empty; 
        
        [Required, EmailAddress] 
        public string Email { get; set; } = string.Empty; 
        
        [Required, MinLength(8)] 
        public string Password { get; set; } = string.Empty; 
        
        [Required] 
        public string Role { get; set; } = string.Empty; 
        
        public bool AgreeToTerms { get; set; } = true; 
    }

    public class UpdateUserDto 
    { 
        [Required] 
        public string Name { get; set; } = string.Empty; 
        
        [Required, EmailAddress] 
        public string Email { get; set; } = string.Empty; 
        
        [Required] 
        public string Role { get; set; } = string.Empty; 
        
        public bool AgreeToTerms { get; set; } = true; 
        
        public bool IsActive { get; set; } = true; 
    }

    public class UserResponseDto 
    { 
        public int Id { get; set; } 
        public string Name { get; set; } = string.Empty; 
        public string Email { get; set; } = string.Empty; 
        public string Role { get; set; } = string.Empty; 
        public bool AgreeToTerms { get; set; } 
        public bool IsActive { get; set; } 
    }

    public class ProfileResponseDto 
    { 
        public int UserId { get; set; } 
        public string Email { get; set; } = string.Empty; 
        public string Role { get; set; } = string.Empty; 
        public int MealsDonated { get; set; } 
        public int FoodSaved { get; set; } 
        public double Rating { get; set; } 
        public int TotalRatings { get; set; } 
    }
}
