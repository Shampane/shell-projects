#!/usr/bin/bash

# Name: print-message.bash
# Description:
#       Print the specified string.
#       The string includes the current date.
#       Save the message to the specified log file
# Author: Volosnikov Ivan
# Date: 23/06/2025

# Input:
#   - message: string to print and save to log file
#   - log_file: log file to save the string

functions_dir="./Functions"

source "$functions_dir/print-with-timestamp.bash"

print-message() {
    local message=$1
    local log_file=$2

    print-with-timestamp "$message" >>"$log_file"
    print-with-timestamp "$message"
}
