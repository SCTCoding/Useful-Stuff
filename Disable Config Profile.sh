#! /bin/bash

# Must be run as root.

read -p "Would you like to disable the configuration profile on this machine? (type disable or enable)? " dec

if [ $dec == "disable" ]
then
  if [ -f /private/var/db/ConfigurationProfiles/Store/ConfigProfiles.binary ]
  then
      mv /private/var/db/ConfigurationProfiles/Store/ConfigProfiles.binary /private/var/db/ConfigurationProfiles/Store/ConfigProfiles.binary1
    
      # Find configd’s pid
      pid=$(ps -Ac | grep configd | awk ‘{print $1}’)

      # Kill configd
      kill $pid
      
      echo "Profile disabled"
  else
      echo "Failed to disable profile."
  fi

else
  if [ -f /private/var/db/ConfigurationProfiles/Store/ConfigProfiles.binary1 ]
  then
      mv /private/var/db/ConfigurationProfiles/Store/ConfigProfiles.binary1 /private/var/db/ConfigurationProfiles/Store/ConfigProfiles.binary
    
      # Find configd’s pid
      pid=$(ps -Ac | grep configd | awk ‘{print $1}’)

      # Kill configd
      kill $pid
      
      echo "Profile re-enabled."
    
  else
      echo "Failed to re-enable profile."
  fi
fi
exit
