using Microsoft.EntityFrameworkCore;
using Ataa_Mobile_Application.Common.Exceptions;
using Ataa_Mobile_Application.Data;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Models;
using Ataa_Mobile_Application.Services.Interfaces;

namespace Ataa_Mobile_Application.Services.Implementations
{
    public class NotificationService(AppDbContext context) : INotificationService
    {
        private readonly AppDbContext _context = context;

        private IQueryable<NotificationResponseDto> NotificationProjectedQuery => 
            _context.Notifications.Select(n => new NotificationResponseDto
            {
                Id = n.Id,
                UserId = n.UserId,
                DonationId = n.DonationId,
                NotificationType = n.NotificationType,
                Message = n.Message,
                CreatedAt = n.CreatedAt,
                IsRead = n.IsRead
            });
        public async Task<IEnumerable<NotificationResponseDto>> GetUserNotificationsAsync(int userId)
        {
            return await NotificationProjectedQuery
                .Where(n => n.UserId == userId)
                .OrderByDescending(n => n.CreatedAt)
                .ToListAsync(); // التنفيذ يتم في قاعدة البيانات مباشرة
        }

        public async Task<bool> CreateNotificationAsync(CreateNotificationDto dto)
        {
            if (!await _context.Users.AnyAsync(u => u.Id == dto.UserId))
                throw new ApiException("User not found", StatusCodes.Status404NotFound);

            if (dto.DonationId.HasValue && !await _context.Donations.AnyAsync(d => d.Id == dto.DonationId.Value))
                throw new ApiException("Donation not found", StatusCodes.Status404NotFound);

            var notification = new Notification
            {
                UserId = dto.UserId,
                DonationId = dto.DonationId,
                NotificationType = string.IsNullOrWhiteSpace(dto.NotificationType) ? "General" : dto.NotificationType.Trim(),
                Message = dto.Message?.Trim() ?? throw new ApiException("Message is required", StatusCodes.Status400BadRequest),
                CreatedAt = DateTime.UtcNow,
                IsRead = false
            };

            _context.Notifications.Add(notification);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> MarkAsReadAsync(int notificationId, int userId)
        {
            var affectedRows = await _context.Notifications
                .Where(n => n.Id == notificationId && n.UserId == userId)
                .ExecuteUpdateAsync(s => s.SetProperty(n => n.IsRead, true));

            if (affectedRows == 0)
                throw new ApiException("Notification not found", StatusCodes.Status404NotFound);

            return true;
        }
        public async Task<bool> MarkAllAsReadAsync(int userId)
        {
            await _context.Notifications
                .Where(n => n.UserId == userId && !n.IsRead)
                .ExecuteUpdateAsync(s => s.SetProperty(n => n.IsRead, true));
            
            return true;
        }

        public async Task<IEnumerable<NotificationResponseDto>> GetUnreadNotificationsAsync(int userId)
        {
            return await NotificationProjectedQuery
                .Where(n => n.UserId == userId && !n.IsRead)
                .OrderByDescending(n => n.CreatedAt)
                .ToListAsync();
        }

        private static NotificationResponseDto ToResponseDto(Notification n)
        {
            return new NotificationResponseDto
            {
                Id = n.Id,
                UserId = n.UserId,
                DonationId = n.DonationId,
                NotificationType = n.NotificationType,
                Message = n.Message,
                CreatedAt = n.CreatedAt,
                IsRead = n.IsRead
            };
        }
    }
}
