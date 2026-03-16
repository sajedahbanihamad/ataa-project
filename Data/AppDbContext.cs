using Microsoft.EntityFrameworkCore;
using Ne_mah_Mobile_Application.Model;
using Ne_mah_Mobile_Application.Model_Tabels_;
using Ne_mah_Mobile_Application.modle;

namespace Ne_mah_Mobile_Application.Data_DB_Context_
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        public DbSet<User> Users { get; set; }
        public DbSet<Charity> Charities { get; set; }
        public DbSet<BusinessDonor> BusinessDonors { get; set; }
        public DbSet<IndividualDonor> IndividualDonors { get; set; }
        public DbSet<Donation> Donations { get; set; }
        public DbSet<Reservation> Reservations { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Donation>()
                .HasOne(d => d.DonorUser)
                .WithMany(u => u.Donations)
                .HasForeignKey(d => d.DonorUserId)
                .OnDelete(DeleteBehavior.Restrict);

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
        }
    }
}