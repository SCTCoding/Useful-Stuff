#! /bin/sh

# Identify the name of the local items keychain folder.
# localkc=$(ls /Users/$USER/Library/Keychains/ | head -n 1)
localkc=$(system_profiler SPHardwareDataType | grep "Hardware UUID" | awk '{print $3}')

echo "Determined the name of the local items keychain folder."
echo "..."

# Determine if the folder already exists.
# if [ -d "/Users/$USER/Library/Keychains/$localkc" ]
if [ -f "/Users/$USER/Library/Keychains/$localkc/keychain-2.db" ]
	then
		# If the the local items keychain folder exists look for Safari
		if ps -Ac | grep "Safari"
			then
				# If not then find Safari by PID and kill it.
				osascript -e 'tell application "Safari" to quit'
				result=1
				echo "Determined the state of Safari and closed Safari."
				echo "..."
			else
				# If Safari isn't open then we make a note of it.
				result=0
				echo "Safari was not open. Just making a note."
				echo "..."
		fi

		# Make a backup of the local items keychain
		# Make folder for the keychain in /tmp
		mkdir /tmp/lkcbackup
		# Copy the files to the folder
		cp /Users/$USER/Library/Keychains/$localkc/keychain* /tmp/lkcbackup/
		
		# Sync the WAL file back to the database.
		sqlite3 /tmp/lkcbackup/keychain-2.db "PRAGMA wal_checkpoint"
		
		# Remove the WAL file and SHM file.
		rm /tmp/lkcbackup/keychain-2.db-*

		# Destroy the folder.
		rm -R /Users/$USER/Library/Keychains/$localkc

	else
		# If the folder doesn't exist, then we exit. No need to do this if no local items keychain.
		exit
fi


echo "Local items keychain is now backed up."
echo "..."
echo "Waiting on the OS."
echo "..."
# Wait for the OS
sleep 5

echo "Stopping services."
echo "..."
# Launchctl Restart
launchctl stop com.apple.secd
launchctl stop com.apple.trustd.agent

echo "Wating on the OS again."
echo "..."
# Wait for the OS
sleep 2

echo "Starting the services up again."
echo "..."		
launchctl start com.apple.secd
launchctl start com.apple.trustd.agent

echo "Activating Safari."
echo "..."
# Now open Safari to sync things up.
osascript -e 'tell application "Safari" to activate'

echo "Wating for the OS again..."
echo "..."
# Wait for the OS
sleep 5

echo "Removing and replacing the local items keychain."
echo "..."
# Remove the new keychain automatically created.
rm /Users/$USER/Library/Keychains/$localkc/keychain*

# Move the orignal keychain back to retain the user's password.
cp /tmp/lkcbackup/keychain* /Users/$USER/Library/Keychains/$localkc/


echo "Restart them services again."
echo "..."
# Launchctl Restart again
launchctl stop com.apple.secd
launchctl stop com.apple.trustd.agent

echo "More waiting on the os..."
echo "..."
# Wait for the OS
sleep 2

echo "Services are back."
echo "..."
launchctl start com.apple.secd
launchctl start com.apple.trustd.agent

echo "Double-checking our work, and making sure everything is back to the way it should be."
echo "..."
# Check if the local items keychain is open by secd and or trustd
if lsof | grep keychain-2.db | grep -Eq 'secd|trustd'
	then
		# If it is then delete the backup we don't need it.
		rm -R /tmp/lkcbackup

		# Check if Safari was open.
		if [ $result -eq 0 ]
			then
				# If not then find Safari by PID and kill it.
				osascript -e 'tell application "Safari" to quit'
			else
				osascript -e 'tell application "Safari" to activate'
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
		if [ $result -eq 0 ]
			then
				# If not then find Safari by PID and kill it.
				osascript -e 'tell application "Safari" to quit'
			else
				osascript -e 'tell application "Safari" to activate'
		fi
fi
exit
