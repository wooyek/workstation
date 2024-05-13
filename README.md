# workstation

Scripts for partially unattended setup of my Linux workstation

## Setup

These scripts help me get a new OS to install ready for work quickly:

	curl -L https://raw.githubusercontent.com/wooyek/workstation/master/get.sh | bash
    
I currently with Kubuntu.

## No splash screen on boot

Replace `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"` with `GRUB_CMDLINE_LINUX_DEFAULT=""` in `/etc/default/grub` then run `sudo update-grub`.


## Kubuntu widgets

- https://github.com/orblazer/plasma-applet-resources-monitor
- https://github.com/Zren/plasma-applet-volumewin7mixer
- https://github.com/Zren/plasma-applet-eventcalendar

## TODO

These require manual settings (help getting them scripted is appreciated):

1. Setup terminal to use [Sauce Code Pro Nerd Font Complete Mono](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf)
2. Setup [Dracula color scheme](https://store.kde.org/p/1001521)
3. Setup Papirus icon set
4. Disable [quiet splash during boot](https://askubuntu.com/questions/33416/how-do-i-disable-the-boot-splash-screen-and-only-show-kernel-and-boot-text-inst)

