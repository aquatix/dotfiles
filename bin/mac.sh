#!/bin/bash

# Stolen from https://raw.githubusercontent.com/Cybertinus/macvendor_extractor/master/mac.sh

##########
# CONFIG #
##########

# Download from http://standards-oui.ieee.org/oui/oui.txt
ouilocation="${HOME}/.dot/oui.txt"

#################
# ACTUAL SCRIPT #
#################

if [ ! -f "${ouilocation}" ] ; then
	echo "OUI location can not be found at ${ouilocation}. Have you updated the config?" 1>&2
	read -p "Do you want to download it now [y/N]? " -n 1 -r
	echo    # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		wget https://standards-oui.ieee.org/oui/oui.txt -O "${ouilocation}"
	else
		echo "Aborted"
		exit 1
	fi
fi

if [[ $(find "${ouilocation}" -mtime +30 -print) ]]; then
	echo "File ${ouilocation} is older than 30 days"
fi

if [ -z "${1}" ] ; then
	echo 'No mac address specified, please do so as first argument' 1>&2
	exit 2
fi

macaddress="$(echo "${1}" | sed -e 's/[-.:]//g' | tr '[:lower:]' '[:upper:]')"
macaddress="${macaddress:0:6}"
echo -n "${1} = "

vendor="$(awk "/^${macaddress}/ {print substr(\$0,index(\$0,\$4))}" "${ouilocation}")"
if [ -z "${vendor}" ] ; then
	echo "Not specified in ${ouilocation}"
else
	echo "${vendor}"
fi

