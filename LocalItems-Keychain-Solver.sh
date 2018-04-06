#! /bin/sh

# Check for Safari
if ps -Ac | grep "Safari"
	then
		spid=$(ps -Ac | grep "Safari" | awk '{print $1}')
		kill $spid
fi

# Identify Keychain Folder
localkc=$(ls /Users/$USER/Library/Keychains/ | head -n 1)

# Make a backup of their stuff
mkdir /tmp/lkcbackup
cp /Users/$USER/Library/Keychains/$localkc/keychain* /tmp/lkcbackup/

# Destroy the folder.
rm -R /Users/$USER/Library/Keychains/$localkc

# Wait for the OS
sleep 5

# Launchctl Restart
launchctl stop com.apple.secd
launchctl stop com.apple.trustd.agent

sleep 2
		
launchctl start com.apple.secd
launchctl start com.apple.trustd.agent

osascript -e 'tell application "Safari" to activate'

# Wait for the OS
sleep 5

# Remove the new keychain created.
rm /Users/$USER/Library/Keychains/$localkc/keychain*

# Move the stuff back
cp /tmp/lkcbackup/keychain* /Users/$USER/Library/Keychains/$localkc/

# Launchctl Restart
launchctl stop com.apple.secd
launchctl stop com.apple.trustd.agent

sleep 2

launchctl start com.apple.secd
launchctl start com.apple.trustd.agent

rm -R /tmp/lkcbackup

exit
