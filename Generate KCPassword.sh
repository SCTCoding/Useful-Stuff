#! /bin/bash

uname=$(whoami)
read -p "What is the password for $uname? " pw
echo ""

mn="7D 89 52 23 D2 BC DD EA A3 B9 1F 7D 89 52 23 D2 BC DD EA A3 B9 1F 7D 89 52 23 D2 BC DD EA A3 B9 1F 7D 89 52 23 D2 BC DD EA A3 B9 1F"

#pwlength=$(echo -n $pw | xxd -p | wc -m | awk '{print $1}')

pwlength=$(echo -n $pw | wc -m | awk '{print $1}')

countover=$(echo "$(($pwlength + 1))")

endAppend=$(echo $mn | cut -d ' ' -f $countover)

pwashex=$(echo -n $pw | xxd -p)

keyvalue=7D895223D2BCDDEAA3B91F7D895223D2BCDDEAA3B91F7D895223D2BCDDEAA3B91F7D895223D2BCDDEAA3B91F

# XOR Function
# Obtained from here:
# http://www.codeproject.com/Tips/470308/XOR-Hex-Strings-in-Linux-Shell-Script
# Author is Sanjay1982 (see http://www.codeproject.com/Members/Sanjay1982)
function  xor()
{
	local res=(`echo "$1" | sed "s/../0x& /g"`)
	shift 1
	while [[ "$1" ]]; do
	    local one=(`echo "$1" | sed "s/../0x& /g"`)
	    local count1=${#res[@]}
	    if [ $count1 -lt ${#one[@]} ]
	    then
	          count1=${#one[@]}
	    fi
	    for (( i = 0; i < $count1; i++ ))
	    do
	          res[$i]=$((${one[$i]:-0} ^ ${res[$i]:-0}))
	    done
	    shift 1
	done
	printf "%02x" "${res[@]}"
}

kcvalue=$(xor $pwashex $keyvalue)

readyvalue=$(echo -n $kcvalue$endAppend)

totalchars=$(echo "$(($countover * 2))")

countfill=$(echo "$((88 - $totalchars))")

zeros="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"

zerofill=$(echo -n ${zeros:0:$countfill})

outtofile=$(echo -n ${readyvalue:0:$totalchars}$zerofill)

echo -n $outtofile | xxd -r -p > ~/Desktop/kcpassword

sudo chown root:wheel ~/Desktop/kcpassword

sudo chmod 600 ~/Desktop/kcpassword
