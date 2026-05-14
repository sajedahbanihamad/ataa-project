namespace Ataa_Mobile_Application.Common.Exceptions
{
    public class ApiException : Exception
    {
        public int StatusCode { get; }
        public List<string>? Errors { get; }

        public ApiException(string message, int statusCode, List<string>? errors = null) : base(message)
        {
            StatusCode = statusCode;
            Errors = errors ?? [];
        }
    }
}
