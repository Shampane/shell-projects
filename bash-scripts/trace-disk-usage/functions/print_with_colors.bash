#!/usr/bin/bash

# Name: print_with_colors.bash
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

print_with_red() {
    local str=$1

    printf "${red}%s${nc}\n" "$str"
}

print_with_yellow() {
    local str=$1

    printf "${yellow}%s${nc}\n" "$str"
}
