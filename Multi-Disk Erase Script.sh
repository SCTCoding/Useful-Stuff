#! /bin/bash

# Initial Variables
fnsh="N"
DISK=()

# Primary While Loop
while [ $fnsh != "Y"  ]
do
	# Read in disk ID
	read -p "Specify Disk (/dev/disk#): " val
	echo $val
	# Add the space in the lamest way possible
	fixedval=$(echo "$val ")
	# Append value to array
	DISK+=$fixedval
	# Ask if you're done with specifying disks
	read -p  "Is this all disks (Y/N)? " fnsh
	# Outputs the array for viewing and waits to give an opportunity to cancel
	echo $DISK
	sleep 2
	if [ $fnsh == "Y" ]
	then
		for i in ${DISK[@]}
		do
			# Define Drive Name
			newName=$(diskutil info $i | grep "Part of Whole" | awk '{print $4}')
			# Secure Wipe
			echo "Secure Erasing Disk"
			# If you change the 4 to a different value found in the diskutil man page you can change the wipe procedure.
			diskutil secureErase 4 $i &
			wait
			# Formatting For Use
			echo "Re-Partitioning Disk"
			diskutil eraseDisk JHFS+ $newName $i &
			wait
		done
	fi
done


