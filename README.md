# CreaturesStuff
As I've been getting back into Creatures, I've noticed a couple of issues that made it slightly less enjoyable than it could be to get going. This repository is just a collection of things I've found useful for getting the game running in Windows 10 with a high DPI display. And I'll probably dump other random things here as well. Note that these instructions apply to the GOG release, not the Steam one. However, the 'Wipe and Start Over' section is still useful for making sure you're starting completely fresh for a Steam install.

## Semi-Painless Initial Installation (GOG Release)
1. Change the installation directory to `C:\Users\YOUR_USERNAME\Documents\Creatures` and install. DO NOT CLICK 'Launch' at the end!
2. Download `FixRegistry.cmd` from here. Right-click on it and choose 'Run as Administrator'. This is the stock installer registry commands with a couple of tweaks. First, it removes the space to fix the infamous "Creatures " (Creatures with a space after it) path issue. It also removes an extraneous slash from one of the paths and adds a bit at the end to unlock the DPI settings within Windows.
3. Install [Creatures Remastered Patch](http://www.webpetz.com/creatures/remasters.php), but say no to fixing My Documents. I don't know what that's supposed to do but I never noticed it have any effect. And saying no doesn't harm anything.
4. Move the [Recommended Add-ons](https://creatures.wiki/Creatures_3_%26_Docking_Station_Community_Recommended_Fixes_and_Addons) and/or your favorite add-ons into the appropriate C3 and DS folders of [Creatures Add-on Installer](https://github.com/lisdude/CreaturesAddonInstaller) and run said installer.
5. Launch the game from the 'Docking Station' shortcut, not the 'Creatures Exodus' shortcut. If you plan to play Creatures 3 without Docking Station, read on...

### Creatures 3 (Without Docking Station) (GOG Release)
At this point, Docking Station should work just fine. Plain Creatures 3, however, has a couple of issues we'll need to correct.

1. Navigate to `C:\Users\YOUR_USERNAME\Documents\Creatures\Creatures 3`
2. Find `engine.exe` and right-click on it. Go to 'Properties' and click the 'Compatibility' tab.
3. Check the 'Run this program in compatibility mode for:' box and choose 'Windows XP' from the drop-down menu.
4. Check the 'Reduced color mode' box and choose '16-bit' from the drop-down menu. Click Ok.
5. Start the game from the 'Creatures Exodus' shortcut. NOTE: Don't start it directly from 'engine.exe'!
6. Hit ALT-Enter to exit fullscreen mode. It will complain about 16-bit color and everything will get weird. Close the window.
7. Now launch 'Creatures Exodus' again (remember, always use the shortcut) and everything should look normal! Resize the window however is comfortable and have fun.

## Recommendations For Broken Installs (Wipe and Start Over)
This is the section for you if you receive error messages when launching the games, things are being put in the wrong place, you want to delete everything for a new Steam install, or you've tried a lot of different fixes for a lot of different problems and everything has gone weird. I find the best approach to fixing these problems is to start over from scratch, ensuring that everything you can possibly delete has been deleted.

1. Save all of your exported creatures (if applicable). We're going to delete everything.
2. *Creatures Exodus*: Start - Add or Remove Programs. Select 'Creatures Exodus' and click 'Uninstall'. Since we already made our own backups, and we don't necessarily know where your files are living, say no when it asks if you want to keep your saved games. Repeat for 'GOG.com C3 Docking Station' if it's in the list.
3. *Creatures on Steam*: Find 'Creatures Docking Station' in your library. Right-click on it, select 'Manage', and choose 'Uninstall'. 
4. Check for lingering files from previous installations. If you see a folder called `Creatures` or `Creatures Exodus` or `Docking Station`, delete it. Here are some places to check:
    - C:\Users\<YOUR USERNAME>\Documents
    - C:\GOG Games\
    - C:\Program Files (x86)
    - C:\Program Files (x86)\Steam\steamapps\common\Creatures Docking Station
5. Download `UNINSTALL.cmd` from here. Right-click on it and choose 'Run as Administrator'. This will remove any lingering registry entries.
6. Follow the installation steps at the top of the page to do a clean install.

## Other Stuff
- `UNINSTALL.cmd` is just an easy way to clean up all of the registry entries that the Creatures Exodus and Steam installers make. It was handy for testing. Should be run as an administrator. **NOTE**: This will delete registry keys for GOG installs, Steam installs, and some Creatures tools. It should only be used if you intend to reinstall.
