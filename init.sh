#!/bin/bash

if [[ "$1" == '' ]]
then
	echo "Usage: $0 configFile.csv"
	exit 1
fi

image='dorowu/ubuntu-desktop-lxde-vnc'

docker pull $image

counter=0

while read studentConfig
do
	studentId=`echo $studentConfig | cut -d, -f1`
	studentPassword=`head /dev/random | md5sum | grep -o '[a-f0-9]*' --color=never`
	studentPort=3$counter`echo $RANDOM | head -c 2 && echo`
	docker network create $studentId
	docker run -d -p $studentPort:80 --net=$studentId -e VNC_PASSWORD=$studentPassword --name $studentId $image
	echo "$studentId => $studentPort : $studentPassword"
	((counter++))
	sleep 5
done < $1
