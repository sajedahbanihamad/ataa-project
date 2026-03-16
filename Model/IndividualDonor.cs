using Ne_mah_Mobile_Application.modle;

namespace Ne_mah_Mobile_Application.Model_Tabels_
{
    public class IndividualDonor
    {
        public int Id { get; set; } // This Attribute (Id) in Charity Table   
        public int UserId { get; set; } // This Attribute (UserId) in User Table
        public string FullName { get; set; } = null;
        public string PhoneNumber { get; set; } = null;
        public bool AgreeDonorConditions { get; set; }

        public User User { get; set; }
    }
}
