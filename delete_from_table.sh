#!/bin/bash
PS3="select from the menu "
database_name=$1

clear
echo "-----------------------"
echo "Delete from Table Menu"
echo "-----------------------"

##############################################  Functions ############################################
######################################################################################################
#function to delete all the table
function delete_all {
  sed -i '1,$d' Databases/$database_name/$1
  echo "All the rows were deleted successsfully !"
  echo "--------------------------------------------"
  sleep 2
  clear
  delete_options $table
}

#function to delete row by a given value
function delete_value {
  read -p "please enter the value you want to delete by " value
  if grep -q -w "$value" "Databases/$database_name/$1"
   then
     lines_to_delete=$(grep -w -n "$value" "Databases/$database_name/$1" | cut -d: -f1 | tac)
     for ele in $lines_to_delete
        do
          sed -i "${ele}d" "Databases/$database_name/$1"
        done
        echo "deleted successsfully !"
   else
     echo "No matching rows found for $value"
  fi
  echo "--------------------------------------------"
  sleep 2
  clear
  delete_options $table
}

#function to delete row by a value of primary key
function delete_pk {
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
  #getting the number of pk column 
  column_number_pk=$(awk -F ':' -v primary_key=$primary_key '{ for (i=1; i<NF; i++) { if ($i == primary_key) { print i } } }' "./Databases/$database_name/.metadata/$table")

  #Checking for the matched record of value
  output=$(awk -F ':' -v column_number_pk=$column_number_pk -v value=$value '$column_number_pk == value { print NR }' "./Databases/$database_name/$table") 
  

  if [ -z "$output" ]; then
    echo "No matching records found."
  else
    sed -i "${output}d" "Databases/$database_name/$1"
    echo "row was deleted Successfully"
  fi
  echo "--------------------------------------------"
  sleep 2
  clear
  delete_options $table
}

#function for Asking user about the options of selection
function delete_options {
  echo "-----------------------"
  echo "Delete from Table Menu"
  echo "-----------------------"
  select choice in "delete all" "delete by primary key" "delete by just a value" "return" 
   do
    case "$REPLY" in
        1)
        delete_all "$1"
        ;;

        2)
        delete_pk "$1"
        ;;

        3)
        delete_value "$1"
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
    delete_options $table
  else
     echo "----------------------------------------------------------------------------"
     echo "The name of table you provided ( $table ) doesn't exist, returning to menu"
     echo "----------------------------------------------------------------------------"
     sleep 2
     clear
     ./menu.sh "$database_name"
fi    





