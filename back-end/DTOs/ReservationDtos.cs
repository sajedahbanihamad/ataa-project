using System.ComponentModel.DataAnnotations;

namespace Ataa_Mobile_Application.DTOs
{
    public class CreateReservationDto 
    { 
        [Range(1, int.MaxValue)] 
        public int DonationId { get; set; } 
    }

    public class ReservationResponseDto 
    { 
        public int Id { get; set; } 
        public int DonationId { get; set; } 
        public int CharityUserId { get; set; } 
        public DateTime ReservationDate { get; set; } 
        public string Status { get; set; } = string.Empty; 
    }
}
