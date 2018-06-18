#! /bin/bash

# This script takes a binary as an input, and the output folder as the second argument.
# The script then copies the binaries to the output folder and dumps a function list.


# Input Values
execpath="$1"
output="$2"

# Main logic find the paths of the dependents.
for i in $(otool -L "$execpath" | awk '{print $1}' | tail -n+2 | sed 's/\@rpath//g')
do
	# Copy the files.
	cp $i "$output"
	# Dump the functions.
	nm -o "$output"/* >> "$output"/functions.txt
done