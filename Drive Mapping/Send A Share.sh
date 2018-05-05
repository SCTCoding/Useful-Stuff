#! /bin/bash

# Purpose of this script is to provide a simple double-click share add method.

# Select set to "unc" then the script will do UNC convert otherwise not.
select=""
# Define what paths we are going to add. Remember don't mix and match. Either UNC or not.
	declare -a paths=(
	  # Paths in quotes
	)

if [[ $select == "unc" ]]
then
	for i in ${paths[@]}
	do
		# UNC Converter
		unc_slash=$(echo -n $i | sed -e 's/\\/\//g' | cut -c2-100000)
		# Adjust smb for whatever you are looking for.
		unc_conv=$(echo -n "smb://$unc_slash")
	
		# Add Path
		/usr/bin/sfltool add-item -n "$unc_conv" com.apple.LSSharedFileList.FavoriteServers "$unc_conv"
	
		# Open each
		open $unc_conv
	done
else
	for i in ${paths[@]}
	do	
		# Add Path
		/usr/bin/sfltool add-item -n "$i" com.apple.LSSharedFileList.FavoriteServers "$i"
	
		# Open each
		open $i
	done
fi
