using Ne_mah_Mobile_Application.modle;
using System.ComponentModel.DataAnnotations;

namespace Ne_mah_Mobile_Application.Model_Tabels_
{
    public class BusinessDonor
    {
        public int Id { get; set; } // This Attribute (Id) in Charity Table   
        public int UserId { get; set; } // This Attribute (UserId) in User Table
        public string BusinessName { get; set; } = null;
        public string ContactPerson { get; set; } = null;
        public string ContactPhone { get; set; } = null;
        public string OfficeAddress { get; set; } = null;

        [MaxLength(10)]
        public string IdNumber { get; set; } = null;

        public User User { get; set; }
    }
}
