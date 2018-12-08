#!/bin/bash/afelfgie{gunadicbr}
clear
for (( i=1; i <= 5; i++ ));
do
    for (( j=1; j<= 100; j++ ));
    do
        acakx=$(( RANDOM%20+5 ))
        acaky=$(( RANDOM%70+10 ))
        acakw=$(( RANDOM%8+1 ))
        tput cup $acakx $acaky
        echo -en "\033[1;3${acakw};4${acakw}md"
        sleep 0.05
        done
    done
echo -en "\033[0m"

