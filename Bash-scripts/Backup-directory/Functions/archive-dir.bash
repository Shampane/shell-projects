#!/usr/bin/bash

# Name: archive-dir.bash
# Description:
#       Archives the specified directory using bzip2 compression.
#       The archive name includes the current date.
#       Save all messages about the archive process to the specified log file
# Author: Volosnikov Ivan
# Date: 23/06/2025

# Input:
#   - user_dir: directory to archive and compress
#   - log_file: log file to save the messages about the process

functions_dir="./Functions"

source "$functions_dir/print-message.bash"
source "$functions_dir/print-error.bash"

archive-dir() {
    local user_dir=$1
    local backup_dir=$2
    local log_file=$3

    local archive_name="${user_dir/./}"
    archive_name="$backup_dir/$(date +%d-%m-%Y)_${archive_name/\//}.tar"

    print-message "[message]: starting backup of $user_dir..." "$log_file"
    tar cfj "$archive_name" "$user_dir" 2>>"$log_file"

    if [ $? -eq 0 ]; then
        print-message "[success]: backup completed: $archive_name" "$log_file"
    else
        print-error "[error]: backup failed for $archive_name" "$log_file"
    fi

    exit 1
}
