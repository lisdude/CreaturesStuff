@echo off
setlocal ENABLEDELAYEDEXPANSION

:: This batch file will delete existing Creatures 2 / World Switcher registry keys and replace them with a minimum set necessary to launch the game.
:: NOTE: The location of 'MaxNorns' and 'MaxKits' differs between versions. In version 38 and below, it looks in HKEY_LOCAL_MACHINE. In 39, it looks in HKEY_CURRENT_USER. For simplicity, this file will populate both. Just beware if you're looking to change it in the future.

:: ----- CONFIGURATION -----
:: This is where your Creatures 2 is installed. NOTE: GOG installs to "C:\GOG Games\Creatures 2" by default and Deluxe to C:\Program Files\Creatures 2
SET installdir=C:\Program Files (x86)\Steam\steamapps\common\Creatures The Albian Years\Creatures 2
:: Cheat mode: Disabled by default. If you want to switch to safe cheat mode, change this to: GreenTea
::             If you want to use the developer not-so-safe cheat mode, change this to: Blueberry4$
set privileges=User
:: Maximum number of Norns in the world. A vanilla install sets maxnorns to 16.
set maxnorns=30
:: Maximum number of kits you can open at once. Vanilla install restricts this to 3.
set maxkits=30
:: The company name for your version. GOG and Steam should remain "Gameware Development", but earlier releases may be "Cyberlife Technology".
set company=Gameware Development
:: Tool fix: If enabled, this will add old registry entries for compatibility with older tools.
SET compatibility=1
:: Community Build 13: Set this to true if you want all of your data files to stay in the Creatures directory instead of Documents.
:: WARNING: This functionality is... finicky and not recommended. If you want a non-split install, it's recommended you install
::          Creatures 2 Deluxe and patch it with the Creatures Community Unified Patcher.
SET nosplit=0
:: -------------------------

:: Check if the system is 64-bit and adjust HKLM path accordingly.
set "is64bit="
if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set hklm=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\
) else (
    set hklm=HKEY_LOCAL_MACHINE\SOFTWARE\
)

:: Delete existing registry keys:
REG DELETE "HKEY_CURRENT_USER\Software\Gameware Development\Creatures 2" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Gameware Development\Creatures 2" /F
REG DELETE "HKEY_CURRENT_USER\Software\Gameware Development\World Switcher" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Gameware Development\World Switcher" /F
REG DELETE "HKEY_CURRENT_USER\Software\Cyberlife Technology\Creatures 2" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Cyberlife Technology\Creatures 2" /F
REG DELETE "HKEY_CURRENT_USER\Software\Cyberlife Technology\World Switcher" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Cyberlife Technology\World Switcher" /F
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Gameware Development\Creatures 2" /F
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Cyberlife Technology\Creatures 2" /F

:: TODO: Delete Windows compatibility entries.


:: Configure default paths. See 'installdir' in configuration.
SET regpath="%hklm%%company%\Creatures 2\1.0"
REG ADD %regpath% /v "Objects Directory" /t REG_SZ /d "%installdir%\Objects\\" /f
REG ADD %regpath% /v "Genetics Directory" /t REG_SZ /d "%installdir%\Genetics\\" /f
REG ADD %regpath% /v "Main Directory" /t REG_SZ /d "%installdir%\\" /f
REG ADD %regpath% /v "Sounds Directory" /t REG_SZ /d "%installdir%\Sounds\\" /f
REG ADD %regpath% /v "Palette Directory" /t REG_SZ /d "%installdir%\Palettes\\" /f
REG ADD %regpath% /v "History Directory" /t REG_SZ /d "%installdir%\History\\" /f
REG ADD %regpath% /v "Applet Data Directory" /t REG_SZ /d "%installdir%\Applet Data\\" /f
REG ADD %regpath% /v "Tools Directory" /t REG_SZ /d "%installdir%\Tools\\" /f
REG ADD %regpath% /v "Images Directory" /t REG_SZ /d "%installdir%\Images\\" /f
REG ADD %regpath% /v "Eggs Directory" /t REG_SZ /d "%installdir%\Eggs\\" /f
REG ADD %regpath% /v "Body Data Directory" /t REG_SZ /d "%installdir%\Body Data\\" /f
REG ADD %regpath% /v "No CD-ROM needed" /t REG_SZ /d "" /f
REG ADD %regpath% /v "MaxNorns" /t REG_DWORD /d "%maxnorns%" /f
REG ADD %regpath% /v "MaxKits" /t REG_DWORD /d "%maxkits%" /f

:: Configure tools and defaults.
SET regpath="HKEY_CURRENT_USER\SOFTWARE\%company%\Creatures 2\1.0"
REG ADD %regpath% /v "Privileges" /t REG_SZ /d "%privileges%" /f
REG ADD %regpath% /v "Tool0" /t REG_SZ /d "C2_Hatchery.OLE|Hatchery|Hatch a creature!|0|0" /f
REG ADD %regpath% /v "Tool5" /t REG_SZ /d "C2_Science.OLE|Science Kit|Science kit description here.|4|156" /f
REG ADD %regpath% /v "Tool7" /t REG_SZ /d "C2_Observation.OLE|Observation Kit| |6|0" /f
REG ADD %regpath% /v "Tool6" /t REG_SZ /d "C2_NeuroScience.OLE|Neuroscience Kit| |<|156" /f
REG ADD %regpath% /v "Tool2" /t REG_SZ /d "C2_Health.OLE|Health Kit|Creature wellbeing|3|28" /f
REG ADD %regpath% /v "Tool3" /t REG_SZ /d "C2_Graveyard.OLE|Graveyard|Creature Graveyard|9|0" /f
REG ADD %regpath% /v "Tool11" /t REG_SZ /d "C2_Ecology.OLE|Ecology Kit|Monitor Albian ecology|11|0" /f
REG ADD %regpath% /v "Tool9" /t REG_SZ /d "C2_Chronicles.OLE|Chronicles|Albian Chronicles|8|0" /f
REG ADD %regpath% /v "Tool4" /t REG_SZ /d "C2_BreedersKit.OLE|Breeder's Kit| |5|28" /f
REG ADD %regpath% /v "Tool8" /t REG_SZ /d "C2_Injector.OLE|Injector Kit|Injector Kit description here.|7|4" /f
REG ADD %regpath% /v "Tool1" /t REG_SZ /d "C2_Owner.OLE|Owner's Kit| |2|28" /f
REG ADD %regpath% /v "Objects Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Genetics Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Main Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Sounds Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Palette Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "History Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Applet Data Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Tools Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Images Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Eggs Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Body Data Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "MaxNorns" /t REG_DWORD /d "%maxnorns%" /f
REG ADD %regpath% /v "MaxKits" /t REG_DWORD /d "%maxkits%" /f

