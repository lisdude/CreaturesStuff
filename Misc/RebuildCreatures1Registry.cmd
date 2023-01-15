@echo off
setlocal ENABLEDELAYEDEXPANSION

:: This batch file will delete existing Creatures 1 registry keys and replace them with a minimum set necessary to launch the game.
:: NOTE: This was created and used only in a Windows XP environment. You may find it necessary to make changes for Windows 10 or above, specifically to the installdir and userdir.

:: ----- CONFIGURATION -----
:: This is where your Creatures 1 is installed. NOTE: GOG installs to "C:\GOG Games\Creatures 1" by default, not Program Files.
SET installdir=C:\Program Files\Creatures 1
:: Cheat mode: Disabled by default. If you want to switch to cheat mode, change this to 'doctor'
SET privileges=User
:: The company name for your version. GOG and Steam should remain "Gameware Development", but earlier releases may be "Cyberlife Technology".
SET company=Gameware Development
:: Tool fix: If enabled, this will add old registry entries for compatibility with older tools.
SET compatibility=1
:: -------------------------

:: Delete existing registry keys:
REG DELETE "HKEY_CURRENT_USER\Software\Gameware Development\Creatures 1" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Gameware Development\Creatures 1" /F
REG DELETE "HKEY_CURRENT_USER\Software\Cyberlife Technology\Creatures 1" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Cyberlife Technology\Creatures 1" /F
IF %compatibility% == 1 (
    REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Millennium Interactive\Creatures" /F
)

:: Configure default paths. See 'installdir' in configuration.
SET regpath="HKEY_LOCAL_MACHINE\SOFTWARE\%company%\Creatures 1\1.0"
REG ADD %regpath% /v "Programs" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Genetics Directory" /t REG_SZ /d "%installdir%\Genetics\\" /f
REG ADD %regpath% /v "Main Directory" /t REG_SZ /d "%installdir%\\" /f
REG ADD %regpath% /v "Sound Directory" /t REG_SZ /d "%installdir%\Sounds\\" /f
REG ADD %regpath% /v "Palette Directory" /t REG_SZ /d "%installdir%\Palettes\\" /f
REG ADD %regpath% /v "Image Directory" /t REG_SZ /d "%installdir%\Images\\" /f
REG ADD %regpath% /v "Body Data" /t REG_SZ /d "%installdir%\Body Data\\" /f
REG ADD %regpath% /v "Macro Directory" /t REG_SZ /d "%installdir%\Macros\\" /f

:: Configure tools and defaults.
SET regpath="HKEY_CURRENT_USER\SOFTWARE\%company%\Creatures 1\1.0"
REG ADD %regpath% /v "Privileges" /t REG_SZ /d "%privileges%" /f
REG ADD %regpath% /v "Tool0" /t REG_SZ /d "Hatchery.OLE|The Hatchery|Hatch a new norn|0" /f
REG ADD %regpath% /v "Tool2" /t REG_SZ /d "Owner.OLE|Owner's kit|Norn details|2" /f
REG ADD %regpath% /v "Tool3" /t REG_SZ /d "Health.OLE|Health Kit|Initial monitoring|3" /f
REG ADD %regpath% /v "Tool4" /t REG_SZ /d "Science.OLE|Science Kit|Advanced monitoring|4" /f
REG ADD %regpath% /v "Tool5" /t REG_SZ /d "Sex.OLE|Breeder's Kit|Pregnancy monitoring|5" /f
REG ADD %regpath% /v "Tool6" /t REG_SZ /d "Overview.OLE|Observation Kit|Monitor all creatures|6" /f
REG ADD %regpath% /v "Tool7" /t REG_SZ /d "ObjectInjector.OLE|Object Injector|Add new objects|7" /f
REG ADD %regpath% /v "Tool8" /t REG_SZ /d "Score.OLE|Performance Kit|Scoring data|8" /f
REG ADD %regpath% /v "Tool9" /t REG_SZ /d "Funeral.OLE|Creature Graveyard|{ay your respects|9" /f
REG ADD %regpath% /v "Programs" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Genetics Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Main Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Sound Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Palette Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Image Directory" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Body Data" /t REG_SZ /d "" /f
REG ADD %regpath% /v "Macro Directory" /t REG_SZ /d "" /f

:: Compatibility entries (these mimic the other HKLM paths)
IF %compatibility% == 1 (
    IF NOT "%company%" == "Millennium Interactive" (
        SET compatregpath="HKEY_LOCAL_MACHINE\SOFTWARE\Millennium Interactive\Creatures\1.0"
        REG ADD !compatregpath! /v "Programs" /t REG_SZ /d "" /f
        REG ADD !compatregpath! /v "Genetics Directory" /t REG_SZ /d "%installdir%\Genetics\\" /f
        REG ADD !compatregpath! /v "Main Directory" /t REG_SZ /d "%installdir%\\" /f
        REG ADD !compatregpath! /v "Sound Directory" /t REG_SZ /d "%installdir%\Sounds\\" /f
        REG ADD !compatregpath! /v "Palette Directory" /t REG_SZ /d "%installdir%\Palettes\\" /f
        REG ADD !compatregpath! /v "Image Directory" /t REG_SZ /d "%installdir%\Images\\" /f
        REG ADD !compatregpath! /v "Body Data" /t REG_SZ /d "%installdir%\Body Data\\" /f
        REG ADD !compatregpath! /v "Macro Directory" /t REG_SZ /d "%installdir%\Macros\\" /f
    )
)

:: Register everything.
"%installdir%\Breeder's Kit.exe"
"%installdir%\Funeral Kit.exe"
"%installdir%\Hatchery.exe"
"%installdir%\Health Kit.exe"
"%installdir%\Injector.exe"
"%installdir%\observation.exe"
"%installdir%\Owner's Kit.exe"
"%installdir%\Science Kit.exe"
"%installdir%\Score Kit.exe"
"%installdir%\Creatures.exe"

endlocal
