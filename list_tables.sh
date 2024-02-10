#!/bin/bash

if [ -n "$(ls Databases/$1)" ]
then
	clear
	echo "------------------------"
	echo "The tables in $1 is: "
	echo "------------------------"
	ls Databases/$1
	echo "------------------------"
else
	clear
	echo "------------------------------"
	echo "No tables to list !!! "
	echo "--------------------------------"
fi
./menu.sh "$1"