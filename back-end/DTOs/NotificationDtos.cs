using System.ComponentModel.DataAnnotations;

namespace Ataa_Mobile_Application.DTOs
{
    public class CreateNotificationDto 
    { 
        [Range(1, int.MaxValue)] 
        public int UserId { get; set; } 
        
        public int? DonationId { get; set; } 
        
        public string? NotificationType { get; set; } 
        
        [Required] 
        public string Message { get; set; } = string.Empty; 
    }
    public class NotificationResponseDto 
    { 
        public int Id { get; set; } 
        public int UserId { get; set; } 
        public int? DonationId { get; set; } 
        public string NotificationType { get; set; } = string.Empty; 
        public string Message { get; set; } = string.Empty; 
        public DateTime CreatedAt { get; set; } 
        public bool IsRead { get; set; } 
    }
}

