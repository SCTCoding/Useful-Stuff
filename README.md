# Useful-Stuff
A collection of scripts and junk code that may be useful.


## send_nmi.sh
This is the easiest way to send an NMI event to a VM that I have found; especially when dealing with 10.12 or 10.13. Not my original idea (https://cloudtone.wordpress.com/2012/12/13/vmware-fusion-can-you-diag-it-nmi/). I simply updated the script so it works with current VMWare fusion. The VM needs to be suspended, and run the script locally as ./send_nmi.sh. 

I got this to work running: 
- sudo kextcache -invalidate / 
- sudo nvram boot-args="0x141 pmuflags=1 -v"

May not be the prettiest thing, but it works. On the host machine make sure to install the Kernel Development Kit and run: target create $KDK file and then copy the command script and run that too. Last but not least make sure you know the IP of the VM so you can run kdp-remote $IP in time for the NMI script to trigger the catch.

Usual caveats apply about what will and will not work debugger interaction-wise.
