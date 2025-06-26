tick-host() {
    local host=$1
    ping -c 1 -w 5 "$host" >/dev/null 2>&1
}
