#!/bin/sh

function lineEndingsDos2Unix {
    local arg=$1

    if [[ -f "$arg" ]]; then
        # Single file
        local filesToConvert="$arg"
    elif [[ -d "$arg" ]]; then
        # Directory, recursive
        #FIXME: Handle errors on certain types of files
        local filesToConvert=$(find $arg -not -type d)
    else
        echo "usage: "
    fi

    for file in $filesToConvert; do
        ed -s $file <<< $'H\n,s///\nwq'
    done
}

lineEndingsDos2Unix "$@"
