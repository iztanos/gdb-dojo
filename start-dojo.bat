@echo off
setlocal

echo GDB Dojo local browser terminal
echo.

docker --version >nul 2>&1
if errorlevel 1 (
    echo Docker was not found. Install Docker Desktop, then try again.
    pause
    exit /b 1
)

docker info >nul 2>&1
if errorlevel 1 (
    echo Docker is installed but not running. Start Docker Desktop, then try again.
    pause
    exit /b 1
)

docker compose version >nul 2>&1
if not errorlevel 1 (
    echo Open http://localhost:7681
    docker compose up --build
    exit /b %errorlevel%
)

docker-compose version >nul 2>&1
if not errorlevel 1 (
    echo Open http://localhost:7681
    docker-compose up --build
    exit /b %errorlevel%
)

echo Docker Compose was not found. Install or update Docker Desktop.
pause
exit /b 1
