#! /bin/bash

# Purpose of this script is to provide a user-interactable means of adding saved file shares.


# Determine what type of connection we are saving.
prefix=`osascript -e 'set choice to (choose from list {"Screen Share", "File Share"} with prompt "Please select which kind of connection you are making:" default items "None" OK button name {"Choose"} cancel button name {"Cancel"})'`

# General Logic
if [[ $prefix == "false" ]]
then
  	# If prefix is an error then exit the script. In other words if the user cancels don't do anything.
	exit
else
  # Otherwise lets do stuff logic follows.
	if [[ $prefix == "Screen Share" ]]
	then
		# If screen share then determine the path.
		path=`osascript -e 'set T to text returned of (display dialog "What share would you like to add? (Should start with vnc://)" buttons {"Cancel", "OK"} default button "OK" default answer "vnc://")'`
		# Converts UNC to OS X useful path. Relies on proper host specification. Either spelled out or with search domains.
		unc_slash=$(echo -n $path | sed -e 's/\\/\//g' | cut -c2-100000)
		unc_conv=$(echo -n "vnc://$unc_slash")
    		# Add path to shared file list.
    		/usr/bin/sfltool add-item -n "$path" com.apple.LSSharedFileList.FavoriteServers "$path"
		# Open path
		open $path
	else
   		# Same basic flow as above but for SMB.
		path=`osascript -e 'set T to text returned of (display dialog "What share would you like to add? (Should start with smb://)" buttons {"Cancel", "OK"} default button "OK" default answer "smb://")'`
		unc_slash=$(echo -n $path | sed -e 's/\\/\//g' | cut -c2-100000)
    		unc_conv=$(echo -n "smb://$unc_slash")
		/usr/bin/sfltool add-item -n "$path" com.apple.LSSharedFileList.FavoriteServers "$path"
		open $path
	fi
fi
exit
