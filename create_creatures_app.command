#!/usr/bin/env bash

set -euf -o pipefail

#####
# Creatures Docking Station App Bundle Creator
#
# This script uses Wineskin Winery to create a working .app for Creatures Docking Station,
# Creatures 3, and the various kits and tools associated with it.
#
# Last Updated: 2023-02-23
#####

# create_app(Name, Executable, ?Command line arguments)
# Create 'custom EXE' app bundle.
create_app () {
    cp -r "${apppath}/Wineskin.app/Contents/Resources/CustomEXE.app" "${apppath}/${1}.app"
    /usr/libexec/PlistBuddy -c "Set :\"Program Name and Path\" \"${2}\"" "${apppath}/${1}.app/Contents/Info.plist.cexe"

    if [[ $# -ge 3 ]]; then
        /usr/libexec/PlistBuddy -c "Set :\"Program Flags\" \"${3}\"" "${apppath}/${1}.app/Contents/Info.plist.cexe"
    fi

# The updated Wineskin EXE script seems to remove quotations, which makes it fail on apps with spaces in the name. Let's put them back...
sed -i '' 's|cd ${MACOSFOLD}|cd "${MACOSFOLD}"|' "${apppath}/${1}.app/Contents/MacOS/CustomEXE"
}

##### Constants:
ds_download="https://lisdude.com/Creatures/dockingstation_195.exe"
# NOTE: If this download fails, try these alternatives:
# https://eemfoo.org/archive/downloads/d238?download=true
# http://www.creaturesdockingstation.com/dockingstation_195.exe

# Running by, say, double-clicking on the desktop sets pwd to $HOME. This changes it back to wherever the script launched from.
launchdir=$(dirname "$0")
cd "${launchdir}"
#####

# Check if 'CreaturesTEMP' already exists and give the opportunity to delete it before starting.
# Otherwise the script will just re-use any downloads.
if [ -d "CreaturesTEMP" ]; then
    read -p "It looks like you've already run this script here. Do you want to delete the existing directory and start over? WARNING: The directory 'CreaturesTEMP' will be deleted. [y/N] " answer
    if [[ $answer =~ [Yy] ]]; then
        rm -rf "CreaturesTEMP"
    fi
fi

##### Check Arguments
steamdir=""
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        --dir)
            steamdir="$2"
            shift
            shift
            ;;
        *)
            shift
            ;;
    esac
done
#####

# Introduce the script and allow them to bail out if they don't like the sound of things.
echo "Oh, hello. This script will automatically(ish) create a working Creatures 3 / Docking Station app bundle."
echo "To accomplish this, it will do several things on your behalf that you should be aware of:"
echo ""
echo "1. Download Wineskin Winery and steamcmd to a temporary directory (if not already installed)."
echo "2. Download a script and the Docking Station Windows installer to extract the c2e SDL engine.";
echo "3. Download Docking Station from Steam. This will require your Steam password to verify that you've purchased the game."
echo ""
echo "NOTE: If you don't want to download from Steam, you can use the --dir option to specify the path of an existing Docking Station install."
echo "      e.g. ./create_creatures_app --dir ~/Downloads/steam"
echo ""

read -p "Ready to proceed? [y/N] " answer
if [[ ! $answer =~ [Yy] ]]; then
    echo "Aborting!"
    exit 1
fi

# Create the temporary directory where all of our downloads will go.
mkdir -p "CreaturesTEMP" 2>/dev/null || { echo "Couldn't create CreaturesTEMP directory. Aborting."; exit; }
cd "CreaturesTEMP"
creaturesdir=$(pwd)

echo "Downloading and preparing prerequisites..."

# If there's no command line DS specified, install steamcmd (if not already installed)
if [[ -z "${steamdir}" ]]; then
    if [[ -x $(command -v steamcmd) ]]; then
        steamcmd="steamcmd"
    else
        if [[ ! -f "${creaturesdir}/steamcmd.sh" ]]; then
            curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_osx.tar.gz" | tar zxf -
        fi
        steamcmd="${creaturesdir}/steamcmd.sh"
    fi
fi

# Install Wineskin Winery or use a version in /Applications if found
if [[ -d "/Applications/Wineskin Winery.app" ]]; then
    wineskinbin="/Applications/Wineskin Winery.app"
else
    wineskinbin="${creaturesdir}/Wineskin Winery.app"
    if [[ ! -d "${creaturesdir}/Wineskin Winery.app" ]]; then
        curl -sqLf https://github.com/Gcenx/WineskinServer/releases/download/V1.8.4.2/Wineskin.Winery.txz -o Wineskin.txz 2>/dev/null || { echo "Failed to download Wineskin Winery."; exit; }
        #LATEST_RELEASE_URL=$(curl --silent "https://api.github.com/repos/Gcenx/WineskinServer/releases/latest?prerelease=true" | grep '"tarball_url":' | awk '{print $2}' | tr -d '",')
        #curl -L "${LATEST_RELEASE_URL}" -o wineskin.tar.gz
        xattr -drs com.apple.quarantine Wineskin.txz
        #tar -xzf wineskin.tar.gz
        tar -xzf Wineskin.txz
    fi
