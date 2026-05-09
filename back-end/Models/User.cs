using System.ComponentModel.DataAnnotations.Schema;

namespace Ataa_Mobile_Application.Models
{
    public class User
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string PasswordHash { get; set; } = string.Empty;
        public string Role { get; set; } = string.Empty;
        public bool AgreeToTerms { get; set; }
        public bool IsActive { get; set; } = true;
        // ربطنا هاي اللستة مع المتبرع في جدول التبرعات
        [InverseProperty("DonorUser")]
        public ICollection<Donation> Donations { get; set; } = [];
        // ربطنا هاي اللستة مع الجمعية في جدول الحجوزات
        [InverseProperty("CharityUser")]
        public ICollection<Reservation> Reservations { get; set; } = [];
        public ICollection<Notification> Notifications { get; set; } = [];
    }
}
