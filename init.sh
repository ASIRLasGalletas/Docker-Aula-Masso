#!/bin/bash
count=6080
for i in $(cat listaPcOrAlumnos.txt)
do
	docker network create $i #Crea una nueva red en docker 
	docker run -d -p $count:80 --net=$i --name $i dorowu/ubuntu-desktop-lxde-vnc #Parametro --net "Agrega el contenedor a la red existente"
	((count++))
	sleep 5
done