fi

# Grab winetricks
if [[ ! -f "${creaturesdir}/winetricks" ]]; then
    curl -sqLfO https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
    #    curl -L -O https://raw.githubusercontent.com/The-Wineskin-Project/winetricks/macOS/src/winetricks
fi

# Grab my SDL extraction script.
if [[ ! -f "extract.sh" ]]; then
    curl -sqLfO https://raw.githubusercontent.com/lisdude/CreaturesStuff/main/SDLEngineExtractor/extract.sh 2>/dev/null || { echo "Failed to download SDL engine extractor."; exit; }
fi

# Download the Windows Docking Station installer.
if [[ ! -f "dockingstation_195.exe" ]]; then
    curl -sqLfO ${ds_download} 2>/dev/null || { echo "Unable to download Docking Station. Try editing this script to use an alternative URL."; exit; }
fi

echo "Extracting the SDL engine.exe. This may take a moment..."

# Extract the SDL engine and replace the SDL DLLs with shiny 2022 versions.
chmod u+x extract.sh
./extract.sh
cd Docking\ Station
curl -sqLfO https://lisdude.com/Creatures/SDL_Updates/SDL.dll -O https://lisdude.com/Creatures/SDL_Updates/SDL_mixer.dll 2>/dev/null || { echo "Unable to download updated SDL DLLs. You'll probably need to compile them yourself or check archive.org. Sorry!"; exit; }

# Now the manual intervention part. Launch Wineskin Winery and instruct the user how to create a wrapper. Then wait for it to appear.
if [[ ! -d ~/Applications/Wineskin/Creatures.app ]]; then
    open "${wineskinbin}"

    printf "\e[1;32m--------------------\e[0m\n"
    echo "This script has launched Wineskin Winery for you. You must, sadly, manually configure a wrapper:"
    echo "1. Click the 'Update' button if it's available at the bottom."
    echo "2. Click the '+' button next to 'New Engine(s) available!'"
    echo "3. Choose 'WS11WineCX21.2.0' from the drop-down menu. Click 'Download and Install'. Make sure you DON'T get one that says '64Bit'."
    echo "4. Click 'Create New Blank Wrapper'. Name it 'Creatures' and click OK."
    echo "5. Click 'OK' when it informs you that the wrapper has been created. The script will resume after it detects Creatures.app in ~/Applications/Wineskin."
    printf "\e[1;32m--------------------\e[0m\n"

    while [ ! -d ~/Applications/Wineskin/Creatures.app ]
    do
        sleep 1
    done
fi

echo "Configuring the Creatures wrapper..."

# Define various paths for the changes we need to make to the wrapper:
apppath="$HOME/Applications/Wineskin/Creatures.app"
prefix="${apppath}/Contents/SharedSupport/prefix"
winebin="${apppath}/Contents/SharedSupport/wine/bin/wine32on64"

# Add winetricks
cp "${creaturesdir}/winetricks" "${apppath}/Wineskin.app/Contents/Resources"
chmod u+x "${apppath}/Wineskin.app/Contents/Resources/winetricks"

# Disable mapping macOS directories in the wrapper
/usr/libexec/PlistBuddy -c "Set :Symlinks\ In\ User\ Folder false" "${apppath}/Contents/Info.plist"

# Set executable and command line arguments
/usr/libexec/PlistBuddy -c "Set :\"Program Flags\" \"--autokill\"" "${apppath}/Contents/Info.plist"
/usr/libexec/PlistBuddy -c "Set :\"Program Name and Path\" \"/Program Files/Creatures Docking Station/Docking Station/engine.exe\"" "${apppath}/Contents/Info.plist"

# Disable Option and Cmd mappings (is this necessary?)
WINEPREFIX="${prefix}" "${winebin}" reg add "HKEY_CURRENT_USER\\Software\\Wine\\Mac Driver" /v "LeftCommandIsCtrl" /t REG_SZ /d "N" /f >/dev/null 2>&1 || echo "Failed to set LeftCommandIsCtrl option."
WINEPREFIX="${prefix}" "${winebin}" reg add "HKEY_CURRENT_USER\\Software\\Wine\\Mac Driver" /v "LeftOptionIsAlt" /t REG_SZ /d "N" /f >/dev/null 2>&1 || echo "Failed to set LeftOptionIsAlt option."
WINEPREFIX="${prefix}" "${winebin}" reg add "HKEY_CURRENT_USER\\Software\\Wine\\Mac Driver" /v "RightCommandIsCtrl" /t REG_SZ /d "N" /f >/dev/null 2>&1 || echo "Failed to set RightCommandIsCtrl option."
WINEPREFIX="${prefix}" "${winebin}" reg add "HKEY_CURRENT_USER\\Software\\Wine\\Mac Driver" /v "RightOptionIsAlt" /t REG_SZ /d "N" /f >/dev/null 2>&1 || echo "Failed to set RightOptionIsAlt option."

