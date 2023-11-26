@echo off
title RFU | github.com/notcobalt 
color

REM Check if the Roblox folder exists
set "RobloxFolder=%LOCALAPPDATA%\Roblox\Versions"

if exist "%RobloxFolder%" (
    REM Get the latest version folder
    for /f "tokens=*" %%a in ('dir /b /ad /o-d "%RobloxFolder%"') do (
        set "LatestVersion=%%a"
        goto :FoundLatestVersion
    )
) else (
    echo Roblox not found.
    pause
    exit /b
)

:FoundLatestVersion
set "RobloxFolder=%RobloxFolder%\%LatestVersion%"

REM Create ClientSettings folder if it doesn't exist
set "ClientSettingsFolder=%RobloxFolder%\ClientSettings"
if not exist "%ClientSettingsFolder%" (
    mkdir "%ClientSettingsFolder%"
)

REM Prompt user for desired FPS cap
set /p "FPS=Enter desired FPS cap: "

REM Create ClientAppSettings.json file with the specified content
set "SettingsFile=%ClientSettingsFolder%\ClientAppSettings.json"
(
    echo { "DFIntTaskSchedulerTargetFps": %FPS% }
) > "%SettingsFile%"

echo [+] Roblox found.
echo [+] Roblox FPS updated to %FPS%.
pause
exit /b
