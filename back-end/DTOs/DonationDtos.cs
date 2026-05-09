using System.ComponentModel.DataAnnotations;

namespace Ataa_Mobile_Application.DTOs
{
    public class CreateDonationDto
    {
        [Range(1, int.MaxValue, ErrorMessage = "CategoryId is required")] public int CategoryId { get; set; }
        [Required, StringLength(500)] public string Description { get; set; } = string.Empty;
        [Range(1, int.MaxValue, ErrorMessage = "Quantity must be greater than zero")] public int Quantity { get; set; }
        [Required] public DateTime AvailabilityTime { get; set; }
        [Required, StringLength(200)] public string PickupLocation { get; set; } = string.Empty;
        [Range(-90, 90)] public double Latitude { get; set; }
        [Range(-180, 180)] public double Longitude { get; set; }
        public bool UseAiMatching { get; set; }
        public int? TargetCharityUserId { get; set; }
    }

    public class UpdateDonationDto : CreateDonationDto { }

    public class DonationFilterDto
    {
        public int? CategoryId { get; set; }
        public string? Category { get; set; }
        public string? Location { get; set; }
        public DateTime? AvailabilityTime { get; set; }
        [RegularExpression(@"^(Pending|Assigned|Completed)$", ErrorMessage = "Status must be Pending, Assigned, or Completed")]
        public string? Status { get; set; }
    }

    public class UpdateDonationStatusDto
    {
        [Required]
        [RegularExpression(@"^(Pending|Assigned|Completed)$", ErrorMessage = "Status must be Pending, Assigned, or Completed")]
        public string Status { get; set; } = string.Empty;
    }

    public class DonationResponseDto
    {
        public int Id { get; set; }
        public int DonorUserId { get; set; }
        public int CategoryId { get; set; }
        public string Category { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public int Quantity { get; set; }
        public DateTime AvailabilityTime { get; set; }
        public string PickupLocation { get; set; } = string.Empty;
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string Status { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; }
        public bool UseAiMatching { get; set; }
        public int? TargetCharityUserId { get; set; }
    }
}
