#! /bin/sh

# Initial folder identification and get started logic
localkc=$(ls /Users/$USER/Library/Keychains/ | head -n 1)

if [ -d "/Users/$USER/Library/Keychains/$localkc" ]
	then
		# Check for Safari
		if ps -Ac | grep "Safari"
			then
				spid=$(ps -Ac | grep "Safari" | awk '{print $1}')
				kill $spid
		fi

		# Make a backup of their stuff
		mkdir /tmp/lkcbackup
		cp /Users/$USER/Library/Keychains/$localkc/keychain* /tmp/lkcbackup/

		# Destroy the folder.
		rm -R /Users/$USER/Library/Keychains/$localkc

	else
		exit
fi

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

if lsof | grep keychain-2.db | grep -Eq 'secd|trustd'
	then
		rm -R /tmp/lkcbackup
	else
		# Launchctl Restart
		launchctl stop com.apple.secd
		launchctl stop com.apple.trustd.agent
		
		sleep 2

		launchctl start com.apple.secd
		launchctl start com.apple.trustd.agent
		
		rm -R /tmp/lkcbackup
fi

exit
