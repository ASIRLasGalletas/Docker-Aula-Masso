#!/bin/bash

if [[ "$1" == '' ]]
then
	echo "Usage: $0 configFile.csv"
	exit 1
fi

image='dorowu/ubuntu-desktop-lxde-vnc'

docker pull $image

studentPort=6080

while read studentConfig
do
	studentId=`echo $studentConfig | cut -d, -f1`
	studentPassword=`head /dev/random | md5sum | grep -o '[a-f0-9]*' --color=never`
	docker network create $studentId
	docker run -d -p $studentPort:80 --net=$studentId -e VNC_PASSWORD=$studentPassword --name $studentId $image
	echo "$studentId => $studentPort : $studentPassword"
	((studentPort++))
	sleep 5
done < $1
