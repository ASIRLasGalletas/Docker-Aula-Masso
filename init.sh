#!/bin/bash

if [[ "$1" == '' ]]
then
	echo "Usage: $0 configFile.csv"
	exit 1
fi

studentPort=6080

while read studentConfig
do
	studentId=`echo $studentConfig | cut -d, -f1`
	studentPassword=`head /dev/random | md5sum | grep -o '[a-f0-9]*' --color=never`
	echo docker network create $studentId
	echo docker run -d -p $studentPort:80 --net=$studentId -e VNC_PASSWORD=$studentPassword --name $studentId dorowu/ubuntu-desktop-lxde-vnc
	echo "$studentId => $studentPort : $studentPassword"
	((studentPort++))
	sleep 5
done < $1
