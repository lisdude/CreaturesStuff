## Install Docking Station / Creatures 3 in macOS
This assumes some familiarity with the command line. Buckle up because it's a whole lot of steps!

## Preparation
The first thing you need to do is extract the SDL version of the c2e engine. Luckily, the Docking Station installer comes with both the DirectX and SDL versions. Extra luckily, I've written a script that will make extracting it easy. Do the following in your favorite terminal emulator (Terminal.app works too):
1. `cd ~/Downloads`
2. `git clone https://github.com/lisdude/CreaturesStuff.git`
3. `cd CreaturesStuff/SDLEngineExtractor`
4. `curl -O http://www.creaturesdockingstation.com/dockingstation_195.exe` (or copy your local installer or download from the location of your choice)
5. `chmod u+x extract.sh`
6. `./extract.sh`
7. `cd Docking\ Station`
8. `curl -O https://lisdude.com/Creatures/SDL_Updates/SDL.dll -O https://lisdude.com/Creatures/SDL_Updates/SDL_mixer.dll`

If successful, you should end up with a directory called `Docking Station` that has everything you need in it. If you just wanted the SDL engine, you're done. If you intend to create a Wineskin application, you have a couple more steps:

9. `cd ..`
10. `mkdir Creatures\ Docking\ Station && mv Docking\ Station Creatures\ Docking\ Station`
11. `cp ../Misc/FixRegistryWINE.cmd ./Creatures\ Docking\ Station`

If you intend to run Docking Station alongside Creatures 3, you'll also need a new machine.cfg file:

12. `cp ../Misc/machine.cfg ./Creatures\ Docking\ Station/Docking\ Station` 

## Creating Wineskin Application
1. Install XQuartz: `brew install --cask xquartz`
2. Install [WineSkin](https://github.com/Gcenx/WineskinServer): `brew install --no-quarantine gcenx/wine/unofficial-wineskin`
3. Launch `Wineskin Winery.app`. If it mentions any updates, click update.
4. Click '+' to add a new engine. Choose the topmost non-64-bit option. (At the time of writing, that is 'WS11WineCX21.2.0') Click 'Download and Install'.
5. Click 'Create New Blank Wrapper' and name it whatever. Something like Creatures. This will install to "~/Applications/Wineskin/Creatures.app". When finished, click 'View wrapper in Finder'.
6. Right-click on 'Creatures.app' and select 'Show Package Contents'. You should be in "~/Applications/Wineskin/Creatures.app/". Now open `Wineskin.app` and choose 'Advanced'. Click 'Options' tab and uncheck 'Map User Mac OS X folders in wrapper.' 
7. Click 'Set Screen Options' and choose 'Mac Driver'. Ensure 'Retina Mode' is unchecked. Close that window.
8. Click 'Install Software' and 'Copy a Folder Inside'. If you followed the preparation steps above, you want: `~/Downloads/CreaturesStuff/SDLEngineExtractor/Creatures Docking Station`. If it prompts you to choose an executable, click 'OK'.
9. Click 'Tools', 'Command Line (cmd)'.
10. Type: `"C:\Program Files\Creatures Docking Station\FixRegistryWINE.cmd"` and hit enter. (Make sure you leave the quotes.) The command prompt will close when it's finished.
11. Back in Wineskin, go back to the 'Configuration' tab. Change 'Windows EXE' to: `"C:\Program Files\Creatures Docking Station\Docking Station\engine.exe" --autokill` if it's not already there.
12. If you have a Creatures 3 install and want to run a docked world, go back into `~/Applications/Wineskin/Creatures.app/Wineskin.app`, Advanced, Install Software, Copy a Folder Inside, and choose your Creatures 3 directory. Then go to Tools - Command Line (cmd). Type: `move "C:\Program Files\Creatures 3" "C:\Program Files\Creatures Docking Station"`. Now type `exit`

Now, assuming the stars aligned and everything worked, you should be able to start Docking Station just by launching `Creatures.app`.

Note: If you get a prompt to insert a CD-ROM, go back to your terminal and type: `touch ~/Applications/Wineskin/Creatures.app/drive_c/windows/system32/msnope32.dll`

### Installing Add-Ons and Whatnot
- In Finder, hit CMD-SHIFT-G and paste: `~/Applications/Wineskin/Creatures.app/drive_c/Program Files/Creatures Docking Station`
- From there you can copy files to whichever Docking Station of Creatures 3 folders you need to.

Since this guide only installs the default Docking Station, you will almost surely want to go through and replace the Bootstrap directory with the one from Steam. Or, at the very least, a patch that disables login.

### Installing Tools
Before you install any tools, make sure MFC42 is properly installed:
1. Launch Wineskin config from `~/Applications/Wineskin/Creatures/Wineskin.app`
2. Click Advanced - Tools - Winetricks
3. Search `MFC42` and make sure the box is checked. Click 'Run' and 'Yes'

Now for each tool...
1. Launch Wineskin config from `~/Applications/Wineskin/Creatures.app/Wineskin.app`
2. Click Advanced - Tools - Install Software
3. Choose 'Copy a Folder Inside' and pick your directory.
4. Now click 'Custom EXE Creator'. Give it a name and a path to the Windows EXE. (It should be in `C:\Program Files\xxx`). Save.
5. The .app for your tool will be in `~/Applications/Wineskin/Creatures.app/<xxx>.app`

I haven't really tested any tools except for the CAOS debugger, so results may vary.
