#!/bin/sh

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi


if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi


if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi


if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi


# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


if [[ $(xrandr -q | grep 'HDMI-0 connected') ]]; then
 xrandr --output HDMI-0 --primary --mode 1920x1080 --rate 75 --rotate normal --output eDP-1-1 --mode 1920x1080 --rotate normal --left-of HDMI-0
fi

# Speedy keys
xset r rate 210 40

setxkbmap us &
exec bspwm
