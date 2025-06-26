#!/usr/bin/bash

# Name: imports.bash
# Description:
#       Imports all needed functions for correct
#       trace_disk_usage.bash job
# Author: Volosnikov Ivan
# Date: 23/06/2025

functions_dir="./Functions"

if [ ! -d "$functions_dir" ]; then
    printf "%s\n" "[error]: functions for the $0 aren't found"
    exit 1
fi

source "$functions_dir/handle-flags.bash"
source "$functions_dir/print-list.bash"
