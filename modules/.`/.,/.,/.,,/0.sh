set -l symbols ◷ ◶ ◵ ◴
while sleep 0.5
    echo -e -n "\b$symbols[1]"
    set -l symbols $symbols[2..-1] $symbols[1]
end
