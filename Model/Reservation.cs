using Ne_mah_Mobile_Application.modle;

namespace Ne_mah_Mobile_Application.Model
{
    public class Reservation
    {
        public int Id { get; set; }

        public int DonationId { get; set; }

        public int CharityUserId { get; set; }

        public DateTime ReservationDate { get; set; }

        public string Status { get; set; } = null!;

        public Donation Donation { get; set; } = null!;

        public User CharityUser { get; set; } = null!;
    }
}