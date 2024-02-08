#!/bin/bash

dir=Databases

if [ "$(ls -A $dir)" ]
then 
	clear
	echo "----------------"
	echo "Databases is"
	echo "----------------"
	ls $dir
	echo "----------------"
	
	./main.sh
else
	clear
	echo "----------------"
	echo "there is no databases available"
	echo "----------------"
	./main.sh
fi
