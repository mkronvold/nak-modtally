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


### What type of input are we processing?

[[ "${1}" == "" ]] && die "no file or URL given"

case "${1}" in
    https://cdn.discordapp.com*)
	PARSE_TYPE=PRESET
	echo "**** Parsing: Discord ****"
	;;
    https://steamcommunity.com*)
	PARSE_TYPE=COLLECTION
	echo "**** Parsing: Steam Collection ****"
	echo "**** Retrieving (GET): ${1} ****"
	;;
    *.html)
	PARSE_TYPE=PRESET
	echo "**** Parsing: HTML Preset File ****"
	;;
    *)
	PARSE_TYPE=PRESET
	echo "**** Parsing: Default ****"
	;;
esac

[[ "${2}" == "" ]] || PRESET_NAME=$2

### Main

[[ ${PARSE_TYPE} == "PRESET" ]] && xidel $1 -e '//tr / string-join(td, ",")' > ${IN}
[[ ${PARSE_TYPE} == "COLLECTION" ]] && curl --silent $1 | grep href | grep class=\"workshopItemTitle\" | sed "s/>/\"/g" | sed "s/</\"/g" | awk -F\" '{print $9 ",Steam," $3}' > ${IN} && echo "**** Processing: ${1} ****"

total=0
[[ ${PRESET_NAME} ]] && cat Preset_header.html | 's/PRESET_NAME/${PRESET_NAME}/g' > ${PRESET_NAME}.html
while IFS=, read -r modname source url ; do
    id=$(echo ${url} | awk -F= '{print $2}')
    [ -d ${modfolder}/${id} ] && sizekb=$(du -sk ${modfolder}/${id} | awk '{print $1}') || sizekb="NOT_INSTALLED" && sizemb=${sizekb}
    [ "${sizekb}" == "NOT_INSTALLED" ] || totalkb=$(($totalkb+$sizekb)) && sizemb=$(($sizekb/1024))
    echo "${modname}|${sizekb}KB|"
    [[ ${PRESET_NAME} ]] && cat Preset_row.html | sed 's/MOD_NAME/${modname}/g' | sed 's/MOD_URL/${url}/g' >> ${PRESET_NAME}.html
done < ${IN} > ${OUT}

hr
cat ${OUT} | column -s'|'
hr
totalmb=$(($totalkb/1024))
echo ""
echo "Total Size = ${totalmb}MB"
[[ ${PRESET_NAME} ]] && cat Preset_footer.html >> ${PRESET_NAME}.html && ls -sh ${PRESET_NAME}

cleanup
