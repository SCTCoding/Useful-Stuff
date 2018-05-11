#! /bin/bash

read -p "Which application do you want to target? " app

window_id=$(osascript -e "tell application \"$app\" to id of windows")

echo "Listed from top to bottom."
echo "$app - $window_id"

exit
