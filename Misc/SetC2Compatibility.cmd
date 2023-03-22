@echo off
setlocal

set reg_key=HKEY_LOCAL_MACHINE\SOFTWARE\Gameware Development\Creatures 2\1.0
set reg_query_command=reg query "%reg_key%" /v "Main Directory"

for /f "tokens=3,*" %%a in ('%reg_query_command%') do (
    set game_dir=%%b
)

if not defined game_dir (
    echo Error: Creatures 2 registry key not found: %reg_key%
    echo You may need to right-click and choose 'Run as administrator' on this file.
    pause
    exit /b 1
)

if not exist "%game_dir%" (
    echo Error: Invalid Main Directory: "%game_dir%"
    pause
    exit /b 1
)

cd /d "%game_dir%"

for %%f in (*.exe) do (
    echo Changing compatibility settings for "%%f"
    reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%%~ff" /t REG_SZ /d "~ DPIUNAWARE 16BITCOLOR DWM8And16BitMitigation" /f >nul
)

echo Compatibility settings updated!
pause
