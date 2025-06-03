#!/bin/bash

read -p "Write name of the file: " filename

write_into_file () {
    local filename=$1
    printf "\nWrite strings to write into the file (NULL character to finish)\n"
    while true; 
    do 
        read line_to_write
        if [[ $line_to_write == "" ]]
        then
            printf "File content:\n"
            cat $filename
            exit 0
        else
            echo $line_to_write >> $filename
        fi
    done
}

work_with_uncreated_file () {
    local filename=$1
    printf "File doesn't exist\n"
    touch $filename
    printf "File was created\n"

    while true; 
    do 
        read -p "Do you want to write anything to it (yes/no)?: " is_write
        if [[ $is_write == "yes" || $is_write == "y" ]]
        then
            write_into_file $filename
        elif [[ $is_write == "no" || $is_write == "n" ]]
        then
            exit 0
        else
            printf "Wrong value, try again\n"
        fi
    done
}

print_existed_file () {
    local filename=$1
    printf "File exists\n"
    ls -l $filename
    printf "\nFile content:\n"
    cat $filename
}

if [ ! -f $filename ]
then
    work_with_uncreated_file $filename
else
    print_existed_file $filename
fi

exit 0
