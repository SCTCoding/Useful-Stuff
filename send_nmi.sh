#!/bin/bash

DIR=$(dirname $0)

/Applications/VMware\ Fusion.app/Contents/Library/vmrun suspend $DIR/*.vmx
perl -i -pe 's/(?<=pendingNMI\x00{4})\x00/\x01/' *.vmss
/Applications/VMware\ Fusion.app/Contents/Library/vmrun start $DIR/*.vmx

# Credit
# https://cloudtone.wordpress.com/2012/12/13/vmware-fusion-can-you-diag-it-nmi/

# I have simply modernized this with current syntax for VMWare. The actual interaction and innovation is not mine.
