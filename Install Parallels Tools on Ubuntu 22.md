## Purpose
I want to document what works to install Parallels Tools on Ubuntu 22. 
## What You Will See
Typically you will see modpobe issues or prl_tg errors.
## Steps
- Install the prerequisites: `sudo apt install -y dkms libelf-dev build-essential linux-headers$(uname -r) gcc-12`
You may find that the linux-headers$(uname -r) doesn't work. Don't worry about it. The install should work regardless.
- Link GCC-12: `sudo ln -sf /usr/bin/gcc-12 /usr/bin/gcc`
- Install Parallels Tools
  - Mount the Parallels Tools Disk
  - Run the installer: `sudo /media/$(whoami)/"Parallels Tools"/install` OR `sudo /media/$(whoami)/"Parallels Tools"/install-gui`
- Reboot If you use the GUI installer you will be prompted to reboot. The CLI version doesn't. So use: `sudo reboot`
- Make sure remove the disc if it doesn't automatically go away on reboot.
