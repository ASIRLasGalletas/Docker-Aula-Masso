#!/bin/bash

if [[ "$1" == '' ]]
then
	echo "Usage: $0 configFile.csv"
	exit 1
fi

declare -A students

while true
do
	while read studentConfig
	do
		studentId=`echo $studentConfig | cut -d, -f1`
		studentHttpConnections=`docker exec -i vnc_test /bin/bash -c 'netstat -at | grep \`hostname\`:80 | wc -l'`
		if [[ ${students[$studentId]} != $studentHttpConnections ]]
		then
			echo "[ `date +'%Y-%m-%d %H:%M:%S'` ] $studentId : $studentHttpConnections connections"
			students[$studentId]=$studentHttpConnections
		fi
	done < $1
	sleep 1
done
