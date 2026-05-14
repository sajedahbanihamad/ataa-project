using System.Text.Json;
using Ataa_Mobile_Application.Common.Exceptions;
using Ataa_Mobile_Application.Common.Responses;

namespace Ataa_Mobile_Application.Middleware
{
    public class ExceptionMiddleware(RequestDelegate next, ILogger<ExceptionMiddleware> logger, IWebHostEnvironment environment)
    {
        private static readonly JsonSerializerOptions _jsonOptions = new JsonSerializerOptions 
        { 
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase 
        };

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await next(context);
            }
            catch (ApiException ex)
            {
                await WriteErrorAsync(context, ex.StatusCode, ex.Message, ex.Errors);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Unhandled API exception");

                var errors = environment.IsDevelopment()
                    ? new List<string> { ex.Message, ex.InnerException?.Message ?? string.Empty }.Where(e => !string.IsNullOrWhiteSpace(e)).ToList()
                    : null;

                await WriteErrorAsync(context, StatusCodes.Status500InternalServerError, "Internal server error", errors);
            }
        }

        private static async Task WriteErrorAsync(HttpContext context, int statusCode, string message, List<string>? errors = null)
        {
            if (context.Response.HasStarted)
                return;

            context.Response.ContentType = "application/json";
            context.Response.StatusCode = statusCode;

            var response = new ApiErrorResponse
            {
                Success = false,
                Message = message,
                Errors = errors ?? [],
                StatusCode = statusCode
            };

            await context.Response.WriteAsync(JsonSerializer.Serialize(response, _jsonOptions));
        }
    }
}
