#! /bin/bash

for i in {00..34}
do 
	if [[ $i -lt 10 ]]
	then 
		i="0${i}"
	fi
	/usr/bin/yaa extract -i /Users/default/Downloads/95b559f1c50a74cfad1cddb1be7712a6563441b7/AssetData/payloadv2/payload.0${i} -ignore-eperm -d /Users/default/Desktop/outdir/
done

exit 0
