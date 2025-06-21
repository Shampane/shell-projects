#!/usr/sbin/bash

test_error() {
    local successMsg=$1
    local errorMsg=$2
    local log_file=$3

    if [[ $? == 0 ]]
    then
        printf "$successMsg" >> "$log_file"
    else
        printf "$errorMsg" >> "$log_file"
    fi
}

do_backup_essentials() {
    local log_file=$1
    local backup_path=$2
    local date=$3

    if [ -f "$log_file" ]
    then
        rm -f "$log_file"
    fi

    if [ ! -d "$backup_path" ]
    then
        mkdir "$backup_path"
    fi

    mkdir "$backup_path/$date"
}

directories=(
    "/home/user/shell_projects/"
    "/home/user/bash_utils"
)

date=$(date +"%Y-%m-%d_%H-%M-%S")
backup_path="/home/$(whoami)/DIRS_BACKUPS"
log_file="$backup_path/backup.log"
do_backup_essentials "$log_file" "$backup_path" "$date"
 
printf "Starting backup...\n" >> "$log_file"

for dir in "${directories[@]}"
do
    destination="$backup_path/$date/$(basename "$dir")"
    cp -r "$dir" "$destination" 2>> "$log_file"
done

printf "$backup_path/$date.tar\n"
tar cf "$backup_path/$date.tar" "$backup_path/$date" 2>> "$log_file"
test_error "Archivation directories is successful\n" "Archivation directories failed\n" "$log_file"

bzip2 "$backup_path/$date.tar" 2>> "$log_file"
test_error "Backup is successful\n" "Backup failed\n" "$log_file"

exit 0  