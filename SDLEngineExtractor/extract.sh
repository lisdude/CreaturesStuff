#!/bin/bash

#####
# Docking Station SDL Engine Extractor
#
# This script is intended to extract a complete Docking Station installation (with SDL engine rather than DirectX)
# from the original Windows installer. It puts the completed 'install' into a directory called "Docking Station"
# Tested in macOS and the Windows Subsystem for Linux (WSL)
#####

# First make sure the Docking Station installer is here. Should the link go down, try these alternatives:
# https://eemfoo.org/archive/downloads/d238?download=true
# https://lisdude.com/Creatures/dockingstation_195.exe
if ! [ -f "dockingstation_195.exe" ]; then
    echo "You need a Docking Station installer to continue. Try here: http://www.creaturesdockingstation.com/dockingstation_195.exe"
    exit
fi

# If md5sum is available, verify the installer is good. If not... oh well. Nothing can go wrong!
if [ -x "$(command -v md5sum)" ]; then
    if [ "$(md5sum dockingstation_195.exe)" != "612525796c137604fb8083015a845ca9  dockingstation_195.exe" ]; then
    echo "Either dockingstation_195.exe isn't a proper Docking Station installer or the file is corrupt. Try downloading it again."
    exit
fi
fi

# This works with BSD tar, but not WSL tar. So unzip it is!
if ! [ -x "$(command -v unzip)" ]; then
    echo "You need the 'unzip' command to continue."
    exit
fi

if ! [ -x "$(command -v bzip2)" ]; then
    echo "You need the 'bzip2' command to continue."
    exit
fi

if [ -d "Docking Station" ]; then
    echo "It looks like you already have an extracted installation. If you want to start over, delete the 'Docking Station' directory and try again."
    exit
fi

echo "Extracting..."
unzip -q "./dockingstation_195.exe"

if ! [ -d "dsbuild 195" ]; then
    echo "Extraction failed."
    exit
fi

# Remove random garbage files from the installer.
rm -rf {cdtastic,directx_setup,dsbuild.bz2.txt,dsetup.dll,InstallBlast.exe,splash,splash.bmp}

mkdir Docking\ Station

cd dsbuild\ 195

# DirectX is for chumps, get outta here.
rm -rf "./win32_directx"

echo "Decompressing... this may take a moment!"
find . -name "*.bz2" -exec bzip2 -d {} \;

# Move our tidily decompressed files to their new home.
mv global/* ../Docking\ Station
mv win32_sdl/* ../Docking\ Station

# Clean up after ourselves.
cd ../
rm -rf dsbuild\ 195
rm -rf ./Docking\ Station/{file_list*.txt,InstallBlast.exe}

echo "Done! You should now have a complete, working SDL installation in 'Docking Station'. Have fun!"
