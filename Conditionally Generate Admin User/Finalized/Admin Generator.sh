#! /bin/bash

#Global Variables
USERNAME=$(openssl rand -hex 2)
PASSWORD=$(openssl rand -hex 3)
ID=$(jot -r 1 148728 377832)

# Look for the specified file.
while [ -f /Users/Shared/Test.txt ]
do
# Make sure that the cvalstore file hasn't been created.
if [ ! -f /Users/Shared/.cvalstore ]
then
	# Write the username out to the cvalstore so we can track it and delete it later.
	echo $USERNAME > /Users/Shared/.cvalstore
	# Create User
	dscl . -create /Users/$USERNAME
	dscl . -create /Users/$USERNAME UserShell /bin/bash
	dscl . -create /Users/$USERNAME RealName "$USERNAME"
	dscl . -create /Users/$USERNAME UniqueID "$ID"
	# Primary group is 80 to be sure the user is an admin.
	dscl . -create /Users/$USERNAME PrimaryGroupID 80
	dscl . -passwd /Users/$USERNAME $PASSWORD
	# If you change to PrimaryGroupID 20 then you need this.
	# dscl . -append /Groups/admin GroupMembership $USERNAME

	# Enable if you are running as a script locally.
	# osascript -e 'tell app "System Events" to display dialog "Username: '$USERNAME' Password: '$PASSWORD'" buttons {"OK"} default button "OK"'
	
	# We need to store the password and username.
	echo "U: $USERNAME P: $PASSWORD" >> /Users/Shared/.cvalstore

	# Enable only if you want to set the user PrimaryGroupID to the normal 20. This will make sure if you run this locally you get an enabled Admin without restart or logout.
	# launchctl stop com.apple.opendirectoryd
	# launchctl start com.apple.opendirectoryd
	
	# Stop the loop.
	break

fi

done

# Check to make sure the file is gone.
if [ ! -f /Users/Shared/Test.txt ]
then
	# Determine the user name.
	DELETEME=$(cat /Users/Shared/.cvalstore | head -n1)
	# Remove the user.
	dscl . delete /Users/$DELETEME
	# Delete our creds cache.
	rm /Users/Shared/.cvalstore
fi


exit
