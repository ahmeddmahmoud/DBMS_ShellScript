#!/bin/bash
PS3="select from the menu "
database_name=$1

#function to select all the table
function select_all {
  clear
  cat Databases/$database_name/$1 | more
  echo "--------------------------------------------"
  select_options $table
}

#function to select row by a given value
function select_row {
  read -p "please enter the value you want to search by " value
  clear
  if grep -q -w "$value" "Databases/$database_name/$1"
   then
     grep -w "$value" "Databases/$database_name/$1"
     echo "--------------------------------------------"

   else
     echo "No matching rows found for $value"
     echo "--------------------------------------------"
  fi
  select_options $table
}

#function for Asking user about the options of selection
function select_options {
  select choice in "select all the table" "select row" 
   do
    case "$REPLY" in
        1)
        echo "select all the table"
        select_all "$1"
        exit
        ;;

        2)
        echo "select row"
        select_row "$1"
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
    select_options $table
  else
     echo "--------------------------------------------------------------------------------------"
     echo "The name of table you provided ( $table ) doesn't exist, returning to menu"
     echo "--------------------------------------------------------------------------------------"
     exit
fi    





