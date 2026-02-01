using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RazManager.Identity.Migrations
{
    /// <inheritdoc />
    public partial class Initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "PersistedGrants",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    TimeToLiveAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Key = table.Column<string>(type: "text", nullable: false),
                    Type = table.Column<string>(type: "text", nullable: false),
                    SubjectId = table.Column<string>(type: "text", nullable: false),
                    SessionId = table.Column<string>(type: "text", nullable: true),
                    ClientId = table.Column<string>(type: "text", nullable: false),
                    Description = table.Column<string>(type: "text", nullable: true),
                    CreationTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Expiration = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    ConsumedTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Data = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PersistedGrants", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "XmlRepositories",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    FriendlyName = table.Column<string>(type: "text", nullable: false),
                    Element = table.Column<string>(type: "text", nullable: false),
                    TimeToLiveAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_XmlRepositories", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_PersistedGrants_Key",
                table: "PersistedGrants",
                column: "Key",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_PersistedGrants_TimeToLiveAt",
                table: "PersistedGrants",
                column: "TimeToLiveAt");

            migrationBuilder.CreateIndex(
                name: "IX_XmlRepositories_TimeToLiveAt",
                table: "XmlRepositories",
                column: "TimeToLiveAt");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PersistedGrants");

            migrationBuilder.DropTable(
                name: "XmlRepositories");
        }
    }
}
