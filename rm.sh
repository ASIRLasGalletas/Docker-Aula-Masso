#!/bin/bash

if [[ "$1" == '' ]]
then
	echo "Usage: $0 configFile.csv"
	exit 1
fi

while read studentConfig
do
	studentId=`echo $studentConfig | cut -d, -f1`
	docker rm -f $studentId
done < $1
