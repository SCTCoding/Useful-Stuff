#! /bin/bash

# Script to Blind Grab files that are hard to obtain manually.

if [ $# -lt 3 ] # Logic to check for arguments
then
	echo "The first argument is how many times do you want to try to copy the file?"
	echo "The second argument is the posix path of the desired file."
	echo "The final arguement is: is the file a file or a directory. Specify your response with Y or N for directory or not."
	echo "EXAMPLE: BlindGrab.sh 100 /tmp/file\ i\ want.txt N"
else
	# Defining variables
	cp_count="$1"
	target="$2"
	dirchoice="$3"
	name=$(basename "$target")

	# Copy Logic
	if [ $dirchoice = "Y" ]
	then
		for run in {1..$cp_count}
		do
			if [ -d /Users/$USER/Desktop/"$name" ] # Check if folder exists.
			then
				exit
			else
				sudo cp -R "$target" /Users/$USER/Desktop/
			fi
		done	
	else
		for run in {1..$cp_count}
		do
			if [ -f /Users/$USER/Desktop/"$name" ] # Check if file exists.
			then
				exit
			else
				sudo cp "$target" /Users/$USER/Desktop/
			fi
		done	
	fi
fi

exit