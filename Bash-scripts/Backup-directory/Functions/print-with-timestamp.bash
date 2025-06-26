#!/usr/bin/bash

# Name: print-with-timestamp.bash
# Description:
#       Print the specified string with the current date
# Author: Volosnikov Ivan
# Date: 23/06/2025

# Input:
#   - message: user string to print

print-with-timestamp() {
    local message="$1"

    printf "%s %s %s\n" "$(date +%d/%m/%Y)" "$(date +%H:%M:%S)" "$message"
}