# If --dir wasn't specified, download Docking Station from Steam.
if [[ -z "${steamdir}"  && ! -d "${creaturesdir}/steam" ]]; then
    read -p "Enter your Steam username: " username
    ${steamcmd} +@sSteamCmdForcePlatformType windows +force_install_dir "${creaturesdir}/steam" +login "${username}" +app_update 1659050 validate +quit
    steamdir="${creaturesdir}/steam"
elif [[ -d "${creaturesdir}/steam" ]]; then
    steamdir="${creaturesdir}/steam"
else
    steamdir=$(realpath "${steamdir}")
fi

# Make sure the path ends in a /
if [[ "${steamdir: -1}" != "/" ]]; then
    steamdir="${steamdir}/"
fi

# A quick check to make reasonably sure this is a Steam install.
# You could replace this with a check for any DS file to allow non-Steam versions to work.
if [[ ! -f "${steamdir}ds-installscript.vdf" ]]; then
    echo "The Docking Station directory (${steamdir}) doesn't appear to be a valid Steam install."
    exit 1
fi

# Now copy the Steam install into the wrapper.
echo "Copying installation from ${steamdir} to ${apppath}/drive_c/Program Files..."
cp -r "${steamdir}" "${apppath}/drive_c/Program Files/Creatures Docking Station"
ln -s "./drive_c/Program Files/Creatures Docking Station/Docking Station" "${apppath}/Docking Station"

# Replace the original engine with the SDL engine for both Docking Station and Creatures 3.
cp "${creaturesdir}/Docking Station/"{engine.exe,SDL.dll,SDL_mixer.dll,SDLstretch.dll} "${apppath}/drive_c/Program Files/Creatures Docking Station/Docking Station"
cp "${creaturesdir}/Docking Station/"{engine.exe,SDL.dll,SDL_mixer.dll,SDLstretch.dll} "${apppath}/drive_c/Program Files/Creatures Docking Station/Creatures 3"

# No CD-ROM needed.
touch "${apppath}/drive_c/windows/system32/msnope32.dll"
touch "${apppath}/drive_c/windows/syswow64/msnope32.dll"

# Introduce Docking Station to Creatures 3...
cat >>"${apppath}/drive_c/Program Files/Creatures Docking Station/Docking Station/machine.cfg" <<END
"Auxiliary 1 Backgrounds Directory" "../Creatures 3/Backgrounds/"
"Auxiliary 1 Body Data Directory" "../Creatures 3/Body Data/"
"Auxiliary 1 Bootstrap Directory" "../Creatures 3/Bootstrap/"
"Auxiliary 1 Catalogue Directory" "../Creatures 3/Catalogue/"
"Auxiliary 1 Creature Database Directory" "../Creatures 3/Creature Galleries/"
"Auxiliary 1 Exported Creatures Directory" "../Creatures 3/My Creatures/"
"Auxiliary 1 Genetics Directory" "../Creatures 3/Genetics/"
"Auxiliary 1 Images Directory" "../Creatures 3/Images/"
"Auxiliary 1 Journal Directory" "../Creatures 3/Journal/"
"Auxiliary 1 Main Directory" "../Creatures 3/"
"Auxiliary 1 Overlay Data Directory" "../Creatures 3/Overlay Data/"
"Auxiliary 1 Resource Files Directory" "../Creatures 3/My Agents/"
"Auxiliary 1 Sounds Directory" "../Creatures 3/Sounds/"
"Auxiliary 1 Users Directory" "../Creatures 3/Users/"
"Auxiliary 1 Worlds Directory" "../Creatures 3/My Worlds/"
END

# Give it the Docking Station Icon.
sips -s format icns "${apppath}/drive_c/Program Files/Creatures Docking Station/Docking Station/Docking Station.ico" --out "${apppath}/Contents/Resources/Wineskin.icns" >/dev/null 2>&1 || echo "Failed to add the Docking Station icon."

# Configure Creatures 3...
create_app "Creatures 3" "/Program Files/Creatures Docking Station/Creatures 3/engine.exe" "--autokill"
mkdir -p "${apppath}/drive_c/Program Files/Creatures Docking Station/Creatures 3/Users"

# Give it the C3 icon.
sips -s format icns "${apppath}/drive_c/Program Files/Creatures Docking Station/Creatures 3/Creatures 3.ico" --out "${apppath}/Creatures 3.app/Contents/Resources/Wineskin.icns" >/dev/null 2>&1 || echo "Failed to add the Docking Station icon."

