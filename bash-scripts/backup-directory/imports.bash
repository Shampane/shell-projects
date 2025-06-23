#!/usr/bin/bash

# Name: imports.bash
# Description:
#       Imports all needed functions for correct
#       backup_directory.bash job
# Author: Volosnikov Ivan
# Date: 22/06/2025

functions_dir="./functions"

if [ ! -d "$functions_dir" ]; then
    printf "%s\n" "[error]: functions for the $0 aren't found"
    exit 1
fi

source "$functions_dir/print_error.bash"
source "$functions_dir/print_message.bash"
source "$functions_dir/archive_dir.bash"
