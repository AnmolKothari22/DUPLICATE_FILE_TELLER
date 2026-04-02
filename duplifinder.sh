#!/bin/bash

if [ "$#" -eq 0 ]; then
	echo "please give atleast one file path"
	exit
fi

echo "exact matches are in same line"
# formating is left 
# present it nicely ..without hashes
#

./two_file_compare/duplifile.sh $@

echo "exact text match(no whitspace counted) are in same line"
python3 ./two_file_compare/visual_compare.py $@
./two_file_compare/duplifile.sh ./two_file_compare/tempfolder




