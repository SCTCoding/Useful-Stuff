#! /bin/bash

# Purpose of this script is to provide a simple double-click share add method.

# Define what paths we are going to add
declare -a paths=(
  # Paths in quotes
)

for i in ${paths[@]}
do
	# UNC Converter
	unc_slash=$(echo -n $i | sed -e 's/\\/\//g' | cut -c2-100000)
	unc_conv=$(echo -n "smb://$unc_slash")
	
	# Add Path
	/usr/bin/sfltool add-item -n "$unc_conv" com.apple.LSSharedFileList.FavoriteServers "$unc_conv"
	
	# Open each
	open $unc_conv
done
