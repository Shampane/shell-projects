#!/usr/bin/bash

# Name: print_message.bash
# Description:
#       Print the specified string.
#       The string includes the current date.
#       Save the message to the specified log file
# Author: Volosnikov Ivan
# Date: 22/06/2025

# Input:
#   - user_str: string to print and save to log file
#   - log_file: log file to save the string

source "./functions/print_str_with_date.bash"

print_message() {
    local user_str=$1
    local log_file=$2

    print_str_with_date "$user_str" >>"$log_file"
    print_str_with_date "$user_str"
}
