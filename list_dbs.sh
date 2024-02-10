#!/bin/bash

dir=Databases

if [ "$(ls -A $dir)" ]
then 
	clear
	echo "----------------"
	echo "Databases Are"
	echo "----------------"
	ls $dir
	echo "----------------"
	./main.sh
else
	clear
	echo "----------------"
	echo "there are no databases available"
	echo "----------------"
	./main.sh
fi
