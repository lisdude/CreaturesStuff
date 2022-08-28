#!/bin/bash

# This script will install Docking Station for Linux into a single directory that you can move at your leisure.
# If you want to dock with Creatures 3, copy your entire "Creatures 3" directory into this one.
# WARNING: Files in your Creatures 3 directory will be permanently altered to lowercase names.

# TODO: Language picker...
# TODO: ... audio...

### USER SETTINGS ###
INSTALL_DIR="./DockingStation"
#####################

# Lowercase filenames faster than the 'rename' command.
function lowercase
{
    for file in *; do
        if [ -d "${file}" ]; then
            cd "${file}"
            lowercase
            cd ..
        else
            [[ -f "$file" ]] && mv "$file" "${file,,}" 2>/dev/null
        fi
    done
}

DS="dockingstation_195_64.tar.bz2"
GLIB="libglib1.2ldbl_1.2.10-19build1_i386.deb"
GTK="libgtk1.2_1.2.10-18_i386.deb"
SDL="SDL-1.2.9-1.i386.rpm"
INSTALL_DIR=$(realpath ${INSTALL_DIR})
THIS_DIR=$(pwd)
EXTRACT_DIR="${INSTALL_DIR}/dockingstation_195_64"

# All of the extractions rely on having 7zip installed.
if ! [ -x "$(command -v 7z)" ]; then
    echo "You need the 'p7zip-full' package installed to continue."
    exit
fi

# Make sure the Docking Station installer is present. Should the link go down, try these alternatives:
# https://eemfoo.org/archive/downloads/8be6
# https://lisdude.com/Creatures/dockingstation_195_64.tar.bz2
if ! [ -f "${DS}" ]; then
    echo "You need a Docking Station for Linux installer to continue. Try here: http://www.creaturesdockingstation.com/dockingstation_195_64.tar.bz2"
    exit
fi

# If md5sum is available, verify the installer is good. If not... oh well. Nothing will ever go wrong!
if [ -x "$(command -v md5sum)" ]; then
    if [ "$(md5sum ${DS})" != "90a7ab012bbd4530b63c1ed64fb94464  dockingstation_195_64.tar.bz2" ]; then
        echo "Either ${DS} isn't a proper Docking Station for Linux installer or the file is corrupt. Try downloading it again."
        exit
    fi
fi

# Check if already 'installed'.
if [ -d "${INSTALL_DIR}" ]; then
    echo "It looks like you already have an installation. If you want to start over, delete '${INSTALL_DIR}' and try again. If you want to play, launch 'ds' from '${INSTALL_DIR}'."
    exit
fi

# Create the install directory and copy a temporary copy of our Docking Station archive.
mkdir -p "${INSTALL_DIR}"
cp "${DS}" "${INSTALL_DIR}"
cd "${INSTALL_DIR}"

echo "Extracting..."
tar -xf "${DS}"

# Get global game data.
cd "${EXTRACT_DIR}/dsbuild 195/global"

echo "Decompressing... this may take a moment!"
find . -name "*.bz2" -exec bzip2 -d {} \;
lowercase

# Move our tidily decompressed files to their new home.
mv * "${INSTALL_DIR}"

# Get Linux-specific files.
cd "${EXTRACT_DIR}/ports/linux_x86_glibc21_64"
find . -name "*.bz2" -exec bzip2 -d {} \;

