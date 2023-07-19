#!/bin/bash

IN=modlist.txt

while IFS=, read -r mod ; do
  if [ ! "${mod}" = "" ]; then
    url="https://steamcommunity.com/sharedfiles/filedetails/?id=${mod}"
    modepoch=$(curl --silent $url | grep -i time_updated | sed "s/\\\//g" | sed 's/,"/\n/g' | grep time_updated | awk -F: '{print $2}')
#    moddate=$(date --date="${modepoch}")
    #    echo "$url ( $moddate )"
        echo "$url ( $modepoch )"
    # read file date, convert and compare
    fi
done < ${IN}
