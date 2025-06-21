#!/bin/bash

printf "\nWrite files to backup (NULL character to finish)\n"
while true; 
do 
    read filename
    if [[ $filename == "" ]]
    then
        exit 0
    elif [ ! -f $filename ]
    then
        printf "The file doesn't exist, try again\n"
    else
        if [ ! -d "BACKUP" ]
        then
            mkdir "BACKUP"
        fi
        if [ -f "./BACKUP/$filename" ]
        then
            printf "There's already backup of the file\n"
            while true
                do
                read -p "Override this (yes/no)?: " is_override
                if [[ $is_override == "yes" || $is_override == "y" ]]
                then
                    cp $filename "./BACKUP/$filename"
                    printf "'$filename' was overrided\n"
                    break
                elif [[ $is_override == "no" || $is_override == "n" ]]
                then
                    break
                else
                    printf "Wrong value, try again\n"
                fi
            done
            printf "Continue writing files\n\n"
        else
            cp $filename "./BACKUP/$filename"
            printf "'$filename' get backup\n"
        fi
    fi
done

backup_size=$(ls "BACKUP" | wc -l)
if [[ $backup_size == 0 ]];
then 
    rm -rf "BACKUP"
fi

exit 0