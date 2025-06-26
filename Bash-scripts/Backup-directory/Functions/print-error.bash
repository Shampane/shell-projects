#!/usr/bin/bash

# Name: print-error.bash
# Description:
#       Redirect the specified error string to STDERR.
#       The string includes the current date.
#       Save the error message to the specified log file
# Author: Volosnikov Ivan
# Date: 23/06/2025

# Input:
#   - message: error string to print and save to log file
#   - log_file: log file to save the error string

functions_dir="./Functions"

source "$functions_dir/print-with-timestamp.bash"

print-error() {
    local message=$1
    local log_file=$2

    print-with-timestamp "$message" >>"$log_file"
    print-with-timestamp "$message" >&2

    exit 1
}
