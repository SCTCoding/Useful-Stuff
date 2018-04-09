#! /bin/sh

# Identify the name of the local items keychain folder.
# localkc=$(ls /Users/$USER/Library/Keychains/ | head -n 1)
localkc=$(system_profiler SPHardwareDataType | grep "Hardware UUID" | awk '{print $3}')

# Determine if the folder already exists.
# if [ -d "/Users/$USER/Library/Keychains/$localkc" ]
if [ -f "/Users/$USER/Library/Keychains/$localkc/keychain-2.db" ]
	then
		# If the the local items keychain folder exists look for Safari
		if ps -Ac | grep "Safari"
			then
				# Find Safaris PID
				spid=$(ps -Ac | grep "Safari" | awk '{print $1}')
				# Kill Safari by PID
				kill $spid
			else
				# If Safari isn't open then we make a note of it.
				result="false"
		fi

		# Make a backup of the local items keychain
		# Make folder for the keychain in /tmp
		mkdir /tmp/lkcbackup
		# Copy the files to the folder
		cp /Users/$USER/Library/Keychains/$localkc/keychain* /tmp/lkcbackup/

		# Destroy the folder.
		rm -R /Users/$USER/Library/Keychains/$localkc

	else
		# If the folder doesn't exist, then we exit. No need to do this if no local items keychain.
		exit
fi

# Wait for the OS
sleep 5

# Launchctl Restart
launchctl stop com.apple.secd
launchctl stop com.apple.trustd.agent

# Wait for the OS
sleep 2
		
launchctl start com.apple.secd
launchctl start com.apple.trustd.agent

# Now open Safari to sync things up.
osascript -e 'tell application "Safari" to activate'

# Wait for the OS
sleep 5

# Remove the new keychain automatically created.
rm /Users/$USER/Library/Keychains/$localkc/keychain*

# Move the orignal keychain back to retain the user's password.
cp /tmp/lkcbackup/keychain* /Users/$USER/Library/Keychains/$localkc/

# Launchctl Restart again
launchctl stop com.apple.secd
launchctl stop com.apple.trustd.agent

# Wait for the OS
sleep 2

launchctl start com.apple.secd
launchctl start com.apple.trustd.agent

# Check if the local items keychain is open by secd and or trustd
if lsof | grep keychain-2.db | grep -Eq 'secd|trustd'
	then
		# If it is then delete the backup we don't need it.
		rm -R /tmp/lkcbackup

		# Check if Safari was open.
		if [ $result="false" ]
			then
				# If not then find Safari by PID and kill it.
				nspid=$(ps -Ac | grep "Safari" | awk '{print $1}')
				kill $nspid
		fi

	else
		# If it isn't open, then restart the services again.
		launchctl stop com.apple.secd
		launchctl stop com.apple.trustd.agent
		
		sleep 2

		launchctl start com.apple.secd
		launchctl start com.apple.trustd.agent

		# Now delete the backup.
		rm -R /tmp/lkcbackup

		# Also don't forget to kill Safari if need be.
		if [ $result="false" ]
			then
				nspid=$(ps -Ac | grep "Safari" | awk '{print $1}')
				kill $nspid
		fi
fi

exit
