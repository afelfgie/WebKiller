#!/usr/bin/env bash

spinner() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    printf ' '
    while sleep 0.5; do
        printf "%s\b" "${sp:i++%n:1}"
    done
}

printf 'Doing important work '
spinner &

sleep 10  # sleeping for 10 seconds is important work

kill "$!" # kill the spinner
printf '\n'
