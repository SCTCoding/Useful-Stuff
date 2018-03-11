#! /bin/bash

# Initial Variables
marker="N"
DISK=()

# Erase Levels
echo "SECURE ERASE LEVELS"
echo "0 - Zero Disk"
echo "1 - Random Fill"
echo "2 - 7-Pass Wipe"
echo "3 - 35-Pass Wipe"
echo "4 - 3-Pass Wipe"
echo ""
read -p "What erase level do you want? " level

# Primary While Loop
while [ $marker != "Y"  ]
do
	# Read in disk ID
	read -p "Specify Disk (disk#): " val
	echo $val
	# Add the space in the lamest way possible
	fixedval=$(echo "/dev/$val ")
	# Append value to array
	DISK+=$fixedval
	# Ask if you're done with specifying disks
	read -p  "Is this all disks (Y/N)? " fnsh
	# Outputs the array for viewing and waits to give an opportunity to cancel
	echo $DISK
	sleep 2
	if [ $marker == "Y" ]
	then
		for i in ${DISK[@]}
		do
			# Define the job
			( # Define Drive Name
			newName=$(diskutil info $i | grep "Part of Whole" | awk '{print $4}')
			# Secure Wipe
			echo "Secure Erasing Disk"
			# If you change the 4 to a different value found in the diskutil man page you can change the wipe procedure.
			diskutil secureErase $level $i
			# Formatting For Use
			echo "Re-Partitioning Disk"
			diskutil eraseDisk JHFS+ $newName $i ) &
		done
		wait
	fi
done


