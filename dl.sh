#!/bin/sh
function parse_download() {
    filename=""
    filename=$(grep "Saving to:" /tmp/surf-dl.$$ |\
    cut -d '`' -f2 |\
    sed "s/'//")
    echo "NEW FILENAME: $filename"
    if [[ $filename == "" ]]; then
            filename=$(grep "Server file no newer" /tmp/surf-dl.$$ |\
            cut -d '`' -f2 |\
            sed "s/'.*//")
    fi
    echo "ALREADY EXISTS FILENAME: $filename"
    if [[ $filename != "" ]]; then
            run-mailcap $filename
    fi
    rm -f /tmp/surf-dl.$$
}

wget -N --load-cookies ~/.surf/cookies.txt $1 -o /tmp/surf-dl.$$ && parse_download
