namespace Ataa_Mobile_Application.Models
{
    public class Donation
    {
        public int Id { get; set; }
        public int DonorUserId { get; set; }
        public int CategoryId { get; set; }
        public string Description { get; set; } = string.Empty;
        public int Quantity { get; set; }
        public DateTime AvailabilityTime { get; set; }
        public string PickupLocation { get; set; } = string.Empty;
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string Status { get; set; } = "Pending";
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public bool UseAiMatching { get; set; }
        public int? TargetCharityUserId { get; set; }

        public User DonorUser { get; set; } = null!;
        public User? TargetCharityUser { get; set; }
        public Category Category { get; set; } = null!;
        public Reservation? Reservation { get; set; }
        public ICollection<Notification> Notifications { get; set; } = [];
    }
}
