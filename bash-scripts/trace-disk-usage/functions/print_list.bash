#!/usr/bin/bash

# Name: print_list.bash
# Description:
#   Print list of filesystem disk usages with filters and colors
# Author: Volosnikov Ivan
# Date: 23/06/2025

source "$functions_dir/print_with_colors.bash"

print_list() {
    local search_usage=$1
    local search_type=$2
    local search_mounted=$3

    df -hT | sort -r -k6 | while IFS= read -r line; do
        if [[ $line =~ ^Filesystem ]]; then
            printf "%s\n" "$line"
            continue
        fi

        read -r -a columns <<<"$line"

        type="${columns[1]}"
        usage="${columns[5]//%/}"
        mounted="${columns[6]}"

        if [[ "$usage" -ge search_usage &&
            (-z $search_type || $type == "$search_type") &&
            (-z $search_mounted || $mounted =~ ^$search_mounted) ]]; then
            if [[ "$usage" -ge 85 ]]; then
                print_with_red "$line"
            elif [[ "$usage" -ge 50 ]]; then
                print_with_yellow "$line"
            else
                printf "%s\n" "$line"
            fi
        fi
    done
}
