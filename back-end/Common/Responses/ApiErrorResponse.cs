using Ataa_Mobile_Application.Common.Exceptions;

namespace Ataa_Mobile_Application.Common.Responses
{
    public class ApiErrorResponse
    {
        public bool Success { get; set; } = false;
        public string Message { get; set; } = string.Empty;
        public List<string> Errors { get; set; } = new List<string>();
        public int StatusCode { get; set; }
        // Constructor فاضي ضروري عشان الـ JSON Serialization
        public ApiErrorResponse() { }
        // Constructor بياخد ApiException مباشرة عشان يسهل الشغل بالـ Middleware
        public ApiErrorResponse(ApiException ex)
        {
            Success = false;
            Message = ex.Message;
            StatusCode = ex.StatusCode;
            Errors = ex.Errors ?? [];
        }
    }
}
