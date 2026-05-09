using Ataa_Mobile_Application.DTOs;

namespace Ataa_Mobile_Application.Services.Interfaces
{
    public interface INotificationService
    {
        Task<IEnumerable<NotificationResponseDto>> GetUserNotificationsAsync(int userId);
        Task<bool> CreateNotificationAsync(CreateNotificationDto dto);
        Task<bool> MarkAsReadAsync(int notificationId, int userId);
        Task<IEnumerable<NotificationResponseDto>> GetUnreadNotificationsAsync(int userId);
    }
}
