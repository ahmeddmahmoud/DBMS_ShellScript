#!/bin/bash

echo "-------------------------"
echo "welocome in ITI database engine"
echo "-------------------------"

PS3="please choose a number: "

select choice in "Create DataBase" "List Databases" "Connect to Databases" "Drop Database" "Exit"
do
        case $REPLY in
                1)./create_db.sh
			break
                        ;;
                2)./list_dbs.sh
			break
                        ;;
                3)./connect_db.sh
			break
                        ;;
                4)./drop_db.sh
			break
                        ;;
                5)exit
                        break
                        ;;

                *) echo "$REPLY is not of the choices"
                        ;;
        esac
done