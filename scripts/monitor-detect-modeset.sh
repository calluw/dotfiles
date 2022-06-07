#!/bin/bash

# setting up new mode for my VGA
#xrandr --newmode "1080p" 148.5 1920 2008 2052 2200 1080 1089 1095 1125 +hsync +vsync
#xrandr --addmode DP-1-2 1080p
#xrandr --addmode DP-1-1 1080p

# functions to switch from eDP-1 to DP-1-2 and vice versa
function ActivateVGA {
    echo "Switching to dual screen"
    #xrandr --auto
    AUTO=$?
    xrandr --output eDP-1 --off \
           --output DP-1-2 --crtc 2 --auto --mode 1920x1080 \
           --output DP-1-3 --auto --primary --mode 1920x1080 --left-of DP-1-2
    RC=$?
    #eDP-1=$?
    #xrandr --output DP-1-1 --preferred
    #DP1=$?
    #xrandr --output DP-1-2 --preferred --primary --left-of DP-1-1
    #DP2=$?
    #xrandr --output eDP-1 --preferred --right-of DP-1-1
    #eDP-1=$?
    #if [[ $AUTO -eq 0 ]] && [[ $DP1 -eq 0 ]] &&\
    #   [[ $DP2 -eq 0 ]] && [[ $eDP-1 -eq 0 ]]; then
    if [[ $RC -eq 0 ]]; then
        echo "Switched to dock setup successfully"
    elif [[ ! $NO_RECOVER -eq 1 ]]; then
        echo "Failed to setup screens!"
        DeactivateVGA
    fi
}

function ActivateSingleMon {
    xrandr --output eDP-1 --off \
           --output DP-1-2 --off \
           --output DP-1-3 --auto --primary
    RC=$?
    if [[ $RC -eq 0 ]]; then
        echo "Switched to single monitor setup successfully"
    elif [[ ! $NO_RECOVER -eq 1 ]]; then
        echo "Failed to setup screens!"
        DeactivateVGA
    fi
}

function DeactivateVGA {
    echo "Switching to eDP-1"
    xrandr --output DP-1-2 --off \
           --output DP-1-3 --off \
           --output eDP-1 --auto
}

# functions to check if VGA is connected and in use
function VGAConnected {
    xrandr | grep "^DP-1-2" | grep " connected" >/dev/null
}

function SingleMonConnected {
    xrandr | grep "^DP-1-3" | grep " connected" >/dev/null
}

# actual script
if VGAConnected
then
    ActivateVGA
elif SingleMonConnected
then
    ActivateSingleMon
else
    DeactivateVGA
fi
