#!/bin/bash

bspc config focus_follows_pointer false
bspc desktop -l tiled

alacritty &
sleep 0.25

bspc config split_ratio 0.3015 && \
firefox --new-window https://calendar.google.com/calendar/u/0/r &
sleep 1.25

bspc config split_ratio 0.642 && \
zathura ~/notes/$1/$2.pdf &
sleep 0.25

bspc config split_ratio 0.777 && \
alacritty -e cava &
sleep 0.25

bspc node -f west.local

bspc config split_ratio 0.952 && bspc node -p south && \
zathura &
sleep 0.25

bspc node -f west.local

bspc config split_ratio 0.52
bspc config focus_follows_pointer true

notify-send -u low -t 3000 $2 notes &
exit 0