#!/usr/bin/env bash
# Usage: box $1
# Summary: write a summary for your new command
# Help:
#
# Colors
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

function get_platform() {
  if [ "$(uname -s)" == "Darwin" ]; then
    # Do something for OSX
    export NS_PLATFORM="darwin"
    die "OSX not supported"
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  	# Do something for Linux platform
  	# assume ubuntu - but surely this can be extended to include other distros
  	export NS_PLATFORM="linux"
  elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something for Windows NT platform
  	export NS_PLATFORM="windows"
    die "Windows not supported"
  fi
  ok
}

function ok() { echo -e "$COL_GREEN[ok]$COL_RESET"; }

function bot() { echo -e "\n$COL_GREEN\[._.]/$COL_RESET - $1"; }

banner

get_platform

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

export BOXROOTDIR=$HOME/.box
export BOXFUNCDIR=$BOXROOTDIR/functions

bot "Installing Google Chrome"
  $HOME/.box/bin/box setup chrome
ok

bot "Installing GitFlow and GIBO"
  $HOME/.box/bin/box setup git
ok

bot "Installing Git Kraken"
  $HOME/.box/bin/box setup gitkraken
ok

bot "Installing Atom text editor"
  $HOME/.box/bin/box setup atom
ok

bot "Installing NodeJS"
  $HOME/.box/bin/box setup nodejs
ok

# bot "Installing Python"
#   $HOME/.box/bin/box setup python
# ok

# bot "Installing Ansible"
#   $HOME/.box/bin/box setup ansible
# ok

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
