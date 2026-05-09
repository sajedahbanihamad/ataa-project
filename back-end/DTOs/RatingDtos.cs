using System.ComponentModel.DataAnnotations;

namespace Ataa_Mobile_Application.DTOs
{
    public class CreateRatingDto 
    { 
        [Range(1, int.MaxValue)] 
        public int ReservationId { get; set; } 
        
        [Range(1, 5)] 
        public int Score { get; set; } 
        
        public string? Comment { get; set; } 
    }

    public class RatingResponseDto 
    { 
        public int Id { get; set; } 
        public int ReservationId { get; set; } 
        public int DonorUserId { get; set; } 
        public int CharityUserId { get; set; } 
        public int Score { get; set; } 
        public string Stars { get; set; } = string.Empty; 
        public string? Comment { get; set; } 
        public DateTime CreatedAt { get; set; } 
    }
}
