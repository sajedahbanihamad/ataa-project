using Ne_mah_Mobile_Application.Model;

namespace Ne_mah_Mobile_Application.modle
{
    public class User
    {
        public int Id { get; set; }
        public string Email { get; set; } = null;
        public string PasswordHash { get; set; } = null;
        public string Role { get; set; } = null;
        public bool AgreeToTerms { get; set; }
        public ICollection<Donation> Donations { get; set; } = new List<Donation>();//To create relationship between Donation and User(1User to many Donation) 
        public ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();//To create relationship between Reservation and User(1User to many Reservation) 


    }
}
