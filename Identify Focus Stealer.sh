#! /bin/bash

while [[ $(wc -l ~/Desktop/log.txt | awk '{print $1}' 2>/dev/null) -le 10000 ]]
do
	frontapp1=$(osascript -e 'tell application "System Events" to get name of processes whose frontmost is true')
	sleep 0.05
	frontapp2=$(osascript -e 'tell application "System Events" to get name of processes whose frontmost is true')
	if [ $frontapp1 != $frontapp2 ]
	then
		echo $frontapp1 >> ~/Desktop/log.txt
	fi
done

exit
