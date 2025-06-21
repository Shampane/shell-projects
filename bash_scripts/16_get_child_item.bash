#!/usr/bin/bash

print_line() {
    local len=$1
    printf "%-${len}s\n" " " | tr " " "-"
}

print_header() {
    local arg=$1
    files="$arg/*"

    size=$(du -sh "$arg" | awk '{print $1}')
    files_count=0
    dirs_count=0

    for item in $files
    do
        [ -f "$item" ] && ((files_count++))
        [ -d "$item" ] && ((dirs_count++))
    done

    printf "Total size: %s\n" "$size"
    printf "Count of files: %s\n" "$files_count"
    printf "Count of directories: %s\n\n" "$dirs_count"
}

print_payload() {
    local arg=$1
    len=$(( $(printf "%-48s %-14s %-8s %-12s %-12s %-8s %-3s %-1s %5s\n" "Access mode" "Links" "User" "Group" "Size" "Modified" "" "" "Name"  | wc -c) - 1))

    printf "%-48s %-14s %-8s %-12s %-12s %-8s %-3s\n" "Name" "Access Mode" "Links" "User" "Group" "Size" "Modified"
    print_line $len
    ls -lh "$arg" | awk 'NR>1 { printf "%-48s %-14s %-8s %-12s %-12s %-8s %-3s %-1s %5s\n", $9, $1, $2, $3, $4, $5, $6, $7, $8 }'
    print_line $len
}

arg="${1:-.}"
if [ ! -d "$arg" ]
then
    printf "%s\n" "Directory '$arg' is not found"
    exit 0
fi

print_header "$arg"
print_payload "$arg"

exit 0