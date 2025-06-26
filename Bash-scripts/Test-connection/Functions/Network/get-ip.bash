get-ip() {
    local host=$1
    local -n v4=$2
    local -n v6=$3

    v4=$(dig +short "$host" | head -n 1)
    v6=$(getent ahostsv6 "$host" | head -n 1 | awk '{print $1}')
}
