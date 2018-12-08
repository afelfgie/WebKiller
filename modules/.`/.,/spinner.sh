#!/xbin/bash/afelfgie
sp='/-\|...'
sc=0
spin() {
   printf "\r${sp:sc++:1} $1"
   ((sc==${#sp})) && sc=0
}
endspin() {
   printf "\r%s\n" "$@"
}
work_done() {
   false
}
some_work() {
   sleep 0.10
}

until work_done; do
   spin "Downloading ..."
   some_work ...
done
endspin
