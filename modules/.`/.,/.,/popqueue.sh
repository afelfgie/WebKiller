#       pushqueue element ...
#
# Pushes the given arguments as elements onto the queue.
#
pushqueue() {
    [[ $_queue ]] || {
        coproc _queue {
            while IFS= read -r -d ''; do
                printf '%s\0' "$REPLY"
            done
        }
    }

    printf '%s\0' "$@" >&"${_queue[1]}"
} # _____________________________________________________________________

#       popqueue
#
# Pops one element off the queue.
# If no elements are available on the queue, this command fails with exit code 1.
#
popqueue() {
    local REPLY
    [[ $_queue ]] && read -t0 <&"${_queue[0]}" || return
    IFS= read -r -d '' <&"${_queue[0]}"
    printf %s "$REPLY"
} # _____________________________________________________________________

