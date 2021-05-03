@echo off

FOR /F "usebackq tokens=3*" %%A IN (`REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Creatures Exodus" /v Path`) DO (
    set {app}=%%A%%B
    )

SET regpath="HKEY_CURRENT_USER\Software\Gameware Development\Creatures 3"
REG ADD %regpath% /v "Default Background" /t REG_SZ /d "c3_splash" /f /reg:32
REG ADD %regpath% /v "Language" /t REG_SZ /d "en-GB" /f /reg:32

SET regpath="HKEY_CURRENT_USER\Software\Gameware Development\Creatures Engine"
REG ADD %regpath% /v "Default Game" /t REG_SZ /d "Docking Station" /f /reg:32

SET regpath="HKEY_CURRENT_USER\Software\Gameware Development\Docking Station\InstallBlast"
REG ADD %regpath% /v "Language" /t REG_DWORD /d "00000064" /f /reg:32

SET regpath="HKEY_LOCAL_MACHINE\SOFTWARE\Gameware Development\CIE"
REG ADD %regpath% /v "Lang Set" /t REG_DWORD /d "00000001" /f /reg:32

SET regpath="HKEY_LOCAL_MACHINE\SOFTWARE\Gameware Development\Creatures 3"
REG ADD %regpath% /v "Backgrounds Directory" /t REG_SZ /d "%{app}%\Creatures 3\Backgrounds\\" /f /reg:32
REG ADD %regpath% /v "Body Data Directory" /t REG_SZ /d "%{app}%\Creatures 3\Body Data\\" /f /reg:32
REG ADD %regpath% /v "Bootstrap Directory" /t REG_SZ /d "%{app}%\Creatures 3\Bootstrap\\" /f /reg:32
REG ADD %regpath% /v "Catalogue Directory" /t REG_SZ /d "%{app}%\Creatures 3\Catalogue\\" /f /reg:32
REG ADD %regpath% /v "Creature Database Directory" /t REG_SZ /d "%{app}%\Creatures 3\Creature Galleries\\" /f /reg:32
REG ADD %regpath% /v "Display Type" /t REG_DWORD /d "00000000" /f /reg:32
REG ADD %regpath% /v "Exported Creatures Directory" /t REG_SZ /d "%{app}%\Creatures 3\My Creatures\\" /f /reg:32
REG ADD %regpath% /v "Genetics Directory" /t REG_SZ /d "%{app}%\Creatures 3\Genetics\\" /f /reg:32
REG ADD %regpath% /v "Images Directory" /t REG_SZ /d "%{app}%\Creatures 3\Images\\" /f /reg:32
REG ADD %regpath% /v "Journal Directory" /t REG_SZ /d "%{app}%\Creatures 3\Journal\\" /f /reg:32
REG ADD %regpath% /v "Main Directory" /t REG_SZ /d "%{app}%\Creatures 3\\" /f /reg:32
REG ADD %regpath% /v "Overlay Data Directory" /t REG_SZ /d "%{app}%\Creatures 3\Overlay Data\\" /f /reg:32
REG ADD %regpath% /v "Resource Files Directory" /t REG_SZ /d "%{app}%\Creatures 3\My Agents\\" /f /reg:32
REG ADD %regpath% /v "Sounds Directory" /t REG_SZ /d "%{app}%\Creatures 3\Sounds\\" /f /reg:32
REG ADD %regpath% /v "Worlds Directory" /t REG_SZ /d "%{app}%\Creatures 3\My Worlds\\" /f /reg:32

SET regpath="HKEY_LOCAL_MACHINE\SOFTWARE\Gameware Development\Docking Station"
REG ADD %regpath% /v "Backgrounds Directory" /t REG_SZ /d "%{app}%\Docking Station\Backgrounds\\" /f /reg:32
REG ADD %regpath% /v "Body Data Directory" /t REG_SZ /d "%{app}%\Docking Station\Body Data\\" /f /reg:32
REG ADD %regpath% /v "Bootstrap Directory" /t REG_SZ /d "%{app}%\Docking Station\Bootstrap\\" /f /reg:32
REG ADD %regpath% /v "Catalogue Directory" /t REG_SZ /d "%{app}%\Docking Station\Catalogue\\" /f /reg:32
REG ADD %regpath% /v "Creature Database Directory" /t REG_SZ /d "%{app}%\Docking Station\Creature Galleries\\" /f /reg:32
REG ADD %regpath% /v "Exported Creatures Directory" /t REG_SZ /d "%{app}%\Docking Station\My Creatures\\" /f /reg:32
REG ADD %regpath% /v "Genetics Directory" /t REG_SZ /d "%{app}%\Docking Station\Genetics\\" /f /reg:32
REG ADD %regpath% /v "Images Directory" /t REG_SZ /d "%{app}%\Docking Station\Images\\" /f /reg:32
REG ADD %regpath% /v "Journal Directory" /t REG_SZ /d "%{app}%\Docking Station\Journal\\" /f /reg:32
REG ADD %regpath% /v "Main Directory" /t REG_SZ /d "%{app}%\Docking Station\\" /f /reg:32
REG ADD %regpath% /v "Overlay Data Directory" /t REG_SZ /d "%{app}%\Docking Station\Overlay Data\\" /f /reg:32
REG ADD %regpath% /v "Resource Files Directory" /t REG_SZ /d "%{app}%\Docking Station\My Agents\\" /f /reg:32
REG ADD %regpath% /v "Sounds Directory" /t REG_SZ /d "%{app}%\Docking Station\Sounds\\" /f /reg:32
REG ADD %regpath% /v "Users Directory" /t REG_SZ /d "%{app}%\Docking Station\Users\\" /f /reg:32
REG ADD %regpath% /v "Worlds Directory" /t REG_SZ /d "%{app}%\Docking Station\My Worlds\\" /f /reg:32

SET regpath="HKEY_LOCAL_MACHINE\SOFTWARE\Gameware Development\Docking Station\InstallBlast"
REG ADD %regpath% /v "CD Path" /t REG_SZ /d "" /f /reg:32
REG ADD %regpath% /v "Creatures3InstalledLastTime" /t REG_DWORD /d "00000001" /f /reg:32
REG ADD %regpath% /v "Current Build" /t REG_SZ /d "dsbuild 195" /f /reg:32
REG ADD %regpath% /v "Directory" /t REG_SZ /d "%{app}%\Docking Station\\" /f /reg:32
REG ADD %regpath% /v "Language" /t REG_DWORD /d "00000064" /f /reg:32
REG ADD %regpath% /v "Warn No Updates If Offline" /t REG_DWORD /d "00000001" /f /reg:32

SET regpath="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"
REG DELETE %regpath% /v "%{app}%\Creatures 3\engine.exe" /f
REG DELETE %regpath% /v "%{app}%\Docking Station\engine.exe" /f

SET regpath="HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"
REG DELETE %regpath% /v "%{app}%\Creatures 3\engine.exe" /f
REG DELETE %regpath% /v "%{app}%\Docking Station\engine.exe" /f

exit