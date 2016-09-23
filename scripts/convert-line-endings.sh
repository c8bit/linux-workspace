#!/bin/sh

function lineEndingsDos2Unix {
    local arg=$1
    local filesToConvert=$(find $arg -not -type d)
    #local tempFile="./TEMP"

    for file in $filesToConvert
    do
        #printf '%s\n' 'H' ',s///' 'wq' | ed -s $file
        ed -s $file <<< $'H\n,s///\nwq'
        #tr -d '' >$tempFile
        #rm $file
        #mv $tempFile $file
    done

    #rm $tempFile
}


