#!/bin/bash

while true
do
      echo -e "Please enter the name of Database: \c"
      read -r name
      if [ -z "$name" ];then
	    echo "----------------------------------------------"
        echo "Name of the database can't be empty !!!!"
		echo "----------------------------------------------"
	    elif [[ "$name" =~ [^a-zA-Z0-9_] ]];then
        echo "-----------------"
        echo "Invalid input!"
        echo "-----------------"
       else
         	break
      fi
done

if [ -d ./Databases/$name ]
then
	clear
	echo "--------------------------------"
	echo "Database $name is already exist "
	./main.sh
elif [[ $name =~ ^[A-Za-z] ]] && [[ $name = +([a-zA-Z0-9_]) ]]
then
	mkdir ./Databases/$name
	clear
	echo "---------------------------------"
	echo "Database $name is created succssefully"
	echo "---------------------------------"
	./main.sh
else 
	clear
	echo "--------------------"
	echo "Please Enter a valid name"
	echo "--------------------"
	./create_db.sh
fi

