using System.ComponentModel.DataAnnotations;

namespace Ataa_Mobile_Application.Models
{
    public class BusinessDonor
    {
        public int Id { get; set; } // This Attribute (Id) in BusinessDonor Table   
        public int UserId { get; set; } // This Attribute (UserId) in User Table
        public string BusinessName { get; set; } = string.Empty;
        public string ContactPerson { get; set; } = string.Empty;

        [RegularExpression(@"^(\+962|0)?7[789]\d{7}$", ErrorMessage = "Please enter a valid Jordanian phone number")]
        public string ContactPhone { get; set; } = string.Empty;

        public string OfficeAddress { get; set; } = string.Empty;
        public string IdNumber { get; set; } = string.Empty;

        public User User { get; set; } = null!;
    }
}
