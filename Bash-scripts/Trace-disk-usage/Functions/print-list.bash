#!/usr/bin/bash

# Name: print-list.bash
# Description:
#   Print list of filesystem disk usages with filters and colors
# Author: Volosnikov Ivan
# Date: 23/06/2025

functions_dir="./Functions"
source "$functions_dir/print-with-colors.bash"

print-list() {
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
                print-with-red "$line"
            elif [[ "$usage" -ge 50 ]]; then
                print-with-yellow "$line"
            else
                printf "%s\n" "$line"
            fi
        fi
    done
}
