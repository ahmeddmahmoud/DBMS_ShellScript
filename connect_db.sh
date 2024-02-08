#!/bin/bash

#Declaring variable to store the path of the Databases directory
databases_path="./Databases"

#Getting the name of database and Checking if the user doesn't enter anything
while true
  do
    read -p "Please enter the name of database to connect to? " database_name
    if [ -z "$database_name" ]
       then
          echo "-------------------------------------------------"
          echo "Invalid input ! you should enter a database name"
          echo "-------------------------------------------------"
       else
          break
    fi
  done

#Checking if the name of database exist
if [ -d "$databases_path/$database_name" ]

   #If exists, connect to the database	
   then
     clear
     echo "------------------------------------------"
     echo "Connected to $database_name successfully!"
     echo "------------------------------------------"
     ./menu_db.sh $database_name

   #If doesn't exist, return to the menu
   else
     clear
     echo "--------------------------------------------------------------------------------------"
     echo "The name of database you provided ( $database_name ) doesn't exist, returning to menu"
     echo "--------------------------------------------------------------------------------------"
     ./main.sh 
fi


