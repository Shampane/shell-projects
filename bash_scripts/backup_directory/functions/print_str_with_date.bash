#!/usr/bin/bash

# Name: print_str_with_date.bash
# Description:
#       Print the specified string with the current date
# Author: Volosnikov Ivan
# Date: 22/06/2025

# Input:
#   - user_str: user string to print

print_str_with_date() {
    local user_str="$1"

    printf "%s %s %s\n" "$(date +%d/%m/%Y)" "$(date +%H:%M:%S)" "$user_str"
}
