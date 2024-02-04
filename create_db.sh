#!/bin/bash

echo -e "Please enter the name of Database: \c"

read -r name
if [ -d ./Databases/$name ]
then
	echo "--------------------------------"
	echo "Database $name is already exist "
	./main.sh
elif [[ $name =~ ^[A-Za-z] ]] && [[ $name = +([a-zA-Z0-9_]) ]]
then
	mkdir ./Databases/$name
	echo "--------------------------"
	echo "Database $name is created succssefully"
	echo "--------------------------"
	./main.sh
else
	echo "--------------------"
	echo "Please Enter a valid name"
	echo "--------------------"
	./create_db.sh
fi


