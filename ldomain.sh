#!/bin/bash

CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'
SECONDS=0

if [ ! "$1" ]; then
	echo "Missing parameter"
	echo "Please Used ./ldomain.sh weblist.txt output-folder-location"
	exit 1
fi
cat "$1" | sort -u | while read line; do
    if [ $(curl --write-out %{http_code} --silent --output /dev/null -m 5 $line) = 000 ]
    then
      echo -e "$line ${RED}is Error/404${NC}"
      touch $2ErrorWebsite.html
      echo "<b><a href="https://$line">$line</b></a> Error Website</br>" >> $2ErrorWebsite.html
    else
      echo -e "$line ${CYAN}is Live${NC}"
      echo $line >> $2livesite.txt
    fi
done
echo -e ""
echo -e "${RED}Scan finished successfully${NC}"
duration=$SECONDS
echo "Scan completed in : $(($duration / 60)) minutes and $(($duration % 60)) seconds."
