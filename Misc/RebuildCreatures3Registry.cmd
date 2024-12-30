@echo off
setlocal

:: This batch file will delete existing Creatures 3 / Docking Station registry keys and replace them with a minimum set necessary to launch the game.

:: ----- CONFIGURATION -----
:: This is where your Docking Station is installed.
SET dsinstalldir=C:\Program Files (x86)\Steam\steamapps\common\Creatures Docking Station\Docking Station
:: This is where your Creatures 3 is installed.
SET c3installdir=C:\Program Files (x86)\Steam\steamapps\common\Creatures Docking Station\Creatures 3
:: The company name mildly tricky. The default here is for Steam, which uses build 286. If you're using build 296, use 'Gameware Development'
SET company=CyberLife Technology
:: -------------------------

:: Delete existing registry keys:
REG DELETE "HKEY_CURRENT_USER\Software\Gameware Development\Creatures 3" /F
REG DELETE "HKEY_CURRENT_USER\Software\Gameware Development\Docking Station" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\CyberLife Technology\Docking Station" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\CyberLife Technology\Creatures 3" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Gameware Development\Creatures 3" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Gameware Development\Docking Station" /F
SET regpath="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"
REG DELETE %regpath% /v "%c3installdir%\Creatures 3\engine.exe" /f
REG DELETE %regpath% /v "%dsinstalldir%\Docking Station\engine.exe" /f
SET regpath="HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"
REG DELETE %regpath% /v "%c3installdir%\Creatures 3\engine.exe" /f
REG DELETE %regpath% /v "%dsinstalldir%\Docking Station\engine.exe" /f

SET regpath="HKEY_LOCAL_MACHINE\SOFTWARE\%company%\Creatures 3"
REG ADD %regpath% /v "Backgrounds Directory" /t REG_SZ /d "%c3installdir%\Backgrounds\\" /f
REG ADD %regpath% /v "Body Data Directory" /t REG_SZ /d "%c3installdir%\Body Data\\" /f
REG ADD %regpath% /v "Bootstrap Directory" /t REG_SZ /d "%c3installdir%\Bootstrap\\" /f
REG ADD %regpath% /v "Catalogue Directory" /t REG_SZ /d "%c3installdir%\Catalogue\\" /f
REG ADD %regpath% /v "Creature Database Directory" /t REG_SZ /d "%c3installdir%\Creature Galleries\\" /f
REG ADD %regpath% /v "Exported Creatures Directory" /t REG_SZ /d "%c3installdir%\My Creatures\\" /f
REG ADD %regpath% /v "Genetics Directory" /t REG_SZ /d "%c3installdir%\Genetics\\" /f
REG ADD %regpath% /v "Images Directory" /t REG_SZ /d "%c3installdir%\Images\\" /f
REG ADD %regpath% /v "Journal Directory" /t REG_SZ /d "%c3installdir%\Journal\\" /f
REG ADD %regpath% /v "Main Directory" /t REG_SZ /d "%c3installdir%\\" /f
REG ADD %regpath% /v "Overlay Data Directory" /t REG_SZ /d "%c3installdir%\Overlay Data\\" /f
REG ADD %regpath% /v "Resource Files Directory" /t REG_SZ /d "%c3installdir%\My Agents\\" /f
REG ADD %regpath% /v "Sounds Directory" /t REG_SZ /d "%c3installdir%\Sounds\\" /f
REG ADD %regpath% /v "Worlds Directory" /t REG_SZ /d "%c3installdir%\My Worlds\\" /f

:: This is actually superfluous, as the engine will set this based on machine.cfg. But why not.
SET regpath="HKEY_LOCAL_MACHINE\SOFTWARE\%company%\Docking Station"
REG ADD %regpath% /v "Backgrounds Directory" /t REG_SZ /d "%dsinstalldir%\Backgrounds\\" /f
REG ADD %regpath% /v "Body Data Directory" /t REG_SZ /d "%dsinstalldir%\Body Data\\" /f
REG ADD %regpath% /v "Bootstrap Directory" /t REG_SZ /d "%dsinstalldir%\Bootstrap\\" /f
REG ADD %regpath% /v "Catalogue Directory" /t REG_SZ /d "%dsinstalldir%\Catalogue\\" /f
REG ADD %regpath% /v "Creature Database Directory" /t REG_SZ /d "%dsinstalldir%\Creature Galleries\\" /f
REG ADD %regpath% /v "Exported Creatures Directory" /t REG_SZ /d "%dsinstalldir%\My Creatures\\" /f
REG ADD %regpath% /v "Genetics Directory" /t REG_SZ /d "%dsinstalldir%\Genetics\\" /f
REG ADD %regpath% /v "Images Directory" /t REG_SZ /d "%dsinstalldir%\Images\\" /f
REG ADD %regpath% /v "Journal Directory" /t REG_SZ /d "%dsinstalldir%\Journal\\" /f
REG ADD %regpath% /v "Main Directory" /t REG_SZ /d "%dsinstalldir%\\" /f
REG ADD %regpath% /v "Overlay Data Directory" /t REG_SZ /d "%dsinstalldir%\Overlay Data\\" /f
REG ADD %regpath% /v "Resource Files Directory" /t REG_SZ /d "%dsinstalldir%\My Agents\\" /f
REG ADD %regpath% /v "Sounds Directory" /t REG_SZ /d "%dsinstalldir%\Sounds\\" /f
REG ADD %regpath% /v "Users Directory" /t REG_SZ /d "%dsinstalldir%\Users\\" /f
REG ADD %regpath% /v "Worlds Directory" /t REG_SZ /d "%dsinstalldir%\My Worlds\\" /f

endlocal
