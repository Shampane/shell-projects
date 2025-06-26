#!/usr/bin/bash

# Name: trace-disk-usage.bash
# Description:
#   This script shows your system's filesystems, sorted by disk usage percentage,
#   with clear color-coding for easy monitoring. You can filter the output
#   by disk usage, filesystem type, and mounted path.
# Author: Volosnikov Ivan
# Date: 23/06/2025

# Output:
#   Show system's filesystems, sorted by disk usage percentage with colors and filters
# Usage:
#   ./trace-disk-usage.bash [-u <usage_percentage>] [-t <filesystem_type>] [-m <mounted_path_regex>] [-h]

source "imports.bash"

search_usage=0
search_type=""
search_mounted=""

handle-flags search_usage search_type search_mounted "$@"

print-list "$search_usage" "$search_type" "$search_mounted"

exit 0
