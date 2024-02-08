#!/bin/bash
PS3="select from the menu "
database_name=$1

#function to delete all the table
function delete_all {
  sed -i '1,$d' Databases/$database_name/$1
}

#function to select row by a given value
function delete_row {
  read -p "please enter the value you want to delete by " value
  if grep -q -w "$value" "Databases/$database_name/$1"
   then
     lines_to_delete=$(grep -w -n "$value" "Databases/$database_name/$1" | cut -d: -f1 | tac)
     echo $lines_to_delete
     for ele in $lines_to_delete
        do
          #echo ${ele}
          sed -i "${ele}d" "Databases/$database_name/$1"
        done
   else
     echo "No matching rows found for $value"
  fi
}

#function for Asking user about the options of selection
function delete_options {
  select choice in "delete all the records in the table" "delete row" 
   do
    case "$REPLY" in
        1)
        echo "delete all the table"
        delete_all "$1"
        exit
        ;;

        2)
        echo "delete row"
        delete_row "$1"
        ;;

        *)
        echo "Invalid input! You should select from (1-2)"
    esac
  done
}

#Getting the name of table from the user and checking for not typing input
while true
  do
    read -p "Please enter the name of the table ? " table
    if [ -z "$table" ]
       then
          echo "-------------------------------------------------"
          echo "Invalid input! you should enter a table name"
          echo "-------------------------------------------------"
       else
          break
    fi
  done

#checking if the table exists in the database
if [ -f "Databases/$database_name/$table" ]
  then
    delete_options $table
  else
     echo "--------------------------------------------------------------------------------------"
     echo "The name of table you provided ( $table ) doesn't exist, returning to menu"
     echo "--------------------------------------------------------------------------------------"
     exit
fi    





