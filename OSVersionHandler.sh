#! /bin/bash

function osVersionHandler {
	input="$1"

	primaryValue=$(echo -n "$input" | /usr/bin/awk -F '.' '{print $1}')
	primaryMajor=$(echo -n "$input" | /usr/bin/awk -F '.' '{print $2}')
	primaryMinor=$(echo -n "$input" | /usr/bin/awk -F '.' '{print $3}')

	fullVersion=$(/usr/bin/sw_vers -productVersion)
	primary=$(echo -n "$fullVersion" | /usr/bin/awk -F '.' '{print $1}')
	major=$(echo -n "$fullVersion" | /usr/bin/awk -F '.' '{print $2}')
	minor=$(echo -n "$fullVersion" | /usr/bin/awk -F '.' '{print $3}')	

	if [[ $primaryValue -eq $primary ]] && [[ $primaryMajor -eq $major ]] && [[ $primaryMinor -eq $minor ]]
	then
		versionReturn="MATCHES"
	else
		if [[ $primaryValue -gt $primary ]] || [[ $primaryMajor -gt $major ]]
		then
			versionReturn="OLDERMAJOR"
		elif [[ $primaryValue -eq $primary ]] && [[ $primaryMajor -eq $major ]] && [[ $primaryMinor -gt $minor ]]
		then
			versionReturn="OLDERMINOR"
		elif [[ $primaryValue -lt $primary ]] || [[ $primaryMajor -lt $major ]]
		then
			versionReturn="NEWERMAJOR"
		elif [[ $primaryValue -eq $primary ]] && [[ $primaryMajor -eq $major ]] && [[ $primaryMinor -lt $minor ]]
		then
			versionReturn="NEWERMINOR"
		fi
	fi
}

osVersionHandler "11.0.0"
echo $versionReturn
echo $primary
echo $major
echo $minor