using System.ComponentModel.DataAnnotations;

namespace Ataa_Mobile_Application.Models
{
    public class IndividualDonor
    {
        public int Id { get; set; } 
        public int UserId { get; set; }
        
        public string FullName { get; set; } = string.Empty;
        
        [RegularExpression(@"^(\+962|0)?7[789]\d{7}$", ErrorMessage = "Please enter a valid Jordanian phone number")]
        public string PhoneNumber { get; set; } = string.Empty;
        
        public bool AgreeDonorConditions { get; set; }

        public User User { get; set; } = null!;
    }
}
