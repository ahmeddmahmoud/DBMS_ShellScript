#!/bin/bash

echo "--------------------"
read -p "Please enter name of table you want to delete: " tb_name

if [[ $tb_name =~ \S ]] || [ ! -f "./Databases/$1/$tb_name" ]
then 
	echo "------------------"
        echo "table is not exist"
        echo "------------------"
else
	
        echo "------------------------------------"
        read -p "Are you sure you want to remove the table (y/n): " choice
	echo "-----------------------------------"
        case $choice in
                [Y/y])
                        rm -r ./Databases/$1/$tb_name
			rm -r ./Databases/$1/.metadata/$tb_name
                        echo "Table $tb_name deleted successfully"
                        echo "--------------------------------"
                        ;;
                [N/n])
                        echo "Removing canceled"
                        ;;
                *)
                        echo "Please choose y or n"
                        ;;
        esac

fi
