using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RazManager.Silo.Repository.Migrations
{
    /// <inheritdoc />
    public partial class Initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "GrainStorage",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    ClusterId = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    StateName = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    GrainId = table.Column<string>(type: "text", nullable: false),
                    State = table.Column<byte[]>(type: "bytea", nullable: false),
                    TimeToLiveAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_GrainStorage", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "MembershipVersions",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    ClusterId = table.Column<string>(type: "character varying(150)", maxLength: 150, nullable: false),
                    Version = table.Column<int>(type: "integer", nullable: false),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MembershipVersions", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Reminders",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    ClusterId = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    GrainId = table.Column<string>(type: "text", nullable: false),
                    ReminderName = table.Column<string>(type: "text", nullable: false),
                    StartAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Period = table.Column<TimeSpan>(type: "interval", nullable: false),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Reminders", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Memberships",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    MembershipVersionId = table.Column<Guid>(type: "uuid", nullable: false),
                    SiloAddress = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Status = table.Column<string>(type: "text", nullable: false),
                    ProxyPort = table.Column<int>(type: "integer", nullable: false),
                    HostName = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    SiloName = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    StartTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    IAmAliveTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Memberships", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Memberships_MembershipVersions_MembershipVersionId",
                        column: x => x.MembershipVersionId,
                        principalTable: "MembershipVersions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "MembershipSuspectTimes",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    MembershipId = table.Column<Guid>(type: "uuid", nullable: false),
                    SiloAddress = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    SuspectTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MembershipSuspectTimes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_MembershipSuspectTimes_Memberships_MembershipId",
                        column: x => x.MembershipId,
                        principalTable: "Memberships",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_GrainStorage_ClusterId_StateName_GrainId",
                table: "GrainStorage",
                columns: new[] { "ClusterId", "StateName", "GrainId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Memberships_MembershipVersionId_SiloAddress",
                table: "Memberships",
                columns: new[] { "MembershipVersionId", "SiloAddress" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_MembershipSuspectTimes_MembershipId_SiloAddress",
                table: "MembershipSuspectTimes",
                columns: new[] { "MembershipId", "SiloAddress" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_MembershipVersions_ClusterId",
                table: "MembershipVersions",
                column: "ClusterId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Reminders_ClusterId_GrainId_ReminderName",
                table: "Reminders",
                columns: new[] { "ClusterId", "GrainId", "ReminderName" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "GrainStorage");

            migrationBuilder.DropTable(
                name: "MembershipSuspectTimes");

            migrationBuilder.DropTable(
                name: "Reminders");

            migrationBuilder.DropTable(
                name: "Memberships");

            migrationBuilder.DropTable(
                name: "MembershipVersions");
        }
    }
}
