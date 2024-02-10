#!/bin/bash
#Changing PS3 to thhe name of the database
PS3="select what to do in database $1 from (1-8) "
clear
echo "------------------------------------------"
echo "Connected to $1 successfully!"
echo "------------------------------------------"
echo "--------------------"
echo "Manipulation Menu"
echo "--------------------"

select choice in "create table" "list tables" "drop table" "insert into table" "select from table" "delete from table" "update table" "return to menu"
  do
    case "$REPLY" in 

      1)
        #calling create table script
	      ./create_table.sh $1
	    ;;

      2)    
        #calling list tables script
	      ./list_tables.sh $1
        ;;

      3)    
        #calling drop table script
	      ./drop_table.sh $1
        ;;

      4)    
        #calling insert into table script
	      ./insert_tb.sh $1
        ;;

      5)    
        #calling select from table script
	      ./select_from_table.sh $1
        ;;

      6)
        #calling delete from table script
	      ./delete_from_table.sh $1
        ;;

      7)
        #calling update table script
	      ./update_table.sh $1
        ;;

      8)
        clear
        ./main.sh
        break
        ;;	

      *)
	      echo "Invalid number! please select a number from  (1-8)  "
       ;;
    esac
  done