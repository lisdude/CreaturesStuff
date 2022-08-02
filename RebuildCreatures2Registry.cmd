@echo off

:: This batch file will delete existing Creatures 2 / World Switcher registry keys and replace them with a minimum set necessary to launch the game.
:: NOTE: This was created and used only in a Windows XP environment. You may find it necessary to make changes for Windows 10 or above, specifically to the installdir and userdir.
:: MOAR NOTEZ: The location of 'MaxNorns' and 'MaxKits' differs between versions. In version 38 and below, it looks in HKEY_LOCAL_MACHINE. In 39, it looks in HKEY_CURRENT_USER. For simplicity, this file will populate both. Just beware if you're looking to change it in the future.

:: Delete existing registry keys:
REG DELETE "HKEY_CURRENT_USER\Software\Gameware Development\Creatures 2" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Gameware Development\Creatures 2" /F
REG DELETE "HKEY_CURRENT_USER\Software\Gameware Development\World Switcher" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Gameware Development\World Switcher" /F
REG DELETE "HKEY_CURRENT_USER\Software\Cyberlife Technology\Creatures 2" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Cyberlife Technology\Creatures 2" /F
REG DELETE "HKEY_CURRENT_USER\Software\Cyberlife Technology\World Switcher" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Cyberlife Technology\World Switcher" /F


:: ----- CONFIGURATION -----
:: This is where your Creatures 2 is installed. NOTE: GOG installs to "C:\GOG Games\Creatures 2" by default, not Program Files.
SET installdir=C:\Program Files\Creatures 2
:: Cheat mode: Enabled by default. If you want to switch to normal mode (vanilla install), change this to 'User'
set privileges=Blueberry4$
:: Maximum number of Norns in the world. A vanilla install sets maxnorns to 16. 
set maxnorns=30
:: Maximum number of kits you can open at once. Vanilla install restricts this to 3.
set maxkits=30
:: The company name for your version. GOG and Steam should remain "Gameware Development", but earlier releases may be "Cyberlife Technology".
set company=Gameware Development
:: -------------------------

:: Configure default paths. See 'installdir' in configuration.
SET regpath="HKEY_LOCAL_MACHINE\SOFTWARE\%company%\Creatures 2\1.0"
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
