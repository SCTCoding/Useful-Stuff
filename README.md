# Useful-Stuff
A collection of scripts and junk code that may be useful.


## send_nmi.sh
This is the easiest way to send an NMI event to a VM that I have found; especially when dealing with 10.12 or 10.13. Not my original idea (https://cloudtone.wordpress.com/2012/12/13/vmware-fusion-can-you-diag-it-nmi/). I simply updated the script so it works with current VMWare fusion. The VM needs to be suspended, and run the script locally as ./send_nmi.sh. Put this script in the virtual machine bundle that you want to interact with. Also be sure to disable SIP.

I got this to work running: 
- sudo kextcache -invalidate / 
- sudo nvram boot-args="0x141 pmuflags=1 -v"

May not be the prettiest thing, but it works. On the host machine make sure to install the Kernel Development Kit and run: target create $KDK file and then copy the command script and run that too. Last but not least make sure you know the IP of the VM so you can run kdp-remote $IP in time for the NMI script to trigger the catch.

Usual caveats apply about what will and will not work debugger interaction-wise.

## Multi-Disk Erase Script.sh
This is just a quick script for erasing multiple drives on a Mac quickly. Default is 3 pass-wipe. This can be made more interactive. I just tossed it together because I needed it. Feel free to improve.

## Disable Config Profile.sh
This is just a simple script for disable configuration profiles without a reboot. This is non-destructive. Useful for testing and other shennanigans.

## LocalItems-Keychain-Solver.sh
This is a simple script for dealing with local items keychain issues encountered in certain environments. The dreaded local items keychain popup that causes frustration and irritation.

## Local_Items_Management.sh
This is a script used to keep the number of local items keychains from running away in situations where the drive is booting many computers. For example debug/utility drives used by IT professionals.

## Drive Mapping
These are some basic scripts for mapping shares in OS X. The idea being that one can open the script, and paste the path to have it automatically added to the saved share list. Useful in mixed environments.

## VirusTotal Results.sh
Just a fun little script that hashes a file and outputs a VirusTotal results screenshot.

## WindowID.sh
Just a quick script to get the window ID of open windows in an application.

## Dump Executables.applescript
This is a script I have been using for disassembly. The basic idea is given a complex application with multiple parts copy the executables to a folder, and then dump their otool depencency list and nm function list. The idea is you can then grep the file for interesting stuff and target your disassembly to the optimal executables.

## BlindGrab.sh
This is a copy script to grab ephemeral files and directories that are difficult to catch on the file system. It is a brute force try as fast as possible design.

## Outlook Autodiscover.applescript
This script allows you to disable or enable background autodiscovery in Microsoft Outlook 2016.

## Copy Dependants.sh
This script dumps dependants listed by otool to a folder, and then dumps a functions list for those files. Quick way to research binaries.

## Kill Script
A basic kill script for FileVaulted machines non APFS. Will add a user with random password, and remove other users from filevault. It then shuts the machine down. Idea is you have to erase the machine to use it again. This iteration works with a two users.

## Admin Bypass Control
Allows you to disable the bypass for no admin user by deleting the .AppleSetupDone file. The script disables the mbsetupuser which prevents setup assistant from running.
