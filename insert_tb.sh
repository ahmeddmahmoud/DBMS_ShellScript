#!/bin/bash
data_row=""
	echo "------------------------------"
while true;
  do
	read -p "Please enter table you want to insert into: " tb_name
    if [[ "$tb_name" =~ [^a-zA-Z0-9_] ]]; then
      echo "-----------------"
      echo "Invalid input!"
      echo "-----------------"
    else
	   break
	fi
  done

if [ -e ./Databases/$1/$tb_name ]
then
	
	values=$(awk 'NR==1 {print $0}' ./Databases/$1/.metadata/$tb_name)
	file=./Databases/$1/$tb_name
        
	data_type_line=$(awk 'NR==2 {print $0}' ./Databases/$1/.metadata/$tb_name)
	
	NF=$(echo "$values" | awk -F: '{print NF}')
	

	for ((i=1; i<$NF; i++ ))
	do
        field_name=$(echo "$values" | awk -F: -v i=$i '{print $i}')
	field_type=$(echo "$data_type_line" | awk -F: -v i=$i '{print $i}')
	pk=$(awk 'NR==3' ./Databases/$1/.metadata/$tb_name)
	

	if [ "$field_type" = "int" ]
	then
		while true
		do
			echo "----------------------------------------"
			read -p "PLease enter the value of $field_name: " data
			if [[ $data =~ ^[0-9]+$ ]]
			then
			        if [ "$pk" = "$field_name" ]
				then
					while true
					do
				        	if [[ $data =~ ^[0-9]+$ ]] && \
            awk -F: -v x="$data" -v i="$i" '$i == x {found=1; exit} END{exit !found}' "./Databases/$1/$tb_name"
				         	then

                                                          echo "$field_name is a primary key must be unique and integer"

						          read -p "PLease enter a valid value of $field_name: " data
	
						  else
						          break
                                                  fi
			        	done
                                fi
				break
			else
				echo "-------------------------------------"
				echo "please enter an integer number only !!!"


			fi
		done
	        	
	else
		while true
                do

                        read -p "PLease enter the value of $field_name: " data

                        if [[ $data =~ ^[a-zA-Z][a-zA-Z_@]+$ ]]
                        then
				if [ "$pk" = "$field_name" ]
                                then
                                        while true
                                        do
                                                if [[ $data =~ ^[a-zA-Z][a-zA-Z_@]+$ ]] && \
            awk -F: -v x="$data" -v i="$i" '$i == x {found=1; exit} END{exit !found}' "./Databases/$1/$tb_name"
                                                then
							  echo "-------------------------------------"
                                                          echo "$field_name is a primary key must be unique and string"

                                                          read -p "PLease enter a valid the value of $field_name: " data

						  else
                                                          break
                                                  fi
                                        done
                                
                                fi

                                break
                        else
				echo "-------------------------------------"
                                echo "please enter a string only !!!"


                        fi
                done
		
	fi
	data_row+="$data:"

	
        done
	echo -e "$data_row" >> ./Databases/$1/$tb_name
	echo "Insertion was completed successfully!, returning to menu"
	sleep 2
	clear
	./menu.sh "$1"
else 
	echo "Table doesn't exist, returning to menu"  
	echo "------------------------------"
	sleep 2
	clear
	./menu.sh "$1"
fi