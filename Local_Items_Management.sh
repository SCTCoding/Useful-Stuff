#! /bin/bash

# This script is for basic local items keychain management for debug/utility drives.
# This is useful for any time you have a drive that is connected to many computers,
# and you want to avoid the issue of run-away local items keychains.
# This script is best run as a launch agent.

# Navigate to the user keychain folder.
cd /Users/debug/Library/Keychains

# Identify the local items keychain folders.
lnames=$(find . -regex ".*/[A-F0-9\-]\{36\}" | cut -c 3-40)

# Recursively delete all of them.
for i in ${lnames[@]}
do
	rm -R $i
done

# Stop trustd and secd.
launchctl stop com.apple.secd
launchctl stop com.apple.trustd.agent

# Start trustd and secd
launchctl start com.apple.secd
launchctl start com.apple.trustd.agent

exit
