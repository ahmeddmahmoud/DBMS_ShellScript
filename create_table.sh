#!/bin/bash
db_name=$1
col_line=""
col_array=""

function create_column(){
	
	datatype=""
while true;
do
	echo "------------------------------------"
        read -p "Please enter the number of columns: " col_num
        if [[ $col_num =~ ^[1-9][0-9]*$ ]]
        then
                break;
        else
		echo "--------------------------------"
                echo "Please enter valid numbers only! "
        fi
done

for ((i=1 ; i <= col_num ; i++ ))
do
	while true
	do
		echo "--------------------------------------"
		read -p "PLease enter column name: " col_name
		if [[ $col_name =~ ^[A-Za-z] ]] && [[ $col_name = +([a-zA-Z0-9_]) ]] && [ ! $(echo "$col_line" | awk -v col_name="$col_name" -F ":" '{for (i=1; i<=NF; i++) if ($i == col_name) {print "true"; exit}}') ] 
		then
			break 
		else
			echo "---------------------------------"
			echo "PLease enter a valid column name"
		fi
	done
	if (( $i <= col_num ))
	then
		
		col_line+="$col_name:"
		PS3="please choose a data type for $col_name : "
		select choice in "int" "string"
		do
			case $REPLY in
				1) 
					datatype+="int:"
					break
					;;
				2)
					datatype+="string:"
					break
					;;
				*) echo "$REPLY is not of the choices"
					;;
			esac
		done
	fi 
done
   echo -e "$col_line" >> ./Databases/$db_name/.metadata/$tb_name
   echo -e "$datatype" >> ./Databases/$db_name/.metadata/$tb_name
   col_array=(${col_line//:/ })
   while true
   do
	   echo "------------------------------------------"
          read -p "Please enter name of column you want to make primary key: " p_k
	  found=false
	  for element in "${col_array[@]}"; do
              # Check if p_k is equal to the current element
              if [ "$p_k" = "$element" ]; then
                 found=true
                 break
              fi
         done

          if $found
          then
		primary_key=$p_k
	        echo -e "$primary_key" >> ./Databases/$db_name/.metadata/$tb_name
	        echo "-----------------------------------------------"	
	        echo "Primary key $p_k set successfully, returning back to menu"
			sleep 2
	        break
          else
		  echo "------------------------------------"
	        echo "Primary key not found in the list of columns"
          fi
  done

}
echo "------------------------------------------"
echo -e "PLease enter the name of table: \c"
read -r tb_name

if [[ -z $tb_name ]]
then
	echo "--------------------------------------"
        echo "Table name can not be empty !!!!!!"
        ./create_table.sh $1
elif [[ "$tb_name" =~ [^a-zA-Z0-9_] ]];then
        echo "-----------------"
        echo "Invalid input!"
        echo "-----------------"
elif [[ ! $tb_name =~ \S ]] && [ -e "./Databases/$db_name/$tb_name" ]
then
	echo "------------------------"
	echo "Table $tb_name is already exist, returning to menu"
	sleep 2
	clear
	./menu.sh "$db_name"


elif [[ $tb_name =~ ^[A-Za-z] ]] && [[ $tb_name = +([a-zA-Z0-9_]) ]]
then
	touch ./Databases/$db_name/$tb_name
	mkdir -p ./Databases/$db_name/.metadata
	touch ./Databases/$db_name/.metadata/$tb_name
	echo "----------------------------"
	echo "Table $tb_name is created succssefully "
	create_column
	sleep 2
	clear
	./menu.sh "$db_name"

else
	echo "-------------------------"
	echo "Please enter a valid name"
	echo "-------------------------"
	./create_table.sh $1
fi

