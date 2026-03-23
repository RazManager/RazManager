using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RazManager.Repository.Migrations
{
    /// <inheritdoc />
    public partial class preconfiguredStint : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "PreconfiguredIndicatorsJson",
                table: "Heats",
                type: "text",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PreconfiguredIndicatorsJson",
                table: "Heats");
        }
    }
}
