using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Ne_mah_Mobile_Application.Migrations
{
    /// <inheritdoc />
    public partial class FixReservationsRelation : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Donations_Users_DonorUserId",
                table: "Donations");

            migrationBuilder.CreateTable(
                name: "Reservations",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DonationId = table.Column<int>(type: "int", nullable: false),
                    CharityUserId = table.Column<int>(type: "int", nullable: false),
                    ReservationDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Reservations", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Reservations_Donations_DonationId",
                        column: x => x.DonationId,
                        principalTable: "Donations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Reservations_Users_CharityUserId",
                        column: x => x.CharityUserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Reservations_CharityUserId",
                table: "Reservations",
                column: "CharityUserId");

            migrationBuilder.CreateIndex(
                name: "IX_Reservations_DonationId",
                table: "Reservations",
                column: "DonationId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Donations_Users_DonorUserId",
                table: "Donations",
                column: "DonorUserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Donations_Users_DonorUserId",
                table: "Donations");

            migrationBuilder.DropTable(
                name: "Reservations");

            migrationBuilder.AddForeignKey(
                name: "FK_Donations_Users_DonorUserId",
                table: "Donations",
                column: "DonorUserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
