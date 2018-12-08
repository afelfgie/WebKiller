#afelfgie-bash
files=(*.zip)
dialog --gauge "Working..." 20 75 < <(
   n=${#files[@]} i=0
   for f in "${files[@]}"; do
      # process "$f" in some way (for testing, "sleep 1")
      echo $((100*(++i)/n))
   done
)
# Bash 4
mapfile -t lines < "$inputfile"
n=${#lines[@]}
i=0
for line in "${lines[@]}"; do
    echo "$((100*(++i)/n))"
    # process the line (use "sleep 1" or similar to test)
done | dialog --gauge "Working..." 20 75
i=0
while ((i < 100)); do
  printf "\r%3d%% complete" $i
  ((i += RANDOM%5+2))
  # Of course, in real life, we'd be getting i from somewhere meaningful.
  sleep 1
done
echo
bar="=================================================="
barlength=${#bar}
i=0
while ((i < 100)); do
  # Number of bar segments to draw.
  n=$((i*barlength / 100))
  printf "\r[%-${barlength}s]" "${bar:0:n}"
  ((i += RANDOM%5+2))
  # Of course, in real life, we'd be getting i from somewhere meaningful.
  sleep 1
done
echo
files=(*)
width=${COLUMNS-$(tput cols)}
rev=$(tput rev)

n=${#files[*]}
i=0
printf "$(tput setab 0)%${width}s\r"
for f in "${files[@]}"; do
   # process "$f" in some way (for testing, "sleep 1")
   printf "$rev%$((width*++i/n))s\r" " "
done
tput sgr0
echo
prog() {
    local max=$((${COLUMNS:-$(tput cols)} - 2)) in n i
    while read -r in; do
        n=$((max*in/100))
        printf '\r['
        for ((i=0; i<n; i++)); do printf =; done
        for ((; i<max; i++)); do printf ' '; done
        printf ']'
    done
}

mapfile -t lines    # read stdin as input
n=${#lines[@]}
i=0
for line in "${lines[@]}"; do
    echo "$((100*(++i)/n))"
    # process the line (use "sleep 1" or similar to test)
done | prog
pv "$1" > "$2/${1##*/}"
rsync -avx --progress --stats "$1" "$2"
