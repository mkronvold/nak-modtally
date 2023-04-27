#!/bin/bash


DEBUG=0

modfolder=/mnt/d/Games/Steam/steamapps/workshop/content/107410/

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

### Requirements check
[[ $(which xidel) ]] || die "Cannot find xidel.  Install it from https://github.com/benibela/xidel"

### Main
xidel $1 -e '//tr / string-join(td, ",")' > ${IN}

total=0
while IFS=, read -r modname source url ; do
    id=$(echo ${url} | awk -F= '{print $2}')
    [ -d ${modfolder}/${id} ] && size=$(du -sk ${modfolder}/${id} | awk '{print $1}') || size="NOT_INSTALLED"
    [ "${sizekb}" == "NOT_INSTALLED" ] || totalkb=$(($totalkb+$sizekb))
    [ "${sizekb}" == "NOT_INSTALLED" ] || sizemb=$(($sizekb/1024))
    echo "${modname}|${sizemb}"
done < ${IN} > ${OUT}

hr
cat ${OUT} | column -ts'|'
hr
totalmb=$(($totalkb/1024))
echo Total Size (MB) = $totalmb

cleanup
