using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RazManager.Repository.Migrations
{
    /// <inheritdoc />
    public partial class Initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Tenants",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Description = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: true),
                    Enabled = table.Column<bool>(type: "boolean", nullable: false),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Tenants", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    UserName = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Email = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true),
                    ShortName = table.Column<string>(type: "character varying(3)", maxLength: 3, nullable: true),
                    PasswordHash = table.Column<byte[]>(type: "bytea", nullable: false),
                    Administrator = table.Column<bool>(type: "boolean", nullable: false),
                    TimeToLiveAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Versions",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Date = table.Column<DateOnly>(type: "date", nullable: false),
                    Major = table.Column<short>(type: "smallint", nullable: false),
                    Minor = table.Column<short>(type: "smallint", nullable: false),
                    Patch = table.Column<short>(type: "smallint", nullable: false),
                    Valid = table.Column<bool>(type: "boolean", nullable: false),
                    Description = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Versions", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Cars",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Number = table.Column<int>(type: "integer", nullable: true),
                    Description = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: true),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false),
                    TenantId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Cars", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Cars_Tenants_TenantId",
                        column: x => x.TenantId,
                        principalTable: "Tenants",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CarTags",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Description = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: true),
                    Position = table.Column<byte>(type: "smallint", nullable: false),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false),
                    TenantId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CarTags", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CarTags_Tenants_TenantId",
                        column: x => x.TenantId,
                        principalTable: "Tenants",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Devices",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Description = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: true),
                    LastConnectedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Simulated = table.Column<bool>(type: "boolean", nullable: false),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false),
                    TenantId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Devices", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Devices_Tenants_TenantId",
                        column: x => x.TenantId,
                        principalTable: "Tenants",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Events",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Description = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: true),
                    StartsAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    PublishFrom = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    TimeToLiveAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    EventVisibilityTypeId = table.Column<string>(type: "text", nullable: false),
                    CurrentRaceId = table.Column<Guid>(type: "uuid", nullable: true),
                    CurrentHeatId = table.Column<Guid>(type: "uuid", nullable: true),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false),
                    TenantId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Events", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Events_Tenants_TenantId",
                        column: x => x.TenantId,
                        principalTable: "Tenants",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "PointsSchemas",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Description = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: true),
                    Position = table.Column<byte>(type: "smallint", nullable: false),
                    PointsRaceSessionHeatFastestLap = table.Column<byte>(type: "smallint", nullable: true),
                    PointsRaceSessionHeatMostLedLaps = table.Column<byte>(type: "smallint", nullable: true),
                    PointsRaceSessionHeatLedAtLeastOneLap = table.Column<byte>(type: "smallint", nullable: true),
                    PointsRaceSessionOverallFastestLap = table.Column<byte>(type: "smallint", nullable: true),
                    PointsRaceSessionOverallMostLedLaps = table.Column<byte>(type: "smallint", nullable: true),
                    MinDrivers = table.Column<byte>(type: "smallint", nullable: false),
                    MaxDrivers = table.Column<byte>(type: "smallint", nullable: false),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false),
                    TenantId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PointsSchemas", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PointsSchemas_Tenants_TenantId",
                        column: x => x.TenantId,
                        principalTable: "Tenants",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TenantImages",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    TenantId = table.Column<Guid>(type: "uuid", nullable: false),
                    ImageSize = table.Column<string>(type: "text", nullable: false),
                    Image = table.Column<byte[]>(type: "bytea", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TenantImages", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TenantImages_Tenants_TenantId",
                        column: x => x.TenantId,
                        principalTable: "Tenants",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TenantInvites",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    TenantId = table.Column<Guid>(type: "uuid", nullable: false),
                    Code = table.Column<int>(type: "integer", nullable: false),
                    Multiple = table.Column<bool>(type: "boolean", nullable: false),
                    TimeToLiveAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TenantInvites", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TenantInvites_Tenants_TenantId",
                        column: x => x.TenantId,
                        principalTable: "Tenants",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Tracks",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Description = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: true),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false),
                    TenantId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Tracks", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Tracks_Tenants_TenantId",
                        column: x => x.TenantId,
                        principalTable: "Tenants",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TenantUsers",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    TenantId = table.Column<Guid>(type: "uuid", nullable: false),
                    UserId = table.Column<Guid>(type: "uuid", nullable: true),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true),
                    ShortName = table.Column<string>(type: "character varying(3)", maxLength: 3, nullable: true),
                    Administrator = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TenantUsers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TenantUsers_Tenants_TenantId",
                        column: x => x.TenantId,
                        principalTable: "Tenants",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TenantUsers_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "UserImages",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    UserId = table.Column<Guid>(type: "uuid", nullable: false),
                    ImageSize = table.Column<string>(type: "text", nullable: false),
                    Image = table.Column<byte[]>(type: "bytea", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserImages", x => x.Id);
                    table.ForeignKey(
                        name: "FK_UserImages_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "VersionNotes",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    VersionId = table.Column<Guid>(type: "uuid", nullable: false),
                    Position = table.Column<byte>(type: "smallint", nullable: false),
                    Description = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VersionNotes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_VersionNotes_Versions_VersionId",
                        column: x => x.VersionId,
                        principalTable: "Versions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "VersionPlatforms",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    VersionId = table.Column<Guid>(type: "uuid", nullable: false),
                    VersionPlatformId = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VersionPlatforms", x => x.Id);
                    table.ForeignKey(
                        name: "FK_VersionPlatforms_Versions_VersionId",
                        column: x => x.VersionId,
                        principalTable: "Versions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CarImages",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    CarId = table.Column<Guid>(type: "uuid", nullable: false),
                    ImageSize = table.Column<string>(type: "text", nullable: false),
                    Image = table.Column<byte[]>(type: "bytea", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CarImages", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CarImages_Cars_CarId",
                        column: x => x.CarId,
                        principalTable: "Cars",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CarCarTags",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    CarId = table.Column<Guid>(type: "uuid", nullable: false),
                    CarTagId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CarCarTags", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CarCarTags_CarTags_CarTagId",
                        column: x => x.CarTagId,
                        principalTable: "CarTags",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CarCarTags_Cars_CarId",
                        column: x => x.CarId,
                        principalTable: "Cars",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DeviceConfigurations",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    DeviceId = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DeviceConfigurations", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DeviceConfigurations_Devices_DeviceId",
                        column: x => x.DeviceId,
                        principalTable: "Devices",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "EventImages",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    EventId = table.Column<Guid>(type: "uuid", nullable: false),
                    ImageSize = table.Column<string>(type: "text", nullable: false),
                    Image = table.Column<byte[]>(type: "bytea", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_EventImages", x => x.Id);
                    table.ForeignKey(
                        name: "FK_EventImages_Events_EventId",
                        column: x => x.EventId,
                        principalTable: "Events",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "EventInvites",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    EventId = table.Column<Guid>(type: "uuid", nullable: false),
                    Code = table.Column<int>(type: "integer", nullable: false),
                    Multiple = table.Column<bool>(type: "boolean", nullable: false),
                    TimeToLiveAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_EventInvites", x => x.Id);
                    table.ForeignKey(
                        name: "FK_EventInvites_Events_EventId",
                        column: x => x.EventId,
                        principalTable: "Events",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "PointsSchemePositions",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    PointsSchemeId = table.Column<Guid>(type: "uuid", nullable: false),
                    Position = table.Column<byte>(type: "smallint", nullable: false),
                    Points = table.Column<byte>(type: "smallint", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PointsSchemePositions", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PointsSchemePositions_PointsSchemas_PointsSchemeId",
                        column: x => x.PointsSchemeId,
                        principalTable: "PointsSchemas",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TrackConfigurations",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    TrackId = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    LaptimeMinSeconds = table.Column<byte>(type: "smallint", nullable: false),
                    LaptimeMaxSeconds = table.Column<short>(type: "smallint", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TrackConfigurations", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TrackConfigurations_Tracks_TrackId",
                        column: x => x.TrackId,
                        principalTable: "Tracks",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TrackImages",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    TrackId = table.Column<Guid>(type: "uuid", nullable: false),
                    ImageSize = table.Column<string>(type: "text", nullable: false),
                    Image = table.Column<byte[]>(type: "bytea", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TrackImages", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TrackImages_Tracks_TrackId",
                        column: x => x.TrackId,
                        principalTable: "Tracks",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DeviceConfigurationFeatures",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    DeviceConfigurationId = table.Column<Guid>(type: "uuid", nullable: false),
                    DeviceConfigurationFeatureTypeId = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DeviceConfigurationFeatures", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DeviceConfigurationFeatures_DeviceConfigurations_DeviceConf~",
                        column: x => x.DeviceConfigurationId,
                        principalTable: "DeviceConfigurations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DeviceConfigurationInputs",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    DeviceConfigurationId = table.Column<Guid>(type: "uuid", nullable: false),
                    DeviceConfigurationInputTypeId = table.Column<string>(type: "text", nullable: false),
                    DeviceConfigurationInputId = table.Column<byte>(type: "smallint", nullable: true),
                    DeviceConfigurationInputSubId = table.Column<byte>(type: "smallint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DeviceConfigurationInputs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DeviceConfigurationInputs_DeviceConfigurations_DeviceConfig~",
                        column: x => x.DeviceConfigurationId,
                        principalTable: "DeviceConfigurations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DeviceConfigurationOutputs",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    DeviceConfigurationId = table.Column<Guid>(type: "uuid", nullable: false),
                    DeviceConfigurationOutputTypeId = table.Column<string>(type: "text", nullable: false),
                    DeviceConfigurationOutputId = table.Column<byte>(type: "smallint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DeviceConfigurationOutputs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DeviceConfigurationOutputs_DeviceConfigurations_DeviceConfi~",
                        column: x => x.DeviceConfigurationId,
                        principalTable: "DeviceConfigurations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Autopilots",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    TrackConfigurationId = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    ShortName = table.Column<string>(type: "character varying(3)", maxLength: 3, nullable: true),
                    Description = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: true),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Autopilots", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Autopilots_TrackConfigurations_TrackConfigurationId",
                        column: x => x.TrackConfigurationId,
                        principalTable: "TrackConfigurations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Races",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    EventId = table.Column<Guid>(type: "uuid", nullable: false),
                    Number = table.Column<int>(type: "integer", nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true),
                    TrackConfigurationId = table.Column<Guid>(type: "uuid", nullable: false),
                    PointsSchemeId = table.Column<Guid>(type: "uuid", nullable: true),
                    QualifyingSession = table.Column<bool>(type: "boolean", nullable: false),
                    PracticeSession = table.Column<bool>(type: "boolean", nullable: false),
                    RaceSession = table.Column<bool>(type: "boolean", nullable: false),
                    RaceFormatTypeId = table.Column<string>(type: "text", nullable: false),
                    RaceHeatEndTypeId = table.Column<string>(type: "text", nullable: false),
                    RaceHeatEndLapLaps = table.Column<int>(type: "integer", nullable: true),
                    RaceHeatEndDurationDuration = table.Column<TimeSpan>(type: "interval", nullable: true),
                    HeatCarTypeId = table.Column<string>(type: "text", nullable: false),
                    RaceStateTypeId = table.Column<string>(type: "text", nullable: false),
                    EnergySimulation = table.Column<bool>(type: "boolean", nullable: false),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Races", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Races_Events_EventId",
                        column: x => x.EventId,
                        principalTable: "Events",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Races_PointsSchemas_PointsSchemeId",
                        column: x => x.PointsSchemeId,
                        principalTable: "PointsSchemas",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Races_TrackConfigurations_TrackConfigurationId",
                        column: x => x.TrackConfigurationId,
                        principalTable: "TrackConfigurations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "TrackConfigurationDeviceConfigurations",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    TrackConfigurationId = table.Column<Guid>(type: "uuid", nullable: false),
                    DeviceConfigurationId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TrackConfigurationDeviceConfigurations", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TrackConfigurationDeviceConfigurations_DeviceConfigurations~",
                        column: x => x.DeviceConfigurationId,
                        principalTable: "DeviceConfigurations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TrackConfigurationDeviceConfigurations_TrackConfigurations_~",
                        column: x => x.TrackConfigurationId,
                        principalTable: "TrackConfigurations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TrackConfigurationIndicators",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    TrackConfigurationId = table.Column<Guid>(type: "uuid", nullable: false),
                    IndicatorId = table.Column<byte>(type: "smallint", nullable: false),
                    Color = table.Column<long>(type: "bigint", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TrackConfigurationIndicators", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TrackConfigurationIndicators_TrackConfigurations_TrackConfi~",
                        column: x => x.TrackConfigurationId,
                        principalTable: "TrackConfigurations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TrackConfigurationRaceFormats",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    TrackConfigurationId = table.Column<Guid>(type: "uuid", nullable: false),
                    RaceFormatTypeId = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TrackConfigurationRaceFormats", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TrackConfigurationRaceFormats_TrackConfigurations_TrackConf~",
                        column: x => x.TrackConfigurationId,
                        principalTable: "TrackConfigurations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AutopilotImages",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    AutopilotId = table.Column<Guid>(type: "uuid", nullable: false),
                    ImageSize = table.Column<string>(type: "text", nullable: false),
                    Image = table.Column<byte[]>(type: "bytea", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AutopilotImages", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AutopilotImages_Autopilots_AutopilotId",
                        column: x => x.AutopilotId,
                        principalTable: "Autopilots",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "EventUsers",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    EventId = table.Column<Guid>(type: "uuid", nullable: false),
                    EventUserId = table.Column<Guid>(type: "uuid", nullable: true),
                    UserId = table.Column<Guid>(type: "uuid", nullable: true),
                    AutopilotId = table.Column<Guid>(type: "uuid", nullable: true),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true),
                    ShortName = table.Column<string>(type: "character varying(3)", maxLength: 3, nullable: true),
                    EventUserTypeId = table.Column<string>(type: "text", nullable: false),
                    Color = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_EventUsers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_EventUsers_Autopilots_AutopilotId",
                        column: x => x.AutopilotId,
                        principalTable: "Autopilots",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_EventUsers_EventUsers_EventUserId",
                        column: x => x.EventUserId,
                        principalTable: "EventUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_EventUsers_Events_EventId",
                        column: x => x.EventId,
                        principalTable: "Events",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_EventUsers_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Heats",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    RaceId = table.Column<Guid>(type: "uuid", nullable: false),
                    Number = table.Column<int>(type: "integer", nullable: false),
                    SessionTypeId = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Heats", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Heats_Races_RaceId",
                        column: x => x.RaceId,
                        principalTable: "Races",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "RaceCarTagEntity",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    RaceId = table.Column<Guid>(type: "uuid", nullable: false),
                    CarTagId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RaceCarTagEntity", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RaceCarTagEntity_CarTags_CarTagId",
                        column: x => x.CarTagId,
                        principalTable: "CarTags",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_RaceCarTagEntity_Races_RaceId",
                        column: x => x.RaceId,
                        principalTable: "Races",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "RaceIndicators",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    RaceId = table.Column<Guid>(type: "uuid", nullable: false),
                    IndicatorId = table.Column<long>(type: "bigint", nullable: false),
                    CarId = table.Column<Guid>(type: "uuid", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RaceIndicators", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RaceIndicators_Cars_CarId",
                        column: x => x.CarId,
                        principalTable: "Cars",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_RaceIndicators_Races_RaceId",
                        column: x => x.RaceId,
                        principalTable: "Races",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "EventUserImages",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    EventUserId = table.Column<Guid>(type: "uuid", nullable: false),
                    ImageSize = table.Column<string>(type: "text", nullable: false),
                    Image = table.Column<byte[]>(type: "bytea", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_EventUserImages", x => x.Id);
                    table.ForeignKey(
                        name: "FK_EventUserImages_EventUsers_EventUserId",
                        column: x => x.EventUserId,
                        principalTable: "EventUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "RaceEventUsers",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    RaceId = table.Column<Guid>(type: "uuid", nullable: false),
                    EventUserId = table.Column<Guid>(type: "uuid", nullable: false),
                    CarId = table.Column<Guid>(type: "uuid", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RaceEventUsers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RaceEventUsers_Cars_CarId",
                        column: x => x.CarId,
                        principalTable: "Cars",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_RaceEventUsers_EventUsers_EventUserId",
                        column: x => x.EventUserId,
                        principalTable: "EventUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_RaceEventUsers_Races_RaceId",
                        column: x => x.RaceId,
                        principalTable: "Races",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "RaceIndicatorEventUsers",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    RaceId = table.Column<Guid>(type: "uuid", nullable: false),
                    IndicatorId = table.Column<long>(type: "bigint", nullable: false),
                    EventUserId = table.Column<Guid>(type: "uuid", nullable: true),
                    CarId = table.Column<Guid>(type: "uuid", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RaceIndicatorEventUsers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RaceIndicatorEventUsers_Cars_CarId",
                        column: x => x.CarId,
                        principalTable: "Cars",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_RaceIndicatorEventUsers_EventUsers_EventUserId",
                        column: x => x.EventUserId,
                        principalTable: "EventUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_RaceIndicatorEventUsers_Races_RaceId",
                        column: x => x.RaceId,
                        principalTable: "Races",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "HeatIndicators",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    HeatId = table.Column<Guid>(type: "uuid", nullable: false),
                    IndicatorId = table.Column<long>(type: "bigint", nullable: false),
                    EventUserId = table.Column<Guid>(type: "uuid", nullable: true),
                    CarId = table.Column<Guid>(type: "uuid", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_HeatIndicators", x => x.Id);
                    table.ForeignKey(
                        name: "FK_HeatIndicators_Cars_CarId",
                        column: x => x.CarId,
                        principalTable: "Cars",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_HeatIndicators_EventUsers_EventUserId",
                        column: x => x.EventUserId,
                        principalTable: "EventUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_HeatIndicators_Heats_HeatId",
                        column: x => x.HeatId,
                        principalTable: "Heats",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "HeatJournals",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    HeatId = table.Column<Guid>(type: "uuid", nullable: false),
                    Timestamp = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    SequenceNumber = table.Column<long>(type: "bigint", nullable: false),
                    Payload = table.Column<byte[]>(type: "bytea", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_HeatJournals", x => x.Id);
                    table.ForeignKey(
                        name: "FK_HeatJournals_Heats_HeatId",
                        column: x => x.HeatId,
                        principalTable: "Heats",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "HeatIndicatorStints",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    HeatIndicatorId = table.Column<Guid>(type: "uuid", nullable: false),
                    Lap = table.Column<long>(type: "bigint", nullable: false),
                    EventUserId = table.Column<Guid>(type: "uuid", nullable: true),
                    Comments = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: true),
                    ETag = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_HeatIndicatorStints", x => x.Id);
                    table.ForeignKey(
                        name: "FK_HeatIndicatorStints_EventUsers_EventUserId",
                        column: x => x.EventUserId,
                        principalTable: "EventUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_HeatIndicatorStints_HeatIndicators_HeatIndicatorId",
                        column: x => x.HeatIndicatorId,
                        principalTable: "HeatIndicators",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_AutopilotImages_AutopilotId_ImageSize",
                table: "AutopilotImages",
                columns: new[] { "AutopilotId", "ImageSize" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Autopilots_TrackConfigurationId_Name",
                table: "Autopilots",
                columns: new[] { "TrackConfigurationId", "Name" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_CarCarTags_CarId_CarTagId",
                table: "CarCarTags",
                columns: new[] { "CarId", "CarTagId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_CarCarTags_CarTagId_CarId",
                table: "CarCarTags",
                columns: new[] { "CarTagId", "CarId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_CarImages_CarId_ImageSize",
                table: "CarImages",
                columns: new[] { "CarId", "ImageSize" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Cars_TenantId_Name",
                table: "Cars",
                columns: new[] { "TenantId", "Name" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_CarTags_TenantId_Name",
                table: "CarTags",
                columns: new[] { "TenantId", "Name" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_CarTags_TenantId_Position_Name",
                table: "CarTags",
                columns: new[] { "TenantId", "Position", "Name" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_DeviceConfigurationFeatures_DeviceConfigurationId_DeviceCon~",
                table: "DeviceConfigurationFeatures",
                columns: new[] { "DeviceConfigurationId", "DeviceConfigurationFeatureTypeId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_DeviceConfigurationInputs_DeviceConfigurationId",
                table: "DeviceConfigurationInputs",
                column: "DeviceConfigurationId");

            migrationBuilder.CreateIndex(
                name: "IX_DeviceConfigurationOutputs_DeviceConfigurationId",
                table: "DeviceConfigurationOutputs",
                column: "DeviceConfigurationId");

            migrationBuilder.CreateIndex(
                name: "IX_DeviceConfigurations_DeviceId_Name",
                table: "DeviceConfigurations",
                columns: new[] { "DeviceId", "Name" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Devices_TenantId_Name",
                table: "Devices",
                columns: new[] { "TenantId", "Name" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_EventImages_EventId_ImageSize",
                table: "EventImages",
                columns: new[] { "EventId", "ImageSize" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_EventInvites_Code",
                table: "EventInvites",
                column: "Code",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_EventInvites_EventId",
                table: "EventInvites",
                column: "EventId");

            migrationBuilder.CreateIndex(
                name: "IX_EventInvites_TimeToLiveAt",
                table: "EventInvites",
                column: "TimeToLiveAt");

            migrationBuilder.CreateIndex(
                name: "IX_Events_TenantId_Name",
                table: "Events",
                columns: new[] { "TenantId", "Name" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Events_TimeToLiveAt",
                table: "Events",
                column: "TimeToLiveAt");

            migrationBuilder.CreateIndex(
                name: "IX_EventUserImages_EventUserId_ImageSize",
                table: "EventUserImages",
                columns: new[] { "EventUserId", "ImageSize" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_EventUsers_AutopilotId",
                table: "EventUsers",
                column: "AutopilotId");

            migrationBuilder.CreateIndex(
                name: "IX_EventUsers_EventId",
                table: "EventUsers",
                column: "EventId");

            migrationBuilder.CreateIndex(
                name: "IX_EventUsers_EventUserId",
                table: "EventUsers",
                column: "EventUserId");

            migrationBuilder.CreateIndex(
                name: "IX_EventUsers_UserId",
                table: "EventUsers",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_HeatIndicators_CarId",
                table: "HeatIndicators",
                column: "CarId");

            migrationBuilder.CreateIndex(
                name: "IX_HeatIndicators_EventUserId",
                table: "HeatIndicators",
                column: "EventUserId");

            migrationBuilder.CreateIndex(
                name: "IX_HeatIndicators_HeatId_EventUserId",
                table: "HeatIndicators",
                columns: new[] { "HeatId", "EventUserId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_HeatIndicators_HeatId_IndicatorId",
                table: "HeatIndicators",
                columns: new[] { "HeatId", "IndicatorId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_HeatIndicatorStints_EventUserId",
                table: "HeatIndicatorStints",
                column: "EventUserId");

            migrationBuilder.CreateIndex(
                name: "IX_HeatIndicatorStints_HeatIndicatorId_Lap",
                table: "HeatIndicatorStints",
                columns: new[] { "HeatIndicatorId", "Lap" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_HeatJournals_HeatId_Timestamp_SequenceNumber",
                table: "HeatJournals",
                columns: new[] { "HeatId", "Timestamp", "SequenceNumber" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Heats_RaceId_SessionTypeId_Number",
                table: "Heats",
                columns: new[] { "RaceId", "SessionTypeId", "Number" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_PointsSchemas_TenantId_Name",
                table: "PointsSchemas",
                columns: new[] { "TenantId", "Name" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_PointsSchemePositions_PointsSchemeId_Position",
                table: "PointsSchemePositions",
                columns: new[] { "PointsSchemeId", "Position" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_RaceCarTagEntity_CarTagId",
                table: "RaceCarTagEntity",
                column: "CarTagId");

            migrationBuilder.CreateIndex(
                name: "IX_RaceCarTagEntity_RaceId_CarTagId",
                table: "RaceCarTagEntity",
                columns: new[] { "RaceId", "CarTagId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_RaceEventUsers_CarId",
                table: "RaceEventUsers",
                column: "CarId");

            migrationBuilder.CreateIndex(
                name: "IX_RaceEventUsers_EventUserId",
                table: "RaceEventUsers",
                column: "EventUserId");

            migrationBuilder.CreateIndex(
                name: "IX_RaceEventUsers_RaceId_EventUserId",
                table: "RaceEventUsers",
                columns: new[] { "RaceId", "EventUserId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_RaceIndicatorEventUsers_CarId",
                table: "RaceIndicatorEventUsers",
                column: "CarId");

            migrationBuilder.CreateIndex(
                name: "IX_RaceIndicatorEventUsers_EventUserId",
                table: "RaceIndicatorEventUsers",
                column: "EventUserId");

            migrationBuilder.CreateIndex(
                name: "IX_RaceIndicatorEventUsers_RaceId_EventUserId",
                table: "RaceIndicatorEventUsers",
                columns: new[] { "RaceId", "EventUserId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_RaceIndicatorEventUsers_RaceId_IndicatorId",
                table: "RaceIndicatorEventUsers",
                columns: new[] { "RaceId", "IndicatorId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_RaceIndicators_CarId",
                table: "RaceIndicators",
                column: "CarId");

            migrationBuilder.CreateIndex(
                name: "IX_RaceIndicators_RaceId_IndicatorId",
                table: "RaceIndicators",
                columns: new[] { "RaceId", "IndicatorId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Races_EventId_Number",
                table: "Races",
                columns: new[] { "EventId", "Number" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Races_PointsSchemeId",
                table: "Races",
                column: "PointsSchemeId");

            migrationBuilder.CreateIndex(
                name: "IX_Races_TrackConfigurationId",
                table: "Races",
                column: "TrackConfigurationId");

            migrationBuilder.CreateIndex(
                name: "IX_TenantImages_TenantId_ImageSize",
                table: "TenantImages",
                columns: new[] { "TenantId", "ImageSize" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_TenantInvites_Code",
                table: "TenantInvites",
                column: "Code",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_TenantInvites_TenantId",
                table: "TenantInvites",
                column: "TenantId");

            migrationBuilder.CreateIndex(
                name: "IX_TenantInvites_TimeToLiveAt",
                table: "TenantInvites",
                column: "TimeToLiveAt");

            migrationBuilder.CreateIndex(
                name: "IX_TenantUsers_TenantId",
                table: "TenantUsers",
                column: "TenantId");

            migrationBuilder.CreateIndex(
                name: "IX_TenantUsers_UserId",
                table: "TenantUsers",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_TrackConfigurationDeviceConfigurations_DeviceConfigurationI~",
                table: "TrackConfigurationDeviceConfigurations",
                columns: new[] { "DeviceConfigurationId", "TrackConfigurationId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_TrackConfigurationDeviceConfigurations_TrackConfigurationId~",
                table: "TrackConfigurationDeviceConfigurations",
                columns: new[] { "TrackConfigurationId", "DeviceConfigurationId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_TrackConfigurationIndicators_TrackConfigurationId_Indicator~",
                table: "TrackConfigurationIndicators",
                columns: new[] { "TrackConfigurationId", "IndicatorId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_TrackConfigurationRaceFormats_TrackConfigurationId_RaceForm~",
                table: "TrackConfigurationRaceFormats",
                columns: new[] { "TrackConfigurationId", "RaceFormatTypeId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_TrackConfigurations_TrackId_Name",
                table: "TrackConfigurations",
                columns: new[] { "TrackId", "Name" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_TrackImages_TrackId_ImageSize",
                table: "TrackImages",
                columns: new[] { "TrackId", "ImageSize" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Tracks_TenantId_Name",
                table: "Tracks",
                columns: new[] { "TenantId", "Name" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_UserImages_UserId_ImageSize",
                table: "UserImages",
                columns: new[] { "UserId", "ImageSize" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Users_TimeToLiveAt",
                table: "Users",
                column: "TimeToLiveAt");

            migrationBuilder.CreateIndex(
                name: "IX_Users_UserName",
                table: "Users",
                column: "UserName",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_VersionNotes_VersionId_Position",
                table: "VersionNotes",
                columns: new[] { "VersionId", "Position" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_VersionPlatforms_VersionId_VersionPlatformId",
                table: "VersionPlatforms",
                columns: new[] { "VersionId", "VersionPlatformId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Versions_Major_Minor_Patch",
                table: "Versions",
                columns: new[] { "Major", "Minor", "Patch" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AutopilotImages");

            migrationBuilder.DropTable(
                name: "CarCarTags");

            migrationBuilder.DropTable(
                name: "CarImages");

            migrationBuilder.DropTable(
                name: "DeviceConfigurationFeatures");

            migrationBuilder.DropTable(
                name: "DeviceConfigurationInputs");

            migrationBuilder.DropTable(
                name: "DeviceConfigurationOutputs");

            migrationBuilder.DropTable(
                name: "EventImages");

            migrationBuilder.DropTable(
                name: "EventInvites");

            migrationBuilder.DropTable(
                name: "EventUserImages");

            migrationBuilder.DropTable(
                name: "HeatIndicatorStints");

            migrationBuilder.DropTable(
                name: "HeatJournals");

            migrationBuilder.DropTable(
                name: "PointsSchemePositions");

            migrationBuilder.DropTable(
                name: "RaceCarTagEntity");

            migrationBuilder.DropTable(
                name: "RaceEventUsers");

            migrationBuilder.DropTable(
                name: "RaceIndicatorEventUsers");

            migrationBuilder.DropTable(
                name: "RaceIndicators");

            migrationBuilder.DropTable(
                name: "TenantImages");

            migrationBuilder.DropTable(
                name: "TenantInvites");

            migrationBuilder.DropTable(
                name: "TenantUsers");

            migrationBuilder.DropTable(
                name: "TrackConfigurationDeviceConfigurations");

            migrationBuilder.DropTable(
                name: "TrackConfigurationIndicators");

            migrationBuilder.DropTable(
                name: "TrackConfigurationRaceFormats");

            migrationBuilder.DropTable(
                name: "TrackImages");

            migrationBuilder.DropTable(
                name: "UserImages");

            migrationBuilder.DropTable(
                name: "VersionNotes");

            migrationBuilder.DropTable(
                name: "VersionPlatforms");

            migrationBuilder.DropTable(
                name: "HeatIndicators");

            migrationBuilder.DropTable(
                name: "CarTags");

            migrationBuilder.DropTable(
                name: "DeviceConfigurations");

            migrationBuilder.DropTable(
                name: "Versions");

            migrationBuilder.DropTable(
                name: "Cars");

            migrationBuilder.DropTable(
                name: "EventUsers");

            migrationBuilder.DropTable(
                name: "Heats");

            migrationBuilder.DropTable(
                name: "Devices");

            migrationBuilder.DropTable(
                name: "Autopilots");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "Races");

            migrationBuilder.DropTable(
                name: "Events");

            migrationBuilder.DropTable(
                name: "PointsSchemas");

            migrationBuilder.DropTable(
                name: "TrackConfigurations");

            migrationBuilder.DropTable(
                name: "Tracks");

            migrationBuilder.DropTable(
                name: "Tenants");
        }
    }
}
