#! /bin/bash

echo "USAGE: enter ENABLE or DISABLE depending on what you would like to do."
echo "Path to profile."
echo "EXAMPLE: SysProfileRemover.sh DISABLE $profile_identifier"
echo "EXAMPLE: SysProfileRemover.sh ENABLE $path_to_profile"
echo ""
if [ $1 == "DISABLE" ]
then
	profiles -R -p "$2"
	exit
elif [ $1 == "ENABLE" ]
then
	profiles -I -F "$2"
	exit
else
	echo "Error...exiting..."
	exit
fi
