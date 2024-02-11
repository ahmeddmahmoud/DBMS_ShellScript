#!/bin/bash
PS3="select from the menu "
database_name=$1

clear
echo "-----------------------"
echo "Select from Table Menu"
echo "-----------------------"

##############################################  Functions ############################################
######################################################################################################
#function to select all the table
function select_all {
  clear
  sed -n '1p' "Databases/$database_name/.metadata/$table"
  cat Databases/$database_name/$1 | more
  echo "--------------------------------------------"
  select_options $table
}

function select_value {
  read -p "please enter the value you want to search by " value
  clear
  if grep -q -w "$value" "Databases/$database_name/$1"
   then
     sed -n '1p' "Databases/$database_name/.metadata/$table"
     grep -w "$value" "Databases/$database_name/$1"
   else
     echo "No matching rows found for $value"
  fi
  echo "--------------------------------------------"
  select_options $table
}

#function to select row by a value of primary key
function select_pk {
  #Asking for the value of primary key and checking that it is not empty 
  while true
  do
    read -p "please enter the value of primary key ($primary_key column) you want to search by? " value
    if [ -z "$value" ]
       then
          echo "Invalid input! you should enter a value"
       else
          break
    fi
  done
  clear
  #getting the number of pk column 
  column_number_pk=$(awk -F ':' -v primary_key=$primary_key '{ for (i=1; i<NF; i++) { if ($i == primary_key) { print i } } }' "./Databases/$database_name/.metadata/$table")

  #Checking for the matched record of value
  output=$(awk -F ':' -v column_number_pk=$column_number_pk -v value=$value '$column_number_pk == value { print }' "./Databases/$database_name/$table") 
  
  if [ -z "$output" ]; then
    echo "No matching records found."
  else
    sed -n '1p' "Databases/$database_name/.metadata/$table"
    echo "$output"
  fi
  echo "--------------------------------------------"
  select_options $table
}

#function for Asking user about the options of selection
function select_options {
  echo "-----------------------"
  echo "Select from Table Menu"
  echo "-----------------------"
  select choice in "select all the table" "select by primary key" "select by just a value" "return"
   do
    case "$REPLY" in
        1)
        select_all "$1"
        ;;

        2)
        select_pk "$1"
        ;;

        3)
        select_value "$1"
        ;;

        4)
        clear
        ./menu.sh "$database_name"
        exit
        ;;

        *)
        echo "Invalid input! You should select from (1-4)"
    esac
  done
}
######################################################################################################
######################################################################################################

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
    primary_key=$(awk -F ':' 'NR==3 {print $0}' ./Databases/$database_name/.metadata/$table)
    clear
    select_options $table
  else
     echo "----------------------------------------------------------------------------"
     echo "The name of table you provided ( $table ) doesn't exist, returning to menu"
     echo "----------------------------------------------------------------------------"
     sleep 2
     clear
     ./menu.sh "$database_name"
fi    





