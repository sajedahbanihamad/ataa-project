namespace Ataa_Mobile_Application.Models
{
    public class Reservation
    {
        public int Id { get; set; }
        public int DonationId { get; set; }
        public int CharityUserId { get; set; }
        public DateTime ReservationDate { get; set; } = DateTime.UtcNow;
        public string Status { get; set; } = "Assigned";
        public Donation Donation { get; set; } = null!;
        public User CharityUser { get; set; } = null!;
    }
}
