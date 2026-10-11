@echo off
setlocal
echo ==> Installing Antigravity rules and skills via PowerShell...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Installation failed with exit code %ERRORLEVEL%.
) else (
    echo [SUCCESS] Installation completed successfully.
)
pause
