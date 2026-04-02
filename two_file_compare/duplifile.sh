#!/bin/bash

#handling no input given case....direct exit
if [ "$#" -eq 0 ]; then
	echo "please give atleast one file path"
	exit
fi


declare -A maps

# to add a file's path and hash 
add() {
	local key=$1
	local value=$2

	#if key doesn't exist in map 
	if [[ -z "${maps[$key]}" ]]; then
	local arr="arr_$key" #creating array for key
	maps[$key]=$arr
	declare -g -a "$arr=()"
	fi
		    
		                                         
	declare -n ref=${maps[$key]}
	ref+=("$value") #adding values
}

#iterating over paths
for arg in $@ ; do
	if [ -d $arg ]; then # if the path points to a directory
		#NOTE: its non recursive!!
		for arg2 in $arg/* ; do #for files in directory 
			if [ -f $arg2 ]; then
				TEM=$(  sha256sum $arg2 | awk '{print $1}' ) # generating hash
				add $TEM $arg2
			fi
		done	
	else
		TEM=$(  sha256sum $arg | awk '{print $1}' )
		#echo $TEM
		add $TEM $arg
	fi
done

#iterating over map
for key in "${!maps[@]}"; do
    declare -n ref="${maps[$key]}" #referance to array of key

    echo -n "same files on following path ->"

    for i in "${!ref[@]}"; do #iterating over map's values
        val="${ref[$i]}"
		#cleanup begin
        if [[ "$val" == *:* ]]; then #only for elements with : , 
            ref[$i]="${val#*:}"   # remove everything up to first colon cause python script makes files like :DUPLICATE_FILE_TELLER/two_file_compare:actual path: ...so actual path is extracted from here 
        fi
		#cleanup ends
        echo  -n " ${ref[$i]} , " 
    done
	printf "\n"
done






