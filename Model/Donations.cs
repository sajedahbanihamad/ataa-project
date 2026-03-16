using Ne_mah_Mobile_Application.modle;

namespace Ne_mah_Mobile_Application.Model
{
    public class Donation
    {
        public int Id { get; set; }

        public int DonorUserId { get; set; }

        public string FoodType { get; set; } = null!;

        public int Quantity { get; set; }

        public DateTime ExpiryDate { get; set; }

        public DateTime PickupTime { get; set; }

        public string PickupLocation { get; set; } = null!;

        public string Status { get; set; } = null!;

        public DateTime CreatedAt { get; set; }

        public User DonorUser { get; set; } = null!;

        public Reservation? Reservation { get; set; }
    }
}