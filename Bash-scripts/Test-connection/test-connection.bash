source "imports.bash"

reports_dir="./Reports"
log="$reports_dir/log.txt"

if [ ! -d "$reports_dir" ]; then
    mkdir "$reports_dir"
fi

port=-1
trace=false
flag_count=0

OPTIND=1

while getopts ":p:th" opt; do
    case $opt in
    p)
        port="$OPTARG"
        ((flag_count++))
        ;;
    t)
        trace=true
        ((flag_count++))
        ;;
    h)
        show-help
        exit 0
        ;;
    \?)
        log-error "[error]: wrong argument '-$OPTARG'" "$log"
        show-help
        exit 1
        ;;
    :)
        log-error "[error]: wrong argument '-$OPTARG'" "$log"
        show-help
        exit 1
        ;;
    esac
done

if ((flag_count > 1)); then
    log-error "[error]: specify only one flag: -p or -t, but not both at once" "$log"
    exit 1
fi

shift $((OPTIND - 1))

resource=$1

if [ ! -f "$resource" ]; then
    host=$resource
    is_single=true

    if ((port != -1)); then
        test-port "$host" "$port" "$log" $is_single
        exit 0
    fi

    if [[ $trace == true ]]; then
        trace-host "$host" "$log" $is_single
        exit 0
    fi

    ping-host "$host" "$log" $is_single
    exit 0
else
    readarray -t hosts <"$resource"
    is_single=false

    if ((port != -1)); then
        log-time-event "[action]: start of ping hosts from $resource" "$log"
        log-message "Host / Average time, ms / IPv4 / IPv6" "$log"

        for host in "${hosts[@]}"; do
            test-port "$host" "$port" "$log" $is_single
        done

        log-time-event "[action]: ping hosts from $resource completed sucessfully" "$log"

        exit 0
    fi

    if [[ $trace == true ]]; then
        log-time-event "[action]: start of tracing hosts from $resource" "$log"
        log-message "Host / IPv4 / IPv6" "$log"

        for host in "${hosts[@]}"; do
            trace-host "$host" "$log" $is_single
        done

        log-time-event "[action]: tracing hosts from $resource completed sucessfully" "$log"

        exit 0
    fi

    log-time-event "[action]: start of ping hosts from $resource" "$log"
    log-message "Host / Average time, ms / IPv4 / IPv6" "$log"

    for host in "${hosts[@]}"; do
        ping-host "$host" "$log" $is_single
    done

    log-time-event "[action]: ping hosts from $resource completed sucessfully" "$log"

    exit 0
fi
