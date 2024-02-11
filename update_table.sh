#!/bin/bash
database_name=$1
PS3="Choose what to do from menu (1-2) "
clear
echo "----------------------"
echo "Updating Table Menu"
echo "----------------------"


#Function to check if the user doesn't input anything
validate_input() {
    local input="$1"
    if [ -z "$input" ]; 
    then
        echo "Invalid input! Input should not be empty."
        return 1
    else
        return 0
    fi
}

update_table(){
#Asking the user for the table name and checking if the user doesn't input anything
while true; 
do
    read -p "Please type the name of table you wish to update " table_name
    if validate_input "$table_name"
      then
        break
    fi
done

#checking if the table exists in the database
if ! [ -f "Databases/$database_name/$table_name" ]; then
     echo "-------------------------------------------------------------------------"
     echo "The name of table you provided ( $table_name ) doesn't exist, returning to menu"
     sleep 2
     clear
     ./menu.sh "$database_name"
     exit
fi 

#Declaring Variables
columns_names=$(awk -F ':' 'NR==1 {for (i=1; i<NF; i++) {print $i}}' ./Databases/$database_name/.metadata/$table_name)
data_types=$(awk -F ':' 'NR==2 {for (i=1; i<NF; i++) {print $i}}' ./Databases/$database_name/.metadata/$table_name)
primary_key=$(awk -F ':' 'NR==3 {print $0}' ./Databases/$database_name/.metadata/$table_name)

#Asking the user for the column to update and checking if not inputting anything
while true; 
do
    read -p "Please type the name of column you wish to update " update_column
    if validate_input "$update_column"
      then
        break
    fi
done

#checking if the column exists
column_update_found=false
index=0
for col in $columns_names
    do  
        ((index++))
        if [ "$col" = "$update_column" ];then
                col_data_type=$(awk -F ':' -v i=$index  'NR==2 {print $i}' ./Databases/$database_name/.metadata/$table_name)
                column_update_found=true
                break
        fi
    done

if [ "$column_update_found" = false ]; then
    echo "The column you entered doesn't exist, returning to menu"
    echo "----------------------------------------------------"
    sleep 2
    clear
    ./menu.sh "$database_name"
    exit
fi    

#Asking the user for the new value and checking if the user doesn't input anything
while true; do
    read -p "Please type the new value to update: " value
    if validate_input "$value"; then
        # Check if the column is int && primary key
        if [[ $update_column = $primary_key && $col_data_type = "int" ]]; then
            # Search for existing primary key values
            if [[ $value =~ ^[0-9]+$ ]]; then
                if awk -F':' -v column_number=$index -v value=$value '$column_number == value { found = 1; exit } END { exit !found }' "./Databases/$database_name/$table_name"; then
                    echo "This is a primary key column and the value already exists!"
                else
                    break
                fi
            else
                echo "Invalid input! The value should be an integer."
            fi
        # Check if the column is int
        elif [[ $col_data_type = "int" ]]; then
            if [[ $value =~ ^[0-9]+$ ]]; then
                # Valid integer
                break
            else
                echo "Invalid input! The value should be an integer."
            fi
        # Check if the column is string && primary key
        elif [[ $update_column = $primary_key && $col_data_type = "string" ]]; then
            if [[ $value =~ ^[a-zA-Z][a-zA-Z_@]+$ ]]; then
                # Search for existing primary key values
                if awk -F':' -v column_number=$index -v value=$value '$column_number == value { found = 1; exit } END { exit !found }' "./Databases/$database_name/$table_name"; then
                    echo "This is a primary key column and the value already exists!"
                else
                    break
                fi
            else
                echo "Invalid input! The value should be a string."
            fi
        # Check if the column is string
        elif [[ $col_data_type = "string" ]]; then
            if [[ $value =~ ^[a-zA-Z][a-zA-Z_@]+$ ]]; then
                # Valid string
                break
            else
                echo "Invalid input! The value should be a string."
            fi
        fi
    fi
done

#Asking the user for the condition column and checking if not inputting anything
while true; 
do
    read -p "Please type the name of the condition column " condition_column
    if validate_input "$condition_column"
      then
        break
    fi
done

#checking if the column exists
column_condition_found=false
index_2=0
for col in $columns_names
    do  
        ((index_2++))
        if [ "$col" = "$condition_column" ];then
                col_data_type=$(awk -F ':' -v i=$index_2  'NR==2 {print $i}' ./Databases/$database_name/.metadata/$table_name)
                column_condition_found=true
                break
        fi
    done

if [ "$column_condition_found" = false ]; then
    echo "The column you entered doesn't exist, returning to menu"
    echo "----------------------------------------------------"
    sleep 2
    clear
    ./menu.sh "$database_name"
    exit
fi

#Asking the user for the condition field and checking if the user doesn't input anything and the fields exists in the table
while true; 
do
    read -p "Please type the condition field " condition_field 
    if validate_input "$condition_field"
      then
        if awk -F':' -v column_number=$index_2 -v value=$condition_field '$column_number == value { found = 1; exit } END { exit !found }' "./Databases/$database_name/$table_name"; then
        break
        else
        echo "Invalid input! this fields doesn't exist"
        fi
    fi
done

#updating the column
if [ "$update_column" = "$primary_key" ]; then
    awk -F ':' -v update_column=$index -v condition_column=$index_2 -v condition_field=$condition_field -v value=$value 'BEGIN { OFS=FS=":" } $condition_column == condition_field && !updated { $update_column = value; updated = 1 }{ print }' "./Databases/$database_name/$table_name" > temp.txt && mv temp.txt "./Databases/$database_name/$table_name"
else
    awk -F ':' -v update_column=$index -v condition_column=$index_2 -v condition_field=$condition_field -v value=$value 'BEGIN { OFS=FS=":" } $condition_column == condition_field { $update_column = value }{ print }' "./Databases/$database_name/$table_name" > temp.txt && mv temp.txt "./Databases/$database_name/$table_name"

fi

echo "The field was updated successfully !"
echo "----------------------------------------------------"
sleep 2
clear
./menu.sh "$database_name"
exit
}

select choice in "update table" "return to menu" 
  do
    case "$REPLY" in 

      1)
        #calling update function
	      update_table
	    ;;

      2)    
        #returning to menu
           clear
          ./menu.sh "$database_name"
          exit
        ;;

      *)
	    echo "Invalid number! please select a number from  (1-2)  "
        ;;
    esac
  done
