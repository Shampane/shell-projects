log-error() {
    local message=$1
    local log_file=$2

    printf "%s %s %s\n" "$(date +%d/%m/%Y)" "$(date +%H:%M:%S)" "$message" >>"$log_file"
    printf "%s %s %s\n" "$(date +%d/%m/%Y)" "$(date +%H:%M:%S)" "$message" >&2
}
