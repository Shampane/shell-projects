#!/usr/bin/bash

# Name: imports.bash
# Description:
#       Imports all needed functions for correct
#       backup_directory.bash job
# Author: Volosnikov Ivan
# Date: 23/06/2025

functions_dir="./Functions"

if [ ! -d "$functions_dir" ]; then
    printf "%s\n" "[error]: functions for the $0 aren't found"
    exit 1
fi

source "$functions_dir/print-error.bash"
source "$functions_dir/print-message.bash"
source "$functions_dir/archive-dir.bash"
