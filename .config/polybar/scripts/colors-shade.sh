#!/bin/bash

## Author : Zhenhui Xie
## Github : heyrict

PDIR="$HOME/.config/polybar"
LAUNCH="polybar-msg cmd restart"
 
for index in `seq 1 8`; do 
    # Replacing shade colors
    prefix=${1:1}
    key=shade${index}
    color=$(grep "^$prefix$key = .*" $PDIR/colors.ini | sed "s/^.* = //")
    sed -i -e "s/^$key = .*/$key = $color/g" $PDIR/colors.ini
done
