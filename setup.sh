#!/bin/bash 

echo "[setup] Installing dependencies..."
sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib g++-multilib build-essential chrpath socat cpio python python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping libsdl1.2-dev xterm dconf-tools cmake

# Step 1. NeoFLX Yocto
if [ ! -d ~/bin ]; then
	mkdir ~/bin
	curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
	chmod a+x ~/bin/repo
elif [ ! -f ~/bin/repo ]; then
	curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
	chmod a+x ~/bin/repo
fi

PATH=${PATH}:~/bin
mkdir neoflx-bsp
cd neoflx-bsp
repo init -u https://github.com/Freescale/fsl-community-bsp-platform -b krogoth
repo sync

cd sources
echo "[setup] clone meta-qt5 layer..."
git clone https://github.com/meta-qt5/meta-qt5.git -b krogoth
echo "[setup] clone node.js layer..."
git clone https://github.com/imyller/meta-nodejs.git -b krogoth
git clone https://github.com/imyller/meta-nodejs-contrib.git -b krogoth
echo "[setup] clone neoflx layer..."
git clone https://github.com/ykworx/meta-neoflx-imx.git

echo "[setup] copy bblayers.conf & local.conf file..."
cd ..
MACHINE=neoflx source ./setup-environment build
cp ../sources/meta-neoflx-imx/base/conf/bblayers.conf conf
cp ../sources/meta-neoflx-imx/base/conf/local.conf conf
