#!/usr/bin/bash

# Name: print_error.bash
# Description:
#       Redirect the specified error string to STDERR.
#       The string includes the current date.
#       Save the error message to the specified log file
# Author: Volosnikov Ivan
# Date: 22/06/2025

# Input:
#   - user_str: error string to print and save to log file
#   - log_file: log file to save the error string

source "./functions/print_str_with_date.bash"

print_error() {
    local user_str=$1
    local log_file=$2

    print_str_with_date "$user_str" >>"$log_file"
    print_str_with_date "$user_str" >&2

    exit 1
}
