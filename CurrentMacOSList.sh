#! /bin/bash

osCurrent=$(/usr/bin/curl "https://support.apple.com/en-us/109033" | /usr/bin/grep -oE '[0-9]{2}\.[0-9]{1,2}\.[0-9]{1}</p></td>' | /usr/bin/awk -F '<' '{print $1}')
fullVersion=$(/usr/bin/sw_vers -productVersion)

primary=$(echo "$fullVersion" | awk -F '.' '{print $1}')
major=$(echo "$fullVersion" | awk -F '.' '{print $2}')
minor=$(echo "$fullVersion" | awk -F '.' '{print $3}')

if [[ $(echo "$osCurrent" | /usr/bin/grep "$fullVersion") ]]
then
  echo "Current"
else
  matchedPrimary=$(echo "$osCurrent" | /usr/bin/grep -E "^${primary}")
  majorCurrent=$(echo "$matchedPrimary" | awk -F '.' '{print $2}')
  minorCurrent=$(echo "$matchedPrimary" | awk -F '.' '{print $2}')

  if [[ $majorCurrent < $major ]] || [[ $minorCurrent < $minor ]]
  then
    echo "Current"
  else
    echo "Not Current"
  fi
fi

exit 0

