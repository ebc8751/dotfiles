#!/bin/sh
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi
PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/home/ebc/.scripts:/home/ebc:/home/ebc/opt/altera/quartus/bin:/home/ebc/opt/altera/modelsim_ase/linuxaloem:/home/ebc/opt/altera/modelsim_ase/bin:/home/ebc/opt/altera/modelsim_ase:" &
export PATH &
source /etc/profile &
xrdb -merge ~/.Xresources &
xset -b &
xsetroot -cursor_name left_ptr &
devmon --no-gui --no-startup-id &
compton &
#feh --randomize --bg-fill ~/.wallpaper/* &
#feh --bg-fill ~/Desktop/Wallpaper.png &
sxhkd -c /home/ebc/.config/sxhkd/sxhkdrc &

exec bspwm -s "$PANEL_FIFO" -p W 
