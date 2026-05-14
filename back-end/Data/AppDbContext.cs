using Microsoft.EntityFrameworkCore;
using Ataa_Mobile_Application.Models;

namespace Ataa_Mobile_Application.Data;

public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
{
    public DbSet<User> Users => Set<User>();
    public DbSet<Charity> Charities => Set<Charity>();
    public DbSet<BusinessDonor> BusinessDonors => Set<BusinessDonor>();
    public DbSet<IndividualDonor> IndividualDonors => Set<IndividualDonor>();
    public DbSet<Category> Categories => Set<Category>();
    public DbSet<Donation> Donations => Set<Donation>();
    public DbSet<Reservation> Reservations => Set<Reservation>();
    public DbSet<Notification> Notifications => Set<Notification>();
    public DbSet<Rating> Ratings => Set<Rating>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<User>().HasIndex(u => u.Email).IsUnique();
        modelBuilder.Entity<User>().Property(u => u.Name).HasMaxLength(100).IsRequired();
        modelBuilder.Entity<User>().Property(u => u.Email).HasMaxLength(150).IsRequired();
        modelBuilder.Entity<User>().Property(u => u.PasswordHash).IsRequired();
        modelBuilder.Entity<User>().Property(u => u.Role).HasMaxLength(50).IsRequired();

        modelBuilder.Entity<IndividualDonor>()
            .HasOne(d => d.User)
            .WithOne()
            .HasForeignKey<IndividualDonor>(d => d.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<BusinessDonor>()
            .HasOne(d => d.User)
            .WithOne()
            .HasForeignKey<BusinessDonor>(d => d.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Charity>()
            .HasOne(c => c.User)
            .WithOne()
            .HasForeignKey<Charity>(c => c.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Category>().HasIndex(c => c.Name).IsUnique();
        modelBuilder.Entity<Category>().Property(c => c.Name).HasMaxLength(100).IsRequired();

        modelBuilder.Entity<Donation>().Property(d => d.Description).HasMaxLength(500).IsRequired();
        modelBuilder.Entity<Donation>().Property(d => d.PickupLocation).HasMaxLength(200).IsRequired();
        modelBuilder.Entity<Donation>().Property(d => d.Status).HasMaxLength(50).IsRequired();

        modelBuilder.Entity<Donation>()
            .HasOne(d => d.DonorUser)
            .WithMany(u => u.Donations)
            .HasForeignKey(d => d.DonorUserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Donation>()
            .HasOne(d => d.TargetCharityUser)
            .WithMany()
            .HasForeignKey(d => d.TargetCharityUserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Donation>()
            .HasOne(d => d.Category)
            .WithMany(c => c.Donations)
            .HasForeignKey(d => d.CategoryId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Reservation>().Property(r => r.Status).HasMaxLength(50).IsRequired();
        modelBuilder.Entity<Reservation>().HasIndex(r => r.DonationId).IsUnique();
        modelBuilder.Entity<Reservation>()
            .HasOne(r => r.Donation)
            .WithOne(d => d.Reservation)
            .HasForeignKey<Reservation>(r => r.DonationId)
            .OnDelete(DeleteBehavior.Restrict);
        modelBuilder.Entity<Reservation>()
            .HasOne(r => r.CharityUser)
            .WithMany(u => u.Reservations)
            .HasForeignKey(r => r.CharityUserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Notification>()
            .HasOne(n => n.User)
            .WithMany(u => u.Notifications)
            .HasForeignKey(n => n.UserId)
            .OnDelete(DeleteBehavior.Restrict);
        modelBuilder.Entity<Notification>()
            .HasOne(n => n.Donation)
            .WithMany(d => d.Notifications)
            .HasForeignKey(n => n.DonationId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Rating>().HasIndex(r => r.ReservationId).IsUnique();
        modelBuilder.Entity<Rating>()
            .HasOne(r => r.Reservation)
            .WithMany()
            .HasForeignKey(r => r.ReservationId)
            .OnDelete(DeleteBehavior.Restrict);
        modelBuilder.Entity<Rating>()
            .HasOne(r => r.DonorUser)
            .WithMany()
            .HasForeignKey(r => r.DonorUserId)
            .OnDelete(DeleteBehavior.Restrict);
        modelBuilder.Entity<Rating>()
            .HasOne(r => r.CharityUser)
            .WithMany()
            .HasForeignKey(r => r.CharityUserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Category>().HasData(
            new Category { Id = 1, Name = "Food", Description = "Food donations", IsActive = true, CreatedAt = new DateTime(2026, 1, 1) },
            new Category { Id = 2, Name = "Clothes", Description = "Clothes donations", IsActive = true, CreatedAt = new DateTime(2026, 1, 1) },
            new Category { Id = 3, Name = "Other", Description = "Other essential items", IsActive = true, CreatedAt = new DateTime(2026, 1, 1) }
        );
    }
}
