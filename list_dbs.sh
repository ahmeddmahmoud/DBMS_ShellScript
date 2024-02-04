#!/bin/bash

dir=Databases

if [ "$(ls -A $dir)" ]
then 
	echo "----------------"
	echo "Databases is"
	echo "----------------"
	ls $dir
	echo "----------------"
	./main.sh
else
	echo "----------------"
	echo "there is no databases available"
	echo "----------------"
	./main.sh
fi

