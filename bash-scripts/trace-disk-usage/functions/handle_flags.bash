#!/usr/bin/bash

# Name: handle_flags.bash
# Description:
#   Handle user flags for trace_disk_usage.bash and
#   set values of vars by references
# Author: Volosnikov Ivan
# Date: 23/06/2025

functions_dir="./functions"
source "$functions_dir/show_help.bash"

handle_flags() {
    local -n handle_search_usage=$1
    local -n handle_search_type=$2
    local -n handle_search_mounted=$3

    shift 3
    OPTIND=1

    while getopts ":u:t:m:h" opt; do
        case $opt in
        u)
            handle_search_usage=$OPTARG
            ;;
        t)
            handle_search_type=$OPTARG
            ;;
        m)
            handle_search_mounted=$OPTARG
            ;;
        h)
            show_help
            exit 0
            ;;
        \?)
            printf "%s\n" "[error]: wrong argument '-$OPTARG'" >&2
            exit 1
            ;;
        :)
            printf "%s\n" "[error]: wrong value for option '-$OPTARG'" >&2
            exit 1
            ;;
        esac
    done

    shift $((OPTIND - 1))
}
