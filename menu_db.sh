#!/bin/bash

#Changing PS3 to thhe name of the database
PS3="select what to do in database $1 from (1-8)  "

select choice in "create table" "list tables" "drop table" "insert into table" "select from table" "delete from table" "update table" "return to menu"
  do
    case "$REPLY" in 

      1)
        #calling create table script
	./create_table.sh $1
	;;

      2)    
        #calling list tables script
	./main.sh
        ;;

      3)    
        #calling drop table script
	./main.sh
        ;;

      4)    
        #calling insert into table script
	./main.sh
        ;;

      5)    
        #calling select from table script
	./main.sh
        ;;

      6)
        #calling delete from table script
	./main.sh
        ;;

      7)
        #calling update table script
	./main.sh
        ;;

      8)
        ./main.sh
        ;;	

      *)
	      echo "Invalid number! please select a number from  (1-8)  "
       ;;
    esac
  done

