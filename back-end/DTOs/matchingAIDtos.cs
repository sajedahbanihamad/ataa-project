using System.Text.Json.Serialization;
using System.Collections.Generic;

namespace Ataa_Mobile_Application.DTOs
{
    // نموذج بيانات الجمعية المرسلة للمطابقة
    public class CharityDataDto
    {
        [JsonPropertyName("charity_id")]
        public int CharityId { get; set; }

        [JsonPropertyName("preferences")]
        public string Preferences { get; set; } = string.Empty;

        [JsonPropertyName("category")]
        public string Category { get; set; } = string.Empty;
    }

    // الطلب الذي سيتم إرساله إلى Python API
    public class MatchRequestDto
    {
        [JsonPropertyName("description")]
        public string Description { get; set; } = string.Empty;

        [JsonPropertyName("category")]
        public string Category { get; set; } = string.Empty;

        [JsonPropertyName("charities")]
        public List<CharityDataDto> Charities { get; set; } = new();
    }

    // تفاصيل نتيجة المطابقة
    public class MatchResultDto
    {
        [JsonPropertyName("charity_id")]
        public int CharityId { get; set; }

        [JsonPropertyName("score")]
        public double Score { get; set; }
    }

    // الرد النهائي القادم من Python API
    public class MatchResponseDto
    {
        [JsonPropertyName("message")]
        public string Message { get; set; } = string.Empty;

        [JsonPropertyName("match")]
        public MatchResultDto? Match { get; set; }
    }
}