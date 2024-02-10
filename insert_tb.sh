#!/bin/bash
data_row=""
echo "------------------------------"
read -p "Please enter table you want to insert into: " tb_name
#echo "-------------------------------------"
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
			#echo "----------------------------------------"
			if [[ $data =~ ^[0-9]+$ ]]
			then
			        if [ "$pk" = "$field_name" ]
				then
					while true
					do
				        	if [[ $data =~ ^[0-9]+$ ]] && \
            awk -F: -v x="$data" -v i="$i" '$i == x {found=1; exit} END{exit !found}' "./Databases/$1/$tb_name"
				         	then
							  #echo "-------------------------------------"
                                                          echo "$field_name is a primary key must be unique and integer"
					        	  #echo "----------------------------------------------"
						          read -p "PLease enter a valid value of $field_name: " data
							  #echo "---------------------------------------------"
						  else
						          break
                                                  fi
			        	done
                                fi
				break
			else
				echo "-------------------------------------"
				echo "please enter an integer number only !!!"
				#echo "-------------------------------------"

			fi
		done
	        	
	else
		while true
                do
                        #echo "----------------------------------------"
                        read -p "PLease enter the value of $field_name: " data
                        #echo "----------------------------------------"
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
                                                          #echo "----------------------------------------------"
                                                          read -p "PLease enter a valid the value of $field_name: " data
							  #echo "------------------------------------------------"
						  else
                                                          break
                                                  fi
                                        done
                                
                                fi

                                break
                        else
				echo "-------------------------------------"
                                echo "please enter a string only !!!"
				#echo "-------------------------------------"

                        fi
                done
		
	fi
	data_row+="$data:"
        #echo "---------------------------"
	
        done
	echo -e "$data_row" >> ./Databases/$1/$tb_name
	echo "Insertion was completed successfully!, returning to menu"
	sleep 2
	clear
	./menu.sh "$1"
else 
	echo "Table doesn't exist"  
	echo "------------------------------"
	sleep 2
	clear
	./menu.sh "$1"
fi


