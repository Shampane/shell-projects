#!/usr/bin/bash

# Name: show_help.bash
# Description:
#   Show help message for trace_disk_usage.bash job
# Author: Volosnikov Ivan
# Date: 23/06/2025

show_help() {
    cat <<__EOF__
Usage: trace_disk_usage.bash [-u <usage_percentage>] [-t <filesystem_type>] [-m <mounted_path_regex>] [-h]
Description: provides a color-coded, sorted overview of your system's filesystems, with options to filter by disk usage, type, and mount path.

Flags:
    -u <usage_percentage>   : Minimum disk usage percentage to display (e.g., -u 80)
    -t <filesystem_type>    : Filter by filesystem type (e.g., -t ext4)
    -m <mounted_path_regex> : Filter by mounted start path (e.g., -m "/var" shows "/var*")
    -h                      : Show help message

Examples:
    trace_disk_usage.bash              : Show all filesystems
    trace_disk_usage.bash -u 75        : Show filesystems with 75% usage or more
    trace_disk_usage.bash -t xfs -u 50 : Show xfs filesystems with 50% usage or more
    trace_disk_usage.bash -m "/home"   : Show filesystems mounted under /home*
__EOF__
}
