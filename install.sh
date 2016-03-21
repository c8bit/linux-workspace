#!/bin/bash

#------------------------------------------------------------------------------
# install.sh
#   Sets up a first-time configuration for a linux system/workspace. This 
#   provides a mobile repository for all of a person's personal scripts,
#   binaries, installed package configurations, rc files, X11 profiles, editor
#   configurations, etc. Any functionality can be added quickly and easily,
#   and multiple systems can be tracked with this script to make sure that
#   you're never without your trusty linux workspace :)
#------------------------------------------------------------------------------
readonly __REPO_DIRECTORY__=$(readlink -m $(dirname $0))
readonly __HOME_DIRECTORY__=$(echo ~)

readonly RC_DIR="${__REPO_DIRECTORY__}/rc"
readonly VIM_DIR="${__REPO_DIRECTORY__}/vim"
readonly CONFIG_DIR="${__REPO_DIRECTORY__}/config"
readonly SCRIPT_DIR="${__REPO_DIRECTORY__}/bin"

function exitIfRoot {
#Exits the script if it was run by root.
    if [[ ${EUID} -eq 0 ]]; then
        echo "ERROR: This script is for individual users only. Do not run as root. Exiting."
        exit 1
    fi
}

function linkRcFiles {
#Create hard links for all rc files at ~
    for rcFilename in $(ls ${RC_DIR}); do
        ln "${RC_DIR}/${rcFilename}" "${__HOME_DIRECTORY__}/.${rcFilename}"
    done
}

function linkConfigDir {
#Creates a soft link from this repo's "config" directory to "~/.config"
    local homeConfig="${__HOME_DIRECTORY__}/.config"

    ln -s ${CONFIG_DIR} ${homeConfig}
}

function linkScriptsDir {
#Creates a soft link from this repo's "bin" directory to "~/bin"
    local homeBin="${__HOME_DIRECTORY__}/bin"

    ln -s ${SCRIPT_DIR} ${homeBin}
}

function linkVimDir {
#Creates a soft link from this repo's "vim" directory to "~/.vim"
    local homeVim="${__HOME_DIRECTORY__}/.vim"

    ln -s ${VIM_DIR} ${homeVim}
}


main() {
    exitIfRoot

    linkRcFiles
    linkConfigDir
    linkScriptsDir
    linkVimDir

    source ~/.bashrc
    exit 0
}

main

