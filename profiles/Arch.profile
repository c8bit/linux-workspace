#------------------------------------------------------------------------------
# Arch.profile
#   Profile configuration for a personal Arch Linux System.
#
# Profile Target:  Arch Linux
# Package Manager: pacman
#-----------------------------------------------------------------------------

!PACKAGE_MGR_INSTALL {"pacman -Sy"}
!PACKAGE_MGR_UPDATE  {"pacman -Syu"}
!PACKAGES {
    #System Tools, config
    wget
    unzip
    
    #GUI, terminal, and eyecandy
    xorg
    rxvt-unicode
    screenfetch
    openbox
    
    #General applications
    git
    tmux
    chromium
    docker
    lynx
    vim
    emacs
}
