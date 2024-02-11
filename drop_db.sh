#!/bin/bash

#Declaring variable to store the path of the Databases directory
databases_path="./Databases"

#Getting the name of database and Checking if the user doesn't enter anything
while true
  do
    read -p "Please enter the name of database you wish to remove? " database_name_remove
    if [ -z "$database_name_remove" ]
       then
	        echo "-------------------------------------------------"
          echo "Invalid input ! you should enter a database name"
	        echo "-------------------------------------------------"
        elif [[ "$database_name_remove" =~ [^a-zA-Z0-9_] ]]; then
          echo "-----------------"
          echo "Invalid input!"
          echo "-----------------"
       else
	  break
    fi
  done

#Checking if the name of the database the user inserted exists
if [ -d "$databases_path/$database_name_remove" ]

   #The database exists
   then

    while true
     do    
      #Asking for confirm to delete the database
      read -p "Are you sure you want to delete the database? All tables will be deleted! (y/n)? " answer
      case $answer in
	   #The user confirms to delete the database   
	   [Yy])
	       echo "--------------------------------------------"
	       echo "Database ( $database_name_remove ) was removed successfully"
	       echo "--------------------------------------------"
	       rm -r "$databases_path/$database_name_remove"
         sleep 2
         clear	
	       break;;
	   #The user cancelled the deleting operation
           [Nn])
	       echo "------------------------------------------------------"
    	       echo "Cancelling deleting operation of Database ( $database_name_remove )"
	       echo "------------------------------------------------------"
         sleep 2
         clear	      
	       break;;
	   #The user enters invalid answer
	   *)
	       echo "---------------------------------------"
	       echo "Invalid input, you should enter (y/n)"
	       echo "---------------------------------------"
      	       ;;   
      esac
    done  
      ./main.sh

   #The database doesn't exist   
   else
      echo "----------------------------------------------------------------------"
      echo "The database you entered ( $database_name_remove ) doesn't exist, returning to menu"
      echo "----------------------------------------------------------------------" 
      sleep 2
      clear     
      ./main.sh
fi


