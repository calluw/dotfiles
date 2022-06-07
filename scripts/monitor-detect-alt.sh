#!/bin/bash

# setting up new mode for my VGA
#xrandr --newmode "1080p" 148.5 1920 2008 2052 2200 1080 1089 1095 1125 +hsync +vsync
#xrandr --addmode DP1-2 1080p
#xrandr --addmode DP1-1 1080p

# functions to switch from eDP1 to DP1-2 and vice versa
function ActivateVGA {
    echo "Switching to dual screen"
    #xrandr --auto
    AUTO=$?
    xrandr --output eDP1 --off \
           --output DP1-2 --crtc 2 --auto --mode 1920x1080 \
           --output DP1-3 --auto --primary --mode 1920x1080 --left-of DP1-2
    RC=$?
    #eDP1=$?
    #xrandr --output DP1-1 --preferred
    #DP1=$?
    #xrandr --output DP1-2 --preferred --primary --left-of DP1-1
    #DP2=$?
    #xrandr --output eDP1 --preferred --right-of DP1-1
    #eDP1=$?
    #if [[ $AUTO -eq 0 ]] && [[ $DP1 -eq 0 ]] &&\
    #   [[ $DP2 -eq 0 ]] && [[ $eDP1 -eq 0 ]]; then
    if [[ $RC -eq 0 ]]; then
        echo "Switched to dock setup successfully"
    elif [[ ! $NO_RECOVER -eq 1 ]]; then
        echo "Failed to setup screens!"
        DeactivateVGA
    fi
}

function ActivateSingleMon {
    xrandr --output eDP1 --off \
           --output DP1-2 --off \
           --output DP1-3 --auto --primary
    RC=$?
    if [[ $RC -eq 0 ]]; then
        echo "Switched to single monitor setup successfully"
    elif [[ ! $NO_RECOVER -eq 1 ]]; then
        echo "Failed to setup screens!"
        DeactivateVGA
    fi
}

function DeactivateVGA {
    echo "Switching to eDP1"
    xrandr --output DP1-2 --off \
           --output DP1-3 --off \
           --output eDP1 --auto
}

# functions to check if VGA is connected and in use
function VGAConnected {
    xrandr | grep "^DP1-2" | grep " connected" >/dev/null
}

function SingleMonConnected {
    xrandr | grep "^DP1-3" | grep " connected" >/dev/null
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
