#!/bin/bash
db_name=$1

function create_column(){
	col_line=""
	datatype=""
while true;
do
        read -p "Please enter the number of columns: " col_num
        if [[ $col_num =~ ^[0-9]+$ ]]
        then
                break;
        else
                echo "Please enter numbers only! "
        fi
done

for ((i=1 ; i <= col_num ; i++ ))
do
	while true
	do
		read -p "PLease enter column name: " col_name
		if [[ $col_name =~ ^[A-Za-z] ]] && [[ $col_name = +([a-zA-Z0-9_]) ]] 
		then
			break 
		else
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
	echo "done"
done
   echo -e "$col_line" >> ./Databases/$db_name/$tb_name
   echo -e "$datatype" >> ./Databases/$db_name/$tb_name
   while true
   do
          read -p "Please enter name of column you want to make primary key: " p_k
          if [[ $col_line == *"$p_k:"* ]]
          then
	        echo "Primary key $p_k set successfully"
	        break
          else
	        echo "Primary key not found in the list of columns"
          fi
  done

}

echo -e "PLease enter the name of table: \c"

read -r tb_name
if [ -e ./Databases/$db_name/$tb_name ]
then
	echo "------------------------"
	echo "Table $tb_name is already esist"
	./main.sh #temporary
elif [[ $tb_name =~ ^[A-Za-z] ]] && [[ $tb_name = +([a-zA-Z0-9_]) ]]
then
	touch ./Databases/$db_name/$tb_name
	echo "----------------------------"
	echo "Table $tb_name is created succssefully"
	echo "----------------------------"
	create_column
	#script
else
	echo "-------------------------"
	echo "Please enter a valid name"
	echo "-------------------------"
	#script
fi





