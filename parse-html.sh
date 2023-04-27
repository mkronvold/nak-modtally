#!/bin/bash


DEBUG=0

program=${0##*/}   #  similar to using basename
tempkey=7129
IN=$( mktemp /dev/shm/${tempkey}_${program}_tmp.XXXXXXXXXX )
OUT=$( mktemp /dev/shm/${tempkey}_${program}_tmp.XXXXXXXXXX )

cleanup () {
     #  Delete temporary files, then optionally exit given status.
     local status=${1:-'0'}
     rm -f ${IN} ${OUT}
     [ $status = '-1' ] ||  exit $status      #  thus -1 prevents exit.
} #--------------------------------------------------------------------
warn () {
     #  Message with basename to stderr.          Usage: warn "message"
     echo -e "\n !!  ${program}: $1 "  >&2
} #--------------------------------------------------------------------
die () {
     #  Exit with status of most recent command or custom status, after
     #  cleanup and warn.      Usage: command || die "message" [status]
     local status=${2:-"$?"}
     cleanup -1  &&   warn "$1"  &&  exit $status
} #--------------------------------------------------------------------
trap "die 'SIG disruption, but cleanup finished.' 114" 1 2 3 15
#    Cleanup after INTERRUPT: 1=SIGHUP, 2=SIGINT, 3=SIGQUIT, 15=SIGTERM

# generates a line the width of your terminal, takes one arg if you want, defaults to '='
hr () { printf "%0$(tput cols)d" | tr 0 ${1:-=}; }





xidel $1 -e '//tr / string-join(td, ",")' > ${IN}

# example
# 3CB Factions,Steam,https://steamcommunity.com/sharedfiles/filedetails/?id=1673456286
total=0

while IFS=, read -r modname source url ; do
    id=$(echo ${url} | awk -F= '{print $2}')
    size=$(du -sm /mnt/d/Games/Steam/steamapps/workshop/content/107410/${id} | awk '{print $1}')
    total=$(($total+$size))
    echo "${modname}|${size}"
done < ${IN} > ${OUT}

hr
cat ${OUT} | column -ts'|'
hr
echo Total Size = $total

cleanup
