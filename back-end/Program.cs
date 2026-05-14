using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Ataa_Mobile_Application.Common.Responses;
using Ataa_Mobile_Application.Data;
using Ataa_Mobile_Application.Middleware;
using Ataa_Mobile_Application.Models;
using Ataa_Mobile_Application.Services.Implementations;
using Ataa_Mobile_Application.Services.Interfaces;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers()
    .ConfigureApiBehaviorOptions(options =>
    {
        options.InvalidModelStateResponseFactory = context =>
        {
            var errors = context.ModelState
                .Where(x => x.Value?.Errors.Count > 0)
                .SelectMany(x => x.Value!.Errors.Select(e => string.IsNullOrWhiteSpace(e.ErrorMessage)
                    ? $"{x.Key} is invalid"
                    : e.ErrorMessage))
                .Distinct()
                .ToList();

            return new BadRequestObjectResult(new ApiErrorResponse
            {
                Success = false,
                Message = "Validation failed",
                Errors = errors,
                StatusCode = StatusCodes.Status400BadRequest
            });
        };
    });

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddHttpClient<IAiMatchingService, AiMatchingService>();
builder.Services.AddScoped<IDonationService, DonationService>();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IReservationService, ReservationService>();
builder.Services.AddScoped<INotificationService, NotificationService>();
builder.Services.AddScoped<IRatingService, RatingService>();
builder.Services.AddScoped<ICategoryService, CategoryService>();
builder.Services.AddScoped<IAdminService, AdminService>();

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ClockSkew = TimeSpan.Zero,
        ValidIssuer = builder.Configuration["Jwt:Issuer"],
        ValidAudience = builder.Configuration["Jwt:Audience"],
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]!))
    };

    options.Events = new JwtBearerEvents
    {
        OnChallenge = context =>
        {
            context.HandleResponse();
            context.Response.StatusCode = StatusCodes.Status401Unauthorized;
            context.Response.ContentType = "application/json";
            return context.Response.WriteAsJsonAsync(new ApiErrorResponse
            {
                Success = false,
                Message = "Unauthorized",
                StatusCode = StatusCodes.Status401Unauthorized
            });
        },
        OnForbidden = context =>
        {
            context.Response.StatusCode = StatusCodes.Status403Forbidden;
            context.Response.ContentType = "application/json";
            return context.Response.WriteAsJsonAsync(new ApiErrorResponse
            {
                Success = false,
                Message = "Forbidden: you do not have permission to access this resource",
                StatusCode = StatusCodes.Status403Forbidden
            });
        }
    };
});

builder.Services.AddAuthorization();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo { Title = "Ataa API", Version = "v1" });

    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        Scheme = "bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "Paste the JWT token only. Swagger will add Bearer automatically."
    });

    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "Bearer" }
            },
            Array.Empty<string>()
        }
    });
});

var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    db.Database.EnsureCreated();

    if (!db.Categories.Any())
    {
        db.Categories.AddRange(
            new Category { Name = "Food", Description = "Food donations", IsActive = true, CreatedAt = DateTime.UtcNow },
            new Category { Name = "Clothes", Description = "Clothes donations", IsActive = true, CreatedAt = DateTime.UtcNow },
            new Category { Name = "Other", Description = "Other essential items", IsActive = true, CreatedAt = DateTime.UtcNow }
        );
    }

    if (!db.Users.Any(u => u.Role == "Admin"))
    {
        db.Users.Add(new User
        {
            Name = builder.Configuration["DefaultAdmin:Name"] ?? "System Admin",
            Email = (builder.Configuration["DefaultAdmin:Email"] ?? "admin@ataa.com").Trim().ToLower(),
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(builder.Configuration["DefaultAdmin:Password"] ?? "Admin12345"),
            Role = "Admin",
            AgreeToTerms = true,
            IsActive = true
        });
    }

    db.SaveChanges();
}

app.UseMiddleware<ExceptionMiddleware>();

app.UseSwagger();
app.UseSwaggerUI(options =>
{
    options.SwaggerEndpoint("/swagger/v1/swagger.json", "Ataa API v1");
    options.RoutePrefix = "swagger";
});

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
