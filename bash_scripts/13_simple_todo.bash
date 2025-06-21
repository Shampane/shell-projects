#!/bin/bash

add_to_todo() {
    local -n arr=$1
    read -p "Input text to add: " text
    arr+=("$text")
}

remove_from_todo() {
    local -n arr=$1
    read -p "Input index to remove: " index
    unset 'arr[index]'
    arr=( "${arr[@]}" )
}

clear_todo() {
    local -n arr=$1
    while true
    do
        read -p "Do you want to clear todo (yes/no)?: " to_clear
        if [[ $to_clear == "yes" || $to_clear == "y" ]]
        then
            arr=()
            break
        elif [[ $to_clear == "no" || $to_clear == "n" ]]
        then
            break
        else
            printf "Wrong value, try again\n"
        fi
    done
}

print_todo() {
    local -n arr=$1
    for i in "${!arr[@]}"
    do
        printf "%d: %s\n" "$i" "${arr[i]}"
    done
}

save_to_file() {
    local -n arr=$1

    while true
    do
        read -p "Save TODO in the file? (yes/no): " is_save
        if [[ $is_save == "yes" || $is_save == "y" ]]
        then
            read -p "Input filename to save: " filename
            printf "%s\n" "${arr[@]}" > "$filename"
            printf "TODO was saved in '$filename'\n"
            break
        elif [[ $is_save == "no" || $is_save == "n" ]]
        then
            break
        else
            printf "Wrong value, try again\n"
        fi
    done
}

read_from_file() {
    local -n arr=$1
    read -p "Input filename to read: " filename
    readarray -t arr < "$filename"
    printf "TODO was read from '$filename'\n"
}

exit_program() {
    local -n exit_arr=$1
    save_to_file exit_arr

    exit 0
}

show_user_interface() {
    todo=()

    while true
    do
        printf "\nAvailable action\n"
        printf "1. Add text to TODO\n"
        printf "2. Remove from TODO\n"
        printf "3. Clear TODO\n"
        printf "4. Print TODO elements\n"
        printf "5. Save TODO to file\n"
        printf "6. Read TODO from file\n"
        printf "7. Exit\n\n"

        read -p "Input action: " action
        case $action in
            1)
                add_to_todo todo
                ;;
            2)
                remove_from_todo todo
                ;;
            3)
                clear_todo todo
                ;;
            4)
                print_todo todo
                ;;
            5)
                save_to_file todo
                ;;
            6)
                load_from_file todo
                ;;
            7)
                exit_program todo
                ;;
            *)
                printf "Wrong value, try again\n"
                ;;
        esac
    done

    exit 0
}

show_user_interface

exit 0