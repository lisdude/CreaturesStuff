@echo off
setlocal ENABLEDELAYEDEXPANSION

:: Set 'Cyberlife Technology' for tools that expect to find paths there.
reg copy "HKEY_LOCAL_MACHINE\SOFTWARE\Gameware Development\Creatures 2\1.0" "HKEY_LOCAL_MACHINE\SOFTWARE\Cyberlife Technology\Creatures 2\1.0" /s

:: Register BoBTweak, if found.
if exist "C:\Program Files\Creatures 2\BoBTweak.exe" (
    SET regpath="HKEY_CURRENT_USER\SOFTWARE\Gameware Development\Creatures 2\1.0"
    REG ADD !regpath! /v "Tool12" /t REG_SZ /d "BoBTweak.Application|BoBTweak|Tweaks and cheats|6|0" /f
)
