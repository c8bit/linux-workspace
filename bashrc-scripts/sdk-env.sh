#!/bin/bash
#TODO: Figure out the proper hashbang to use.

#------------------------------------------------------------------------------
# sdk-env.sh
#   This script sets up paths for existing development tools/environments and
#   provides other utility functions for dealing with them.
#------------------------------------------------------------------------------

function gbdk-env {
    ## Sets up the gbdk (GameBoy dev kit) environment.
    #
    # To install newer versions of the GBDK (certainly v2.96+), you really just
    # need to unzip/untar the sdk and move it to the GBDKDIR. Older versions
    # require more setup I believe, so be careful. Shouldn't be any need for an
    # install function.
    
    export GBDKDIR=/opt/gbdk/
    alias gbdk="cd ${GBDKDIR}"
}

#function dc-env {}
#function snes-env{}
#function genesis-env{}

main() {
    gbdk-env
}

main
