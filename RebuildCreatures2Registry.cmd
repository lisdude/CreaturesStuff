@echo off

:: This batch file will delete existing Creatures 2 / World Switcher registry keys and replace them with a minimum set necessary to launch the game.
:: NOTE: This was created and used only in a Windows XP environment. You may find it necessary to make changes for Windows 10 or above, specifically to the installdir.

:: Delete existing registry keys:
REG DELETE "HKEY_CURRENT_USER\Software\Gameware Development\Creatures 2" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Gameware Development\Creatures 2" /F
REG DELETE "HKEY_CURRENT_USER\Software\Gameware Development\World Switcher" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Gameware Development\World Switcher" /F
REG DELETE "HKEY_CURRENT_USER\Software\Cyberlife Technology\World Switcher" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Cyberlife Technology\World Switcher" /F
REG DELETE "HKEY_CURRENT_USER\Software\Cyberlife Technology\Creatures 2" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Cyberlife Technology\Creatures 2" /F
REG DELETE "HKEY_CURRENT_USER\Software\Millennium Interactive\Creatures 2" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Millennium Interactive\Creatures 2" /F

:: ----- CONFIGURATION -----
SET installdir=C:\Program Files\Creatures 2
:: By default, because I like it, you will be in cheat mode. If you want to switch to normal mode, change this to 'User'
set privileges=Blueberry4$
:: A vanilla install sets maxnorns to 16.
set maxnorns=30
:: I like to open all of the kits, but a vanilla install restricts this to 3.
set maxkits=30
:: -------------------------

:: Configure default paths. See 'installdir' in configuration.
SET regpath="HKEY_LOCAL_MACHINE\SOFTWARE\Gameware Development\Creatures 2\1.0"
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

:: Configure tools and defaults.
SET regpath="HKEY_CURRENT_USER\SOFTWARE\Gameware Development\Creatures 2\1.0"
REG ADD %regpath% /v "Privileges" /t REG_SZ /d "%privileges%" /f
REG ADD %regpath% /v "MaxNorns" /t REG_DWORD /d "%maxnorns%" /f
REG ADD %regpath% /v "MaxKits" /t REG_DWORD /d "%maxkits%" /f

exit
