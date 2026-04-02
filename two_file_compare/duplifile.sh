#!/bin/bash

if [ "$#" -eq 0 ]; then
	echo "please give atleast one file path"
	exit
fi


declare -A maps

add() {
	local key=$1
	local value=$2

		     
	if [[ -z "${maps[$key]}" ]]; then
	local arr="arr_$key"
	maps[$key]=$arr
	declare -g -a "$arr=()"
	fi
		    
		                                         
	declare -n ref=${maps[$key]}
	ref+=("$value")
}


for arg in $@ ; do
	if [ -d $arg ]; then
		#echo "directory given"
		for arg2 in $arg/* ; do
			#echo $arg2
			if [ -f $arg2 ]; then
				TEM=$(  sha256sum $arg2 | awk '{print $1}' )
				#echo $TEM
				add $TEM $arg2
			fi
		done	
	else
		
		TEM=$(  sha256sum $arg | awk '{print $1}' )
		#echo $TEM
		add $TEM $arg
	fi
done

for key in "${!maps[@]}"; do
    declare -n ref="${maps[$key]}"

    echo -n "same files on following path ->"

    for i in "${!ref[@]}"; do
        val="${ref[$i]}"

        if [[ "$val" == *:* ]]; then
            ref[$i]="${val#*:}"   # remove everything up to first colon
        fi

        echo  -n " ${ref[$i]} , "
    done
	printf "\n"
done






