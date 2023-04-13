@echo off
setlocal EnableDelayedExpansion

:: This batch file is a simple command prompt launcher that bypasses passwords and can be run from any location.
:: NOTE: It's designed to work in Windows XP, so you may have to change the PATH_TO_SFC path to read 'Documents' instead of 'My Documents'
::       You may also need to change the path to Creatures2.exe. Results may vary.

SET PATH_TO_SFC=%USERPROFILE%\My Documents\Creatures\Creatures 2
SET COMPANY=Gameware Development

set count=1
for %%f in ("%PATH_TO_SFC%\*.sfc") do (
    set file[!count!]=%%~nxf
    echo !count!. %%~nxf
    set /a count+=1
)

set /p choice="Select a world: "
set selectedFile=!file[%choice%]!

reg add "HKEY_CURRENT_USER\Software\%COMPANY%\Creatures 2\Current World" /v "Name" /t REG_SZ /d "%selectedFile%" /f

start "" "C:\Program Files\Creatures 2\Creatures2.exe" /Embedding
