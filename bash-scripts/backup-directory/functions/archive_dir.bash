#!/usr/bin/bash

# Name: archive_dir.bash
# Description:
#       Archives the specified directory using bzip2 compression.
#       The archive name includes the current date.
#       Save all messages about the archive process to the specified log file
# Author: Volosnikov Ivan
# Date: 22/06/2025

# Input:
#   - user_dir: directory to archive and compress
#   - log_file: log file to save the messages about the process

source "./functions/print_message.bash"
source "./functions/print_error.bash"

archive_dir() {
    local user_dir=$1
    local backup_dir=$2
    local log_file=$3

    print_message "[message]: starting backup of $user_dir..." "$log_file"
    tar cfj "$backup_dir/$(date +%d-%m-%Y)_$user_dir.tar" "$user_dir" 2>>"$log_file"

    if [ $? -eq 0 ]; then
        print_message "[success]: backup completed: $log_file/$(date +%d-%m-%Y)_$user_dir.tar" "$log_file"
    else
        print_error "[error]: backup failed for $user_dir" "$log_file"
    fi

    exit 1
}
