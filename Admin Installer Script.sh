#! /bin/sh
# Obatin username, gid, and password
username=$(osascript -e 'set inputuser to text returned of (display dialog "What username would you like?" default answer "")')

password=$(osascript -e 'set inputpw to text returned of (display dialog "What password would you like?" default answer "" with hidden answer)')

gidinput=$(osascript -e 'set inputgid to text returned of (display dialog "What GID would you like?" default answer "510" with hidden answer)')

# Create the user
sudo dscl . -create /Users/"${username}"
sudo dscl . -create /Users/"${username}" UserShell /bin/bash
sudo dscl . -create /Users/"${username}" RealName "${username}" 
sudo dscl . -create /Users/"${username}" UniqueID "${gidinput}"
sudo dscl . -create /Users/"${username}" PrimaryGroupID 20
sudo dscl . -create /Users/"${username}" NFSHomeDirectory /Users/"${username}"
sudo dscl . -passwd /Users/"${username}" "${password}"

# Make them an admin
sudo dscl . -append /Groups/admin GroupMembership "${username}"


# Refresh the users list
sudo launchctl stop com.apple.opendirectoryd
sudo launchctl start com.apple.opendirectoryd
