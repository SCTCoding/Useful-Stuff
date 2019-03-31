#! /bin/bash

# Defines Input/Output
target=$1
out=$2

if [ $# -ne 2 ]
then
	echo "Please provide target app path and then target output path."
	exit
fi

# Creates the string values needed next
stringValues=$(otool -v -s __TEXT __cstring $target/Contents/MacOS/* | cut -d ' ' -f2- | cut -d ' ' -f2 | grep -E '^[a-zA-Z0-9_.-]{10,80}$' | sort | uniq)

# Loop through values
for i in ${stringValues[@]}
do
	bundleID=$(defaults read $target/Contents/Info.plist CFBundleIdentifier)
	prefix="defaults read-type $bundleID"
	candidateValue=$(echo $prefix $i)
	tester=$($candidateValue 2>/dev/null)
	if [[ ! -z $tester ]]
	then
		echo $candidateValue | cut -d " " -f3- >> $out/VerifiedDefaults.txt
		$candidateValue >> $out/VerifiedDefaults.txt
	else
		echo $candidateValue | cut -d " " -f3- >> $out/CandidateDefaults.txt
	fi
done

