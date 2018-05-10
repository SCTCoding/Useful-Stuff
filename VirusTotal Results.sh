#! /bin/bash

# Obtain filepath
read -p "Where is the file located? " path

# Generate the hash
hash=$(shasum "$path" | awk '{print $1}') 

# Now add hash to URL and open.
open https://www.virustotal.com/#/search/$hash

# Wait for the inter-webs to load
sleep 10 

# Capture the screen
screencapture -l $(osascript -e 'tell app "Safari" to id of window 1') /Users/$USER/Desktop/$hash.png

# Done
exit
