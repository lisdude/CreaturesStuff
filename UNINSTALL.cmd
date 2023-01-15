@echo off

:: Gameware Development
REG DELETE "HKEY_CURRENT_USER\Software\Gameware Development" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Gameware Development" /F
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Gameware Development" /F
REG DELETE "HKEY_CLASSES_ROOT\VirtualStore\MACHINE\SOFTWARE\WOW6432Node\Gameware Development" /F

:: Cyberlife Technology
REG DELETE "HKEY_CURRENT_USER\Software\Cyberlife Technology" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Cyberlife Technology" /F
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\CyberLife Technology" /F
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\App Paths\Creatures Exodus" /F
REG DELETE "HKEY_CLASSES_ROOT\VirtualStore\MACHINE\SOFTWARE\WOW6432Node\CyberLife Technology" /F
REG DELETE "HKEY_CURRENT_USER\Software\Classes\VirtualStore\MACHINE\SOFTWARE\WOW6432Node\CyberLife Technology" /F

:: Creature Labs
REG DELETE "HKEY_CURRENT_USER\Software\Creature Labs" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Creature Labs" /F
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Creature Labs" /F

:: Millennium Interactive
REG DELETE "HKEY_CURRENT_USER\Software\Millennium Interactive" /F
REG DELETE "HKEY_LOCAL_MACHINE\Software\Millennium Interactive" /F

:: Misc
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Creatures Exodus" /F
Rem REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\GOG.com" /F

exit
