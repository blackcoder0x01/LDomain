#!/bin/bash
if [ ! "$1" ]; then
	echo "Missing parameter"
	echo "Please Used ./domainresolve.sh weblist.txt output-folder-location"
	exit 1
fi
cat "$1" | sort -u | while read line; do
    if [ $(curl --write-out %{http_code} --silent --output /dev/null -m 5 $line) = 000 ]
    then
      echo "$line was Error"
      touch $2ErrorWebsite.html
      echo "<b><a href="$line">$line</b></a> Error Website</br>" >> $2ErrorWebsite.html
    else
      echo "$line is up"
      echo $line >> $2livesite.txt
    fi
done
