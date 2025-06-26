#!/usr/bin/bash

# Name: print-with-colors.bash
# Description:
#   Includes functions to print specific string
#   with red, yellow or green text color
# Author: Volosnikov Ivan
# Date: 23/06/2025

# Colors:
#   - Red:    >= 85% usage (critical)
#   - Yellow: >= 50% usage (warning)
#   - Green:  < 50% usage (normal)

red='\033[1;38;2;225;50;50m'
yellow='\033[1;38;2;215;165;30m'
nc='\033[0m'

print-with-red() {
    local str=$1

    printf "${red}%s${nc}\n" "$str"
}

print-with-yellow() {
    local str=$1

    printf "${yellow}%s${nc}\n" "$str"
}
