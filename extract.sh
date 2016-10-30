#!/bin/bash

FILENAME=README.org
REGEXGH="(https://github.com/([^/]+)/[^]]+)"
EXTRACTDIR=extract

grep https://github.com/ $FILENAME |\
while read line
do
    if [[ $line =~ $REGEXGH ]]; then
        login=${BASH_REMATCH[2]}
        url=${BASH_REMATCH[1]}
        if test "$login" == "" || test "$url" == ""; then
            echo "Failure in regexp"
            continue;
        fi
        targetdir="$EXTRACTDIR/$login"
        if test -d "$targetdir"; then
            echo $login directory already present, pass
            continue;
        fi
        git clone "$url" "$targetdir"
    else
        echo "No not github url?"
    fi
done
