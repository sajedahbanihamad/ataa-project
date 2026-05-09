namespace Ataa_Mobile_Application.DTOs
{
    public class DonationDashboardDto
    {
        public int Id { get; set; }
        public int DonorUserId { get; set; }
        public int CategoryId { get; set; }
        public string Category { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public int Quantity { get; set; }
        public DateTime AvailabilityTime { get; set; }
        public string PickupLocation { get; set; } = string.Empty;
        public string Status { get; set; } = string.Empty;
        public bool UseAiMatching { get; set; }
        public int? TargetCharityUserId { get; set; }
    }
}