mv ./Catalogue/* "${INSTALL_DIR}/Catalogue"
rmdir "Catalogue"
mv * "${INSTALL_DIR}"

# Clean up...
cd "${INSTALL_DIR}"
rm -rf {*.xpm,${EXTRACT_DIR},${DS},dstation-install,file_list*,langpick*,libSDL-1.2.so.0}

# user.cfg needs to use lowercase filenames
sed -i 's/DS_/ds_/g' ./user.cfg

# Give it an icon... maybe?
echo "Icon \"dstation.bmp\"" >> ./user.cfg

# Add handy executable for Docking Station
cat >> ds << END
#!/bin/bash
if [ -f DS_machine.cfg ]; then
    mv machine.cfg C3_machine.cfg
    mv DS_machine.cfg machine.cfg
    mv user.cfg C3_user.cfg
    mv DS_user.cfg user.cfg
fi
export LD_LIBRARY_PATH="${INSTALL_DIR}:$LD_LIBRARY_PATH"
./lc2e --autokill
END
chmod u+x ./ds

# Back to the directory this script is in!
cd "${THIS_DIR}"

# Link up Creatures 3 is it's here...
if [ -d "Creatures 3" ]; then
    C3_FOUND=true
    echo "Creatures 3 found. This may take a while as files are renamed..."
    C3_MAIN="../Creatures 3"
    # Tediously rename all of C3's files.
    cd "./Creatures 3"
    lowercase
    cd "${INSTALL_DIR}"

    # Tack the auxiliary bootstrap data on to machine.cfg.
    cat >>machine.cfg <<END
"Auxiliary 1 Backgrounds Directory" "$C3_MAIN/Backgrounds/"
"Auxiliary 1 Body Data Directory" "$C3_MAIN/Body Data/"
"Auxiliary 1 Bootstrap Directory" "$C3_MAIN/Bootstrap/"
"Auxiliary 1 Catalogue Directory" "$C3_MAIN/Catalogue/"
"Auxiliary 1 Creature Database Directory" "$C3_MAIN/Creature Galleries/"
"Auxiliary 1 Exported Creatures Directory" "$C3_MAIN/My Creatures/"
"Auxiliary 1 Genetics Directory" "$C3_MAIN/Genetics/"
"Auxiliary 1 Images Directory" "$C3_MAIN/Images/"
"Auxiliary 1 Journal Directory" "$C3_MAIN/Journal/"
"Auxiliary 1 Main Directory" "$C3_MAIN/"
"Auxiliary 1 Overlay Data Directory" "$C3_MAIN/Overlay Data/"
"Auxiliary 1 Resource Files Directory" "$C3_MAIN/My Agents/"
"Auxiliary 1 Sounds Directory" "$C3_MAIN/Sounds/"
"Auxiliary 1 Users Directory" "$C3_MAIN/Users/"
"Auxiliary 1 Worlds Directory" "$C3_MAIN/My Worlds/"
END

# To allow game-swapping, create alternative configurations and launcher.
! [[ -f "${C3_MAIN}/Users" ]] && mkdir "${C3_MAIN}/Users"
cat >>C3_machine.cfg <<END
"Backgrounds Directory" "$C3_MAIN/Backgrounds/"
"Body Data Directory" "$C3_MAIN/Body Data/"
"Bootstrap Directory" "$C3_MAIN/Bootstrap/"
"Catalogue Directory" "$C3_MAIN/Catalogue/"
"Creature Database Directory" "$C3_MAIN/Creature Galleries/"
"Exported Creatures Directory" "$C3_MAIN/My Creatures/"
"Genetics Directory" "$C3_MAIN/Genetics/"
"Images Directory" "$C3_MAIN/Images/"
"Journal Directory" "$C3_MAIN/Journal/"
"Main Directory" "$C3_MAIN/"
"Overlay Data Directory" "$C3_MAIN/Overlay Data/"
"Resource Files Directory" "$C3_MAIN/My Agents/"
"Sounds Directory" "$C3_MAIN/Sounds/"
"Users Directory" "$C3_MAIN/Users/"
"Worlds Directory" "$C3_MAIN/My Worlds/"
"Game Name" "Creatures 3"
END

cat >>C3_user.cfg <<END
DiskSpaceCheck 33554432
DiskSpaceCheckSystem 78643200
FlightRecorderMask 33
FullScreen 0
END

cat >> c3 << END
#!/bin/bash
if [ -f C3_machine.cfg ]; then
    mv machine.cfg DS_machine.cfg
    mv C3_machine.cfg machine.cfg
    mv user.cfg DS_user.cfg
    mv C3_user.cfg user.cfg
fi
export LD_LIBRARY_PATH="${INSTALL_DIR}:$LD_LIBRARY_PATH"
./lc2e --autokill
END
chmod u+x ./c3

fi

# Add working libraries...
cd "${THIS_DIR}"

# Download ancient files.
# Should these become missing, try: https://lisdude.com/Creatures/linux
if ! [ -f "${GLIB}" ]; then
    wget https://old-releases.ubuntu.com/ubuntu/pool/universe/g/glib1.2/${GLIB} 2>/dev/null
fi

if ! [ -f "${GTK}" ]; then
    wget https://old-releases.ubuntu.com/ubuntu/pool/universe/g/gtk+1.2/${GTK} 2>/dev/null
fi

if ! [ -f "${SDL}" ]; then
    wget https://libsdl.org/release/${SDL} 2>/dev/null
fi

if ! [ -d "tmp" ]; then
    mkdir "tmp"
fi

# Extract SDL
7z x ${SDL} -o./tmp 1>/dev/null
cd tmp
7z x SDL-1.2.9-1.i386.cpio 1>/dev/null
mv ./usr/lib/libSDL-1.2.so.0.7.2 ../libSDL-1.2.so.0
cd ..
rm -rf tmp

# Extract GLIB
mkdir tmp
7z x ${GLIB} -o./tmp 1>/dev/null
cd tmp
7z x data.tar 1>/dev/null
mv ./usr/lib/libglib-1.2.so.0.0.10 ../libglib-1.2.so.0
mv ./usr/lib/libgmodule-1.2.so.0.0.10 ../libgmodule-1.2.so.0
cd ..
rm -rf tmp

# Extract GTK
mkdir tmp
7z x ${GTK} -o./tmp 1>/dev/null
cd tmp
7z x data.tar 1>/dev/null
mv ./usr/lib/libgdk-1.2.so.0.9.1 ../libgdk-1.2.so.0
mv ./usr/lib/libgtk-1.2.so.0.9.1 ../libgtk-1.2.so.0
cd ..
rm -rf tmp

echo "Moving libraries to ${INSTALL_DIR}..."
mv *.so.0 "${INSTALL_DIR}"

# Cleanup
rm {${SDL},${GLIB},${GTK}}

echo ""
echo "Installation complete!"
echo ""
echo "You can start Docking Station by launching: ${INSTALL_DIR}/ds"
if [ "${C3_FOUND}" = true ]; then
    echo "You can start Creatures 3 by launching: ${INSTALL_DIR}/c3"
fi

echo ""
echo "NOTE: If you get a 'no such file or directory' error when you know the file exists, you may need these:"
echo "      sudo dpkg --add-architecture i386"
echo "      sudo apt update"
echo "      sudo apt install libc6:i386 libstdc++6:i386 zlib1g:i386 libxi6:i386"
