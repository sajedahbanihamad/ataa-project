using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Ataa_Mobile_Application.Services.Interfaces;
using Ataa_Mobile_Application.Common.Exceptions;
using System.Security.Claims;

namespace Ataa_Mobile_Application.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class NotificationsController : ControllerBase
    {
        private readonly INotificationService _notificationService;

        public NotificationsController(INotificationService notificationService)
        {
            _notificationService = notificationService;
        }

        [HttpGet("my")]
        public async Task<IActionResult> GetMyNotifications()
        {
            var result = await _notificationService.GetUserNotificationsAsync(CurrentUserId());
            return Ok(result);
        }

        [HttpPut("read/{notificationId}")]
        public async Task<IActionResult> MarkAsRead(int notificationId)
        {
            var result = await _notificationService.MarkAsReadAsync(notificationId, CurrentUserId());

            if (!result)
                return NotFound(new { message = "Notification not found or not yours" });

            return Ok(new { message = "Notification marked as read" });
        }

        [HttpGet("my/unread")]
        public async Task<IActionResult> GetMyUnreadNotifications()
        {
            var result = await _notificationService.GetUnreadNotificationsAsync(CurrentUserId());
            return Ok(result);
        }

        // التعديل: حماية استخراج الـ ID من الـ Crash
        private int CurrentUserId()
        {
            var claim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (int.TryParse(claim, out int userId))
            {
                return userId;
            }
            
            // الـ Middleware رح يمسك هاد الإيرور ويرجعه كـ 401 بدل ما يوقع التطبيق
            throw new ApiException("Invalid or missing User ID in token.", 401);
        }
    }
}
