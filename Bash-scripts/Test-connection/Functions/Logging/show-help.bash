show-help() {
    cat <<__EOF__
Usage: test-connection.bash [-p <specific_port>] [-t] [-h]
Description: provides testing network connectivity to one or more hosts using ping, traceroute, or port checks with logging

Flags:
    -p <specific_port> : Ping specific number port (e.g., -p 80)
    -t                 : Show traceroute to the host
    -h                 : Show help message

Examples:
    test-connection.bash github.com         : Ping github.com
    test-connection.bash -p 443 google.com  : Test 443 port of google.com
    trace_disk_usage.bash -t hosts.txt      : Traceroute to hosts from the file
__EOF__
}
