#! /bin/bash

#Global Variables
USERNAME=$(openssl rand -hex 2)
PASSWORD=$(openssl rand -hex 3)
ID=$(jot -r 1 148728 377832)


if [ -f /Users/Shared/Test.txt ] && [ ! -f /Users/Shared/.cvalstore ]
then
	# Create User
	echo $USERNAME > /Users/Shared/.cvalstore
	dscl . -create /Users/$USERNAME
	dscl . -create /Users/$USERNAME UserShell /bin/bash
	dscl . -create /Users/$USERNAME RealName "$USERNAME"
	dscl . -create /Users/$USERNAME UniqueID "$ID"
	dscl . -create /Users/$USERNAME PrimaryGroupID 20
	dscl . -passwd /Users/$USERNAME $PASSWORD
	dscl . -append /Groups/admin GroupMembership $USERNAME

	osascript -e 'tell app "System Events" to display dialog "Username: '$USERNAME' Password: '$PASSWORD'" buttons {"OK"} default button "OK"'

	echo "U: $USERNAME P: $PASSWORD" >> /Users/Shared/.cvalstore

	launchctl stop com.apple.opendirectoryd
	launchctl start com.apple.opendirectoryd

else
	# Clean
	if [ ! -f /Users/Shared/.cvalstore ]
	then
		exit
	else
		DELETEME=$(cat /Users/Shared/.cvalstore | head -n1)
		dscl . delete /Users/$DELETEME
		rm /Users/Shared/.cvalstore
	fi
fi

exit