network_functions="./Functions/Network"
logging_functions="./Functions/Logging"

source "$network_functions/tick-host.bash"
source "$network_functions/get-ip.bash"

source "$logging_functions/log-error.bash"
source "$logging_functions/log-message.bash"
source "$logging_functions/log-time-event.bash"

trace-host() {
    local host=$1
    host=$(echo -e "$host" | tr -d '\r')

    local log=$2
    local is_single=$3

    tick-host "$host" >/dev/null 2>&1
    if [[ $? -eq 2 ]]; then
        log-error "[error]: host $host not found" "$log"
        if [[ $is_single == true ]]; then
            exit 1
        fi

        return 1
    fi

    if [[ $is_single == true ]]; then
        log-time-event "[action]: start of tracing $host" "$log"
    fi

    local ipv4=""
    local ipv6=""
    get-ip "$host" ipv4 ipv6

    if [[ $is_single == true ]]; then
        log-message "Host / IPv4 / IPv6" "$log"
    fi

    log-message "$host / $ipv4 / $ipv6" "$log"
    traceroute -I "$host" | tail -n+2

    if [[ $is_single == true ]]; then
        log-time-event "[action]: tracing $host completed sucessfully" "$log"
    fi
}
