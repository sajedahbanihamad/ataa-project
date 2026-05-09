namespace Ataa_Mobile_Application.Models
{
    public class Rating
    {
        public int Id { get; set; }
        public int ReservationId { get; set; }
        public int DonorUserId { get; set; }
        public int CharityUserId { get; set; }
        public int Score { get; set; }
        public string? Comment { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public Reservation Reservation { get; set; } = null!;
        public User DonorUser { get; set; } = null!;
        public User CharityUser { get; set; } = null!;
    }
}
