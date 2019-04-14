#! /bin/bash

## Provide binary paths as array with names in quotes.
## The code has issues with spaces so it often advisable to copy the binaries and remove spaces. Or fix the code.
applist=()

## Loop through list of apps.
for name in ${applist[@]}
do
	## Find the frameworks and filter for unwanted.
	listFrames=$(otool -L "$name" | grep -E '/System/Library|/usr/lib' | grep -v rpath | grep -v loader_path | cut -d '(' -f 1 | awk '{print $1}')
	## Loop for functions in app
	for i in $(nm -j -u "$name") 
	do 
		## Loop for functions in framework
    	for j in ${listFrames[@]}
	    do
	    	## Search for function name in framework list
    	    if nm -j -U $j | grep "$i"
        	then
        		## Print framework - function to output list
            	echo "$j - $i" >> /Users/$(whoami)/Desktop/$(basename $name)-Positive.txt
	        fi
    	done
	done
	
	## For items in output 
	for i in $(awk '{print $3}' /Users/$(whoami)/Desktop/$(basename $name)-Positive.txt)
	do 
		## Determine if the function in app is not in list
    	if ! nm -j -u "$name" | grep "$i"
	    then 
	    	## Dump results to file
    	    echo $i  >> /Users/$(whoami)/Desktop/$(basename $name)-Negative.txt
	    fi
	done
done
