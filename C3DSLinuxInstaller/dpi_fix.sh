#!/bin/bash

# This script will attempt to fix scaling issues for users of high DPI displays. It uses xpra and a 'run_scaled' script.
# By default, because of outdated Ubuntu packages, it uses the beta version of xpra. If you don't want that, just comment out
# or delete everything from "# BETA STARTS HERE" to "# BETA ENDS HERE"

INSTALL_DIR="./DockingStation"

WEBSITE="https://github.com/Xpra-org/xpra/wiki/Download"
INSTALL_DIR=$(realpath "${INSTALL_DIR}")

if ! [[ -d "${INSTALL_DIR}" ]]; then
    echo "Couldn't find a Docking Station installation. If you changed the default location, you'll need to edit this script and change INSTALL_DIR at the top."
    exit
fi

if [[ -r /etc/os-release ]]; then
    . /etc/os-release
    DISTRO=${UBUNTU_CODENAME}
    if [[ "${DISTRO}" == "" ]]; then
        echo "Couldn't determine your distribution's codename. You'll need to manually install the xpra beta from: ${WEBSITE}"
        exit
    fi
else
    echo "Not running a distribution with /etc/os-release available. You'll need to manually install the xpra beta from: ${WEBSITE}"
    exit
fi

### This script is adapted from the one provided at ${WEBSITE} (see above)

echo "Installing the beta version of xpra for '${DISTRO}'..."

# BETA STARTS HERE
#install https support for apt (which may be installed already):
sudo apt update
sudo apt install apt-transport-https software-properties-common
sudo apt install ca-certificates
# add Xpra GPG key(s)
sudo wget -O "/usr/share/keyrings/xpra-2022.gpg" https://xpra.org/xpra-2022.gpg
# older distributions may also need:
sudo wget -O "/usr/share/keyrings/xpra-2018.gpg" https://xpra.org/xpra-2018.gpg
# add beta channel:
sudo wget -O "/etc/apt/sources.list.d/xpra-beta.list" https://xpra.org/repos/$DISTRO/xpra-beta.list
# BETA ENDS HERE

# install Xpra package
sudo apt update
sudo apt install xpra xvfb python3-pyinotify python3-uinput

# Having this installed made everything blurry in my VM. But real hardware? Unknown!
if pip freeze | grep "PyOpenGL-accelerate"=; then
    echo ""
    while true; do
        read -p "PyOpenGL-accelerate, in my experience, makes everything blurry. If you know you don't need it, you can uninstall it. If you're not sure, probably best to say no here. Uninstall? (y/n)" yn
        case $yn in
            [yY] ) pip uninstall PyOpenGL PyOpenGL-accelerate;
                break;;
            [nN] ) echo "Leaving it alone!";
                break;;
            * ) echo "Not sure what you want, so leaving it alone.";;
        esac
    done
fi

echo "Installing run_scaled and modifying launcher(s)..."
cd "${INSTALL_DIR}"
wget https://raw.githubusercontent.com/kaueraal/run_scaled/master/run_scaled 2>/dev/null
chmod u+x ./run_scaled

for game in ds c3; do
    if [[ -f "${INSTALL_DIR}/${game}" ]]; then
        ed "${INSTALL_DIR}/${game}" <<EOF
/^\.\/lc2e/c
./run_scaled --scale=2 ./lc2e --autokill
.
wq
EOF
    fi
done

echo "Done!"
