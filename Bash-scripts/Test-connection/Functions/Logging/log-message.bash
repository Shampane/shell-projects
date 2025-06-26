log-message() {
    local message=$1
    local log_file=$2

    printf "%s\n" "$message" >>"$log_file"
    printf "%s\n" "$message"
}
