#!/usr/bin/env bash

ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_GREEN=$ESC_SEQ"32;01m"

function banner() {
  clear
  info '
               _                      _
  ___ ___   __| | ___ _ __ ___  _ __ (_)_ __
 / __/ _ \ / _  |/ _ \  __/ _ \|  _ \| |  _ \
| (_| (_) | (_| |  __/ | | (_) | | | | | | | |
 \___\___/ \__,_|\___|_|  \___/|_| |_|_|_| |_|
'
}

function ok() { echo -e "$COL_GREEN[ok]$COL_RESET"; }

function bot() { echo -e "\n$COL_GREEN\[._.]/$COL_RESET - $1"; }

banner

bot "Adding user to vboxsf group (for folder sharing)"
  DEV=`whoami`
  sudo usermod -a -G vboxsf $DEV
ok

# not needed if running linux mint Cinnamon 
# bot "Install DKMS"
#   sudo apt-get -y install dkms
# ok

# not needed if running linux mint Cinnamon 
# bot "Install VBoxLinuxAdditions"
#   ( cd /media/$DEV/VBOXADDITIONS_5.0.20_106931/ && sudo ./VBoxLinuxAdditions.run )
# ok

bot "Install GIT"
  (sudo apt-get install -y git > /dev/null 2>&1)
ok

bot "Installing .Box"
  (git clone https://github.com/russelltsherman/.box.git $HOME/.box > /dev/null 2>&1)
ok

bot "Installing .Box"
  (cd $HOME/.box && ./install.sh)
ok

bot "Cleaning Up"
  mkdir src
  rm -rf Documents
  rm -rf Downloads
  rm -rf Music
  rm -rf Pictures
  rm -rf Public
  rm -rf Templates
  rm -rf Videos
  rm -f automated_sandbox.sh

# sudo reboot
