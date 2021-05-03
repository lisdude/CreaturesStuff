# CreaturesStuff
As I've been getting back into Creatures, I've noticed a couple of issues that made it slightly less enjoyable than it could be to get going. This repository is just a collection of things I've found useful for getting the game running in Windows 10 with a high DPI display. And I'll probably dump other random things here as well.

## Semi-Painless Initial Installation
1. Change the installation directory to `C:\YOUR_USERNAME\Documents\Creatures`
2. Run `FixRegistry.cmd` as an administrator. This is the stock installer registry commands with a couple of tweaks. First, it removes the space to fix the infamous "Creatures " (Creatures with a space after it) path issue. It also removes an extraneous slash from one of the paths and adds a bit at the end to unlock the DPI settings within Windows.
3. Install [Creatures Remastered Patch](http://www.webpetz.com/creatures/remasters.php), but say no to fixing My Documents. I don't know what that's supposed to do but I never noticed it have any effect. And saying no doesn't harm anything.
4. Move the [Recommended Add-ons](https://creatures.wiki/Creatures_3_%26_Docking_Station_Community_Recommended_Fixes_and_Addons) into the appropriate C3 and DS folders of [Creatures Add-on Installer](https://github.com/lisdude/CreaturesAddonInstaller) and run said installer.

## Other Stuff
- `UNINSTALL.cmd` is just an easy way to clean up all of the registry entries that the Creatures Exodus installer makes. It was handy for testing. Should be run as an administrator.
