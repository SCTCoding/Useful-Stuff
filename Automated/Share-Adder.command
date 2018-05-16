#! /bin/bash

# Remove Login Item
osascript -e 'tell application "System Events" to delete login item "Add-Home-Share.command"'

# Determine user share path
select=`osascript -e 'set choice to (choose from list {"PATH1", "PATH2"} with prompt "Please select department:" default items "None" OK button name {"Choose"} cancel button name {"Cancel"})'`

# Functional logic
if [[ $select == "$PATH" ]]
then
	# DIR PATH ADD
	path1=$(echo -n "smb://$SHARE/$PATH/$USER")
	/usr/bin/sfltool add-item -n "Home Drive - $USER" com.apple.LSSharedFileList.FavoriteServers "$path1"
	# Open Share
	open $path1
else
	if [[ $select == "$PATH" ]]
	then
		# ODEXT PATH ADD
		path2=$(echo -n "smb://$SHARE/$PATH/$USER")
		/usr/bin/sfltool add-item -n "Home Drive - $USER" com.apple.LSSharedFileList.FavoriteServers "$path2"
		# Open Share
		open $path2
	else
		exit
	fi
fi

# Delete Script
rm -- "$0"

# Kill the Terminal
osascript -e 'do shell script "killall Terminal"'

