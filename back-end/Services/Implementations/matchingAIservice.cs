using System;
using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Services.Interfaces;
using Microsoft.Extensions.Logging;

namespace Ataa_Mobile_Application.Services.Implementations
{
    public class AiMatchingService : IAiMatchingService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<AiMatchingService> _logger;

        public AiMatchingService(HttpClient httpClient, ILogger<AiMatchingService> logger)
        {
            _httpClient = httpClient;
            _logger = logger;
        }

        public async Task<MatchResponseDto?> GetBestMatchAsync(MatchRequestDto request)
        {
            try
            {
                var response = await _httpClient.PostAsJsonAsync(
                    "http://127.0.0.1:5000/match",
                    request
                );

                var content = await response.Content.ReadAsStringAsync();

                _logger.LogInformation("AI Response Status: {StatusCode}", response.StatusCode);
                _logger.LogInformation("AI Response Body: {Content}", content);

                if (!response.IsSuccessStatusCode)
                    return null;

                return await response.Content.ReadFromJsonAsync<MatchResponseDto>();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error connecting to AI Matching API");
                return null;
            }
        }
    }
}