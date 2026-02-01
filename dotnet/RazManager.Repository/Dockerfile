# See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

# This stage is used when running from VS in fast mode (Default for Debug configuration)
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 8080
EXPOSE 8081


# This stage is used to build the service project
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["RazManager.Repository/RazManager.Repository.csproj", "RazManager.Repository/"]
# COPY ["RazManager.Resources/RazManager.Resources.csproj", "RazManager.Resources/"]
# COPY ["RazManager.Utilities.EntityFramework/RazManager.Utilities.EntityFramework.csproj", "RazManager.Utilities.EntityFramework/"]
# COPY ["RazManager.Utilities.Host/RazManager.Utilities.Host.csproj", "RazManager.Utilities.Host/"]
# COPY ["RazManager.Utilities.Protobuf/RazManager.Utilities.Protobuf.csproj", "RazManager.Utilities.Protobuf/"]
# COPY ["RazManager.Utilities.Store/RazManager.Utilities.Store.csproj", "RazManager.Utilities.Store/"]
RUN dotnet restore "./RazManager.Repository/RazManager.Repository.csproj"
COPY . .
WORKDIR "/src/RazManager.Repository"
RUN dotnet build "./RazManager.Repository.csproj" -c $BUILD_CONFIGURATION -o /app/build

# This stage is used to publish the service project to be copied to the final stage
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./RazManager.Repository.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# This stage is used in production or when running from VS in regular mode (Default when not using the Debug configuration)
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "RazManager.Repository.dll"]