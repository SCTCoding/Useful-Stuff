#! /bin/bash

# Navigate to the user keychain folder.
cd /Users/debug/Library/Keychains

# Identify the local items keychain folders.
lnames=$(find . -regex ".*/[A-F0-9\-]\{36\}" | cut -c 3-40)

# Recursively delete all of them.
for i in ${lnames[@]}
do
	rm -R $i
done

exit