IF %nosplit% == 1 (
	REG ADD %regpath% /v "NoSplit" /t REG_DWORD /d "1" /f
)

:: Set the current world to World.sfc to avoid errors with older launchers.
SET regpath="HKEY_CURRENT_USER\SOFTWARE\%company%\Creatures 2\Current World"
REG ADD %regpath% /v "Name" /t REG_SZ /d "World.sfc" /f

:: Compatibility entries (these mimic the other HKLM paths)
IF %compatibility% == 1 (
    IF NOT "%company%" == "Cyberlife Technology" (
        SET compatregpath="%hklm%Cyberlife Technology\Creatures 2\1.0"
        REG ADD !compatregpath! /v "Objects Directory" /t REG_SZ /d "%installdir%\Objects\\" /f
        REG ADD !compatregpath! /v "Genetics Directory" /t REG_SZ /d "%installdir%\Genetics\\" /f
        REG ADD !compatregpath! /v "Main Directory" /t REG_SZ /d "%installdir%\\" /f
        REG ADD !compatregpath! /v "Sounds Directory" /t REG_SZ /d "%installdir%\Sounds\\" /f
        REG ADD !compatregpath! /v "Palette Directory" /t REG_SZ /d "%installdir%\Palettes\\" /f
        REG ADD !compatregpath! /v "History Directory" /t REG_SZ /d "%installdir%\History\\" /f
        REG ADD !compatregpath! /v "Applet Data Directory" /t REG_SZ /d "%installdir%\Applet Data\\" /f
        REG ADD !compatregpath! /v "Tools Directory" /t REG_SZ /d "%installdir%\Tools\\" /f
        REG ADD !compatregpath! /v "Images Directory" /t REG_SZ /d "%installdir%\Images\\" /f
        REG ADD !compatregpath! /v "Eggs Directory" /t REG_SZ /d "%installdir%\Eggs\\" /f
        REG ADD !compatregpath! /v "Body Data Directory" /t REG_SZ /d "%installdir%\Body Data\\" /f
    )
)

:: Windows Compatibility Settings (force 16-bit color, add DPI unawareness)
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%INSTALLDIR%\creatures2.exe" /t REG_SZ /d "~ 16BITCOLOR GDIDPISCALING DPIUNAWARE" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%INSTALLDIR%\launcher.exe" /t REG_SZ /d "~ 16BITCOLOR GDIDPISCALING DPIUNAWARE" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%INSTALLDIR%\BreedersKit.exe" /t REG_SZ /d "~ 16BITCOLOR GDIDPISCALING DPIUNAWARE" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%INSTALLDIR%\ChroniclesKit.exe" /t REG_SZ /d "~ 16BITCOLOR GDIDPISCALING DPIUNAWARE" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%INSTALLDIR%\EcologyKit.exe" /t REG_SZ /d "~ 16BITCOLOR GDIDPISCALING DPIUNAWARE" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%INSTALLDIR%\GraveyardKit.exe" /t REG_SZ /d "~ 16BITCOLOR GDIDPISCALING DPIUNAWARE" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%INSTALLDIR%\Hatchery.exe" /t REG_SZ /d "~ 16BITCOLOR GDIDPISCALING DPIUNAWARE" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%INSTALLDIR%\HealthKit.exe" /t REG_SZ /d "~ 16BITCOLOR GDIDPISCALING DPIUNAWARE" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%INSTALLDIR%\InjectorKit.exe" /t REG_SZ /d "~ 16BITCOLOR GDIDPISCALING DPIUNAWARE" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%INSTALLDIR%\NeuroscienceKit.exe" /t REG_SZ /d "~ 16BITCOLOR GDIDPISCALING DPIUNAWARE" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%INSTALLDIR%\ObservationKit.exe" /t REG_SZ /d "~ 16BITCOLOR GDIDPISCALING DPIUNAWARE" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%INSTALLDIR%\OwnerKit.exe" /t REG_SZ /d "~ 16BITCOLOR GDIDPISCALING DPIUNAWARE" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%INSTALLDIR%\ScienceKit.exe" /t REG_SZ /d "~ 16BITCOLOR GDIDPISCALING DPIUNAWARE" /f

:: Register everything
"%installdir%\BreedersKit.exe"
"%installdir%\ChroniclesKit.exe"
"%installdir%\EcologyKit.exe"
"%installdir%\GraveyardKit.exe"
"%installdir%\Hatchery.exe"
"%installdir%\HealthKit.exe"
"%installdir%\InjectorKit.exe"
"%installdir%\NeuroscienceKit.exe"
"%installdir%\ObservationKit.exe"
"%installdir%\OwnerKit.exe"
"%installdir%\ScienceKit.exe"
"%installdir%\creatures2.exe"

endlocal
