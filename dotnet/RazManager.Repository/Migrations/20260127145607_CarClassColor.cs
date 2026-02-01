using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RazManager.Repository.Migrations
{
    /// <inheritdoc />
    public partial class CarClassColor : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Color",
                table: "EventUsers");

            migrationBuilder.AddColumn<long>(
                name: "CarClassColor",
                table: "RaceIndicatorEventUsers",
                type: "bigint",
                nullable: true);

            migrationBuilder.AddColumn<long>(
                name: "CarClassColor",
                table: "HeatIndicators",
                type: "bigint",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CarClassColor",
                table: "RaceIndicatorEventUsers");

            migrationBuilder.DropColumn(
                name: "CarClassColor",
                table: "HeatIndicators");

            migrationBuilder.AddColumn<long>(
                name: "Color",
                table: "EventUsers",
                type: "bigint",
                nullable: true);
        }
    }
}
