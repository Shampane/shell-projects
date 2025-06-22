#!/usr/bin/bash

# Name: backup_directory.bash
# Description:
#       Archives the specified directory using bzip2 compression.
#       The archive name includes the current date.
#       All generated archives are stored in the the user's dedicated
#       backup directory, located at "$HOME/backups".
# Author: Volosnikov Ivan
# Date: 22/06/2025

# Input:
#   - user_dir ($1 argument): the full path to the directory that needs to be archived.
#     The mandatory argument. The directory must exist and be readable.

# Output:
#   - Creates a compressed archive (.tar) in "$HOME/backups".
#   - Process and error messages are logged to "$HOME/backups/log.txt" and also printed to the console

# Usage:
#       ./backup_directory.bash /path/to/your/directory

source "imports.bash"

backups_dir="/$HOME/backups"
backups_log="/$HOME/backups/log.txt"

if [ ! -d "$backups_dir" ]; then
    mkdir "$backups_dir"
fi

if [ -z "$1" ]; then
    print_error "[error]: directory doesn't specified" "$backups_log"
fi

user_dir=$1
if [ ! -d "$user_dir" ]; then
    print_error "[error]: directory doesn't exist" "$backups_log"
fi

archive_dir "$user_dir" "$backups_dir" "$backups_log"

exit 0
