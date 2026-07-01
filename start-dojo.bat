@echo off
setlocal

set URL=http://localhost:7681

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
    call :panel
    echo Building image quietly...
    docker compose build --quiet
    if errorlevel 1 exit /b %errorlevel%
    echo Opening browser...
    start "" "%URL%"
    echo Starting terminal...
    echo.
    docker compose up
    exit /b %errorlevel%
)

docker-compose version >nul 2>&1
if not errorlevel 1 (
    call :panel
    echo Building image...
    docker-compose build
    if errorlevel 1 exit /b %errorlevel%
    echo Opening browser...
    start "" "%URL%"
    echo Starting terminal...
    echo.
    docker-compose up
    exit /b %errorlevel%
)

echo Docker Compose was not found. Install or update Docker Desktop.
pause
exit /b 1

:panel
echo GDB Dojo local browser terminal
echo.
echo Repo:        %CD%
echo Mounted at:  /dojo
echo Terminal:    %URL%
echo Container:   gdb-dojo
echo Tools:       gdb, gcc, g++, make, vim, nano
echo.
echo Opening %URL%
echo Press Ctrl+C to stop.
echo.
exit /b 0