# Add the missing machine.cfg
cat >>"${apppath}/drive_c/Program Files/Creatures Docking Station/Creatures 3/machine.cfg" <<END
"Backgrounds Directory" Backgrounds
"Body Data Directory" "Body Data"
"Bootstrap Directory" Bootstrap
"Catalogue Directory" Catalogue
"Creature Database Directory" "Creature Galleries"
"Display Type" 2
"Exported Creatures Directory" "My Creatures"
"Game Name" "Creatures 3"
"Genetics Directory" Genetics
"Images Directory" Images
"Journal Directory" Journal
"Main Directory" .
"Overlay Data Directory" "Overlay Data"
"Resource Files Directory" "My Agents"
"Sounds Directory" Sounds
"Users Directory" Users
"Worlds Directory" "My Worlds"
END

# Same for user.cfg. It wants to start in fullscreen, but we probably don't want that.
cat >>"${apppath}/drive_c/Program Files/Creatures Docking Station/Creatures 3/user.cfg" <<END
FlightRecorderMask 33
FullScreen 0
END

# Install VB 6 runtime (required for Genetics Kit and probably other utilities)
export PATH="${apppath}/Wineskin.app/Contents/Resources":$PATH
WINEPREFIX="${prefix}" WINEARCH=win32 "${apppath}/Wineskin.app/Contents/Resources/winetricks" vb6run >/dev/null 2>&1 || echo "Failed to install the Visual Basic 6 runtime. The Genetics Kit and other utilities probably won't work."

# Add 'apps' for the science kits.
create_app "Genetics Kit" "/Program Files/Creatures Docking Station/Science Kit/Genetics Kit/Creatures 3 Genetics Kit.exe"
create_app "Biochemistry Kit" "/Program Files/Creatures Docking Station/Science Kit/BiochemistrySet.exe"
create_app "Brain in a Vat" "/Program Files/Creatures Docking Station/Science Kit/Vat.exe"

# Register the Genetics Kit
WINEPREFIX="${prefix}" "${winebin}" reg add "HKEY_CURRENT_USER\\Software\\VB and VBA Program Settings\\Creatures 3 Genetics Kit\\Preferences" /v "Installed" /t REG_SZ /d "yes" /f >/dev/null 2>&1 || echo "Failed to set Genetics Kit registration key #1."
WINEPREFIX="${prefix}" "${winebin}" reg add "HKEY_CURRENT_USER\\Software\\VB and VBA Program Settings\\Creatures 3 Genetics Kit\\Preferences" /v "Registered to" /t REG_SZ /d "Gameware" /f >/dev/null 2>&1 || echo "Failed to set Genetics Kit registration key #2."
WINEPREFIX="${prefix}" "${winebin}" reg add "HKEY_CURRENT_USER\\Software\\VB and VBA Program Settings\\Creatures 3 Genetics Kit\\Preferences" /v "License Key" /t REG_SZ /d "500-4892W-1234U-WE" /f >/dev/null 2>&1 || echo "Failed to set Genetics Kit registration key #3."
WINEPREFIX="${prefix}" "${winebin}" reg add "HKEY_CURRENT_USER\\Software\\VB and VBA Program Settings\\Creatures 3 Genetics Kit\\Preferences" /v "Upgrade Key" /t REG_SZ /d "?" /f >/dev/null 2>&1 || echo "Failed to set Genetics Kit registration key #4."

# Give everything time to finish up.
wait

# Move the final product back to where the script is running from.
mv "${apppath}" "${launchdir}" >/dev/null 2>&1 || { echo "Couldn't move Creatures.app to ${launchdir}. It's likely your terminal application doesn't have full disk permissions. Instead, a Finder window will open and you can move the application manually."; open $HOME/Applications/Wineskin; }

echo ""
printf "\e[1;32m--------------------\e[0m\n"
echo "Done! You should now have ${launchdir}/Creatures.app."
echo "If you right-click on Creatures.app and choose Show Package Contents, you will find additional apps for:"
echo " - Creatures 3"
echo " - Genetics Kit"
echo " - Biochemistry Kit"
echo " - Brain in a Vat"
echo ""
echo "You will also find a folder called 'Docking Station'. This is where you can install agents and other add-ons."
printf "\e[1;32m--------------------\e[0m\n"

read -p "Would you like to delete the temporary files used? [Y/n] " answer
if [[ ! $answer =~ [Nn] ]]; then
    cd "${launchdir}"
    rm -rf "${creaturesdir}"
    rm "Frameworks"
    # If Wineskin Winery was downloaded by us, delete its downloads.
    if [[ ! -d "/Applications/Wineskin Winery.app" ]]; then
        rm -rf "$HOME/Library/Application Support/Wineskin"
    fi
fi
