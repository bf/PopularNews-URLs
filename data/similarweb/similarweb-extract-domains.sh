#!/bin/bash

outfile="../../output/temp/$1.domains.txt"

if [ ! -f "$1" ]; then
    echo "file $1 does not exist";
    exit 1;
fi

echo "extracting domains from $1"

(cut -f 1 "$1" | sort | cut -d "/" -f 1 | uniq > $outfile) && echo successfully stored in $outfile