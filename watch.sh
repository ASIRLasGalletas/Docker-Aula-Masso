#!/bin/bash

if [[ "$1" == '' ]]
then
	echo "Usage: $0 configFile.csv"
	exit 1
fi

function cleanup {
	tput rmcup
}

tput smcup
trap cleanup EXIT

while true
do
	clear
	while read studentConfig
	do
		studentId=`echo $studentConfig | cut -d, -f1`
		studentHttpConnections=`docker exec -i $studentId /bin/bash -c 'netstat -natp | grep 0.0.0.0:80 | wc -l'`
		echo "$studentId : $studentHttpConnections connections to 0.0.0.0:80"
	done < $1
	sleep 5
done
