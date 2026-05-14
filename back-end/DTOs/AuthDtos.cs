using System.ComponentModel.DataAnnotations;

namespace Ataa_Mobile_Application.DTOs
{
    public class RegisterDto
    {
        [Required, StringLength(100)] public string Name { get; set; } = string.Empty;
        [Required, EmailAddress] public string Email { get; set; } = string.Empty;
        [Required, MinLength(8)] public string Password { get; set; } = string.Empty;
        [Required]
        [RegularExpression(@"^(Admin|IndividualDonor|BusinessDonor|Charity)$", ErrorMessage = "Role must be Admin, IndividualDonor, BusinessDonor, or Charity")]
        public string Role { get; set; } = string.Empty;
        public bool AgreeToTerms { get; set; } = true;
    }

    public class LoginDto
    {
        [Required, EmailAddress] public string Email { get; set; } = string.Empty;
        [Required] public string Password { get; set; } = string.Empty;
    }

    public class AuthResponseDto
    {
        public bool Success { get; set; }
        public string Message { get; set; } = string.Empty;
        public string Token { get; set; } = string.Empty;
        public int UserId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Role { get; set; } = string.Empty;
    }

    public class IndividualDonorRegisterDto
    {
        [Required, StringLength(100)] public string FullName { get; set; } = string.Empty;
        [Required, EmailAddress] public string Email { get; set; } = string.Empty;
        [Required, MinLength(8)] public string Password { get; set; } = string.Empty;
        [Required, RegularExpression(@"^\+?[0-9]{9,15}$", ErrorMessage = "PhoneNumber must contain 9 to 15 digits and may start with +")]
        public string PhoneNumber { get; set; } = string.Empty;
        [Required] public bool AgreeDonorConditions { get; set; }
    }

    public class BusinessDonorRegisterDto
    {
        [Required, StringLength(100)] public string BusinessName { get; set; } = string.Empty;
        [Required, StringLength(100)] public string ContactPerson { get; set; } = string.Empty;
        [Required, EmailAddress] public string Email { get; set; } = string.Empty;
        [Required, MinLength(8)] public string Password { get; set; } = string.Empty;
        [Required, RegularExpression(@"^\+?[0-9]{9,15}$", ErrorMessage = "ContactPhone must contain 9 to 15 digits and may start with +")]
        public string ContactPhone { get; set; } = string.Empty;
        [Required, StringLength(200)] public string OfficeAddress { get; set; } = string.Empty;
        [Required, StringLength(10, MinimumLength = 10), RegularExpression(@"^\d{10}$", ErrorMessage = "IdNumber must be exactly 10 digits")]
        public string IdNumber { get; set; } = string.Empty;
    }

    public class CharityRegisterDto
    {
        [Required, StringLength(100)] public string OrganizationName { get; set; } = string.Empty;
        [Required, StringLength(100)] public string ContactPerson { get; set; } = string.Empty;
        [Required, EmailAddress] public string Email { get; set; } = string.Empty;
        [Required, MinLength(8)] public string Password { get; set; } = string.Empty;
        [Required, RegularExpression(@"^\+?[0-9]{9,15}$", ErrorMessage = "ContactPhone must contain 9 to 15 digits and may start with +")]
        public string ContactPhone { get; set; } = string.Empty;
        [Required, StringLength(200)] public string OfficeAddress { get; set; } = string.Empty;
        [Required, StringLength(10, MinimumLength = 10), RegularExpression(@"^\d{10}$", ErrorMessage = "IdNumber must be exactly 10 digits")]
        public string IdNumber { get; set; } = string.Empty;
    }
}
