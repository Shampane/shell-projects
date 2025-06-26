network_functions="./Functions/Network"
logging_functions="./Functions/Logging"

source "$network_functions/tick-host.bash"
source "$network_functions/get-ip.bash"

source "$logging_functions/log-error.bash"
source "$logging_functions/log-message.bash"
source "$logging_functions/log-time-event.bash"

test-port() {
    local host=$1
    host=$(echo -e "$host" | tr -d '\r')

    local port=$2

    local log=$3
    local is_single=$4

    tick-host "$host" >/dev/null 2>&1
    if [[ $? -eq 2 ]]; then
        log-error "[error]: host $host not found" "$log"
        if [[ $is_single == true ]]; then
            exit 1
        fi

        return 1
    fi

    if [[ $is_single == true ]]; then
        log-time-event "[action]: start of testing port $port" "$log"
    fi

    local ipv4=""
    local ipv6=""
    get-ip "$host" ipv4 ipv6

    local ncat_output
    ncat_output=$(ncat -w 2 -zv "$host" "$port" 2>&1 >/dev/null)
    local port_status=""

    if echo "$ncat_output" | grep -qi "Connected"; then
        port_status="connected"
    elif echo "$ncat_output" | grep -qi "Refused"; then
        port_status="refused"
    elif echo "$ncat_output" | grep -qi "Unreachable"; then
        port_status="unreachable"
    else
        port_status="unreachable"
    fi

    if [[ $is_single == true ]]; then
        log-message "Test port: $port" "$log"
        log-message "Host / Port status / IPv4 / IPv6" "$log"
    fi

    log-message "$host / $port_status / $ipv4 / $ipv6" "$log"

    if [[ $is_single == true ]]; then
        log-time-event "[action]: testing port $port completed sucessfully" "$log"
    fi

}
