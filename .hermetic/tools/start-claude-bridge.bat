@echo off
REM Claude Code Telegram Bridge - Windows Startup Script
REM WHY: Easy one-click startup for the webhook listener

echo.
echo ========================================
echo   Claude Code Telegram Bridge
echo   Sacred Technology Integration
echo ========================================
echo.

REM Set security token (secure random generated)
set BRIDGE_TOKEN=hermetic-c516aa513b7fc1295d12a0f310389244

REM Navigate to tools directory
cd /d "%USERPROFILE%\.hermetic\tools"

echo Starting webhook listener on port 3737...
echo.
echo You can now send commands from Telegram!
echo.
echo To stop: Press Ctrl+C
echo.

REM Start the Node.js bridge with environment variable
cmd /c "set BRIDGE_TOKEN=%BRIDGE_TOKEN%&& node claude-telegram-bridge.js"

pause
