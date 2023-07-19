#!/bin/bash

IN=modlist.txt

while IFS=, read -r mod ; do
  [ "${mod}" = "" ] || python wm.py search ${mod}
done < ${IN}
