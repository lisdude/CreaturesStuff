This script will 'install' Docking Station for Linux. And by 'install' I mean create a DockingStation directory that you can launch the game from.

## Usage
1. Download a copy of `dockingstation_195_64.tar.bz2` into the same directory as the script.
2. If you want to play Creatures 3 docked or stand-alone, copy your full `Creatures 3` directory into the same place as the script. WARNING: Part of the installation involves lowercasing all file names, so your C3 directory will be altered.
3. Run the script: `./install_dockingstation.sh`

The script itself only has one configuration option, and that's where to 'install' to. Feel free to change it or just move the `DockingStation` directory after the fact.

## Scaling Issues
Linux is weird about DPI scaling, so you may find the window is teeny-tiny. If this is the case, there's another script here called `dpi_fix.sh` that may help. Just run it after your normal installation. (If you know a better option for scaling, please let me know!)

## Caveats
- Sound seems to be hit or miss.
- Some virtual machines had issues with the arrow keys when using the DPI fix.
