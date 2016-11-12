#!/usr/bin/env bash
#TODO: Add a linkBashrcScriptsDir function.

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

#TODO: make sure that removing quotes from these will allow them to work
#      properly, for consistency with bashrc dir vars.
readonly RC_DIR="${__REPO_DIRECTORY__}/rc"
readonly VIM_DIR="${__REPO_DIRECTORY__}/vim"
readonly CONFIG_DIR="${__REPO_DIRECTORY__}/config"
readonly SCRIPT_DIR="${__REPO_DIRECTORY__}/bin"

let EXISTING_FILES=0

function exitIfRoot {
    ## Exits the script if it was run by root.

    if [[ ${EUID} -eq 0 ]]; then
        echo "ERROR: This script is for individual users only. Do not run as root. Exiting."
        exit 1
    fi
}

function linkRcFiles {
    ## Create hard links for all rc files at ~

    local linkLocation=""

    for rcFilename in $(ls ${RC_DIR}); do
        linkLocation="${__HOME_DIRECTORY__}/.${rcFilename}"    
        if [[ -a ${linkLocation} ]]; then
            mv "${linkLocation}" "${linkLocation}_OLD"
            let EXISTING_FILES+=1
        fi

        ln "${RC_DIR}/${rcFilename}" ${linkLocation}
    done
}

function linkConfigDir {
    ## Creates a soft link from this repo's "config" directory to "~/.config"

    local homeConfig="${__HOME_DIRECTORY__}/.config"

    if [[ -d ${homeConfig} ]]; then
        mv "${homeConfig}" "${homeConfig}_OLD"
        let EXISTING_FILES+=1
    fi

    ln -s ${CONFIG_DIR} ${homeConfig}
}

function linkScriptsDir {
    ## Creates a soft link from this repo's "bin" directory to "~/bin"

    local homeBin="${__HOME_DIRECTORY__}/bin"

    if [[ -d ${homeBin} ]]; then
        mv "${homeBin}" "${homeBin}_OLD"
        let EXISTING_FILES+=1
    fi

    ln -s ${SCRIPT_DIR} ${homeBin}
}

function linkVimDir {
    ## Creates a soft link from this repo's "vim" directory to "~/.vim"

    local homeVim="${__HOME_DIRECTORY__}/.vim"

    if [[ -d ${homeVim} ]]; then
        mv "${homeVim}" "${homeVim}_OLD"
        let EXISTING_FILES+=1
    fi

    ln -s ${VIM_DIR} ${homeVim}
}

function installVundle {
    ## Installs the Vundle package manager for Vim

    git clone "https://github.com/VundleVim/Vundle.vim.git" "${VIM_DIR}/bundle/Vundle.vim"

    #Install all of the vim plugins
    vim +PluginInstall +qall
}


main() {
    exitIfRoot

    local menuOptions=(
        'Link rc files'
        'Link config directory'
        'Link scripts directory'
        'Link Vim directory'
        'Install Vundle'
        'Quit'
    )

    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "|           Config Manager             |"
    echo "|                                      |"
    echo "|       Please select an option:       |"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

    select opt in "${menuOptions[@]}"; do
        case $opt in
            'Link rc files')
                linkRcFiles
                ;;
            'Link config directory')
                linkConfigDir
                ;;
            'Link scripts directory')
                linkScriptsDir
                ;;
            'Link Vim directory')
                linkVimDir
                ;;
            'Install Vundle')
                installVundle
                ;;
            'Quit')
                break
                ;;
        esac
    done

    if [[ "$EXISTING_FILES" -gt "0" ]]; then
        echo "There were some file conflicts. Those files were appended with '_OLD', and require merging."
    fi 

    #source ~/.bashrc
    exit 0
}

main

