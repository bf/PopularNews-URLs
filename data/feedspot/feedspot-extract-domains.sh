#!/bin/bash

outfile="../../output/temp/$1.domains.txt"

if [ ! -f "$1" ]; then
    echo "file $1 does not exist";
    exit 1;
fi

echo "extracting domains from $1"

(jq ".data[].link.text" "$1" -r | sort | cut -d "/" -f 1 > $outfile) && echo successfully stored in $outfile