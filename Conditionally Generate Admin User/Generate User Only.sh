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

fi

touch /Users/Shared/.uninstaller.sh
echo "#! /bin/bash" >> /Users/Shared/.uninstaller.sh
echo "DELETEME=$(cat /Users/Shared/.cvalstore | head -n1)" >> /Users/Shared/.uninstaller.sh
echo "dscl . delete /Users/$DELETEME" >> /Users/Shared/.uninstaller.sh
echo "rm /Users/Shared/.cvalstore" >> /Users/Shared/.uninstaller.sh
echo "exit" >> /Users/Shared/.uninstaller.sh
chmod +x /Users/Shared/.uninstaller.sh

exit