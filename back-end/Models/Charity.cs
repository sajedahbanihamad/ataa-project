using System.ComponentModel.DataAnnotations;

namespace Ataa_Mobile_Application.Models
{
    public class Charity
    {
        public int Id { get; set; } 
        public int UserId { get; set; }

        public string OrganizationName { get; set; } = string.Empty;
        public string ContactPerson { get; set; } = string.Empty;
        
        [Required(ErrorMessage = "Contact number required")]
        [RegularExpression(@"^(\+962|0)?7[789]\d{7}$", ErrorMessage = "Please enter a valid Jordanian phone number")]
        public string ContactPhone { get; set; } = string.Empty;
        
        public string OfficeAddress { get; set; } = string.Empty;

        [StringLength(10, MinimumLength = 9, ErrorMessage = "IdNumber must be exactly 10 digits")]
        [RegularExpression(@"^\d{10}$", ErrorMessage = "IdNumber must be exactly 10 digits")]
        public string IdNumber { get; set; } = string.Empty;

        public User User { get; set; } = null!;
    }
}
