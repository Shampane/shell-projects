#!/bin/bash

print_line() {
    local length=$1
    printf "%-${length}s\n" " " | tr " " "-"  
}

add_user() {
    read -p "Input username to add: " username
    useradd $username
    printf "User '$username' was added\n"
}

set_password() {
    read -p "Input username to change password: " username
    passwd $username
}


remove_user() {
    read -p "Input username to remove: " username

    while true
    do 
        read -p "Remove $username's the home directory and mail spool (yes/no)?: " is_remove_dir
        if [[ $is_remove_dir == "yes" || $is_remove_dir == "y" ]]
        then
            userdel -r $username
            printf "User '$username' was removed\n"
            break
        elif [[ $is_remove_dir == "no" || $is_remove_dir == "n" ]]
        then
            userdel $username
            printf "User '$username' was removed\n"
            break
        else
            printf "Wrong value, try again\n"
        fi
    done
}

format_print_users() {
    local line_length=80

    print_line $line_length

    printf "%-16s %-10s %-10s %-20s %-24s\n" "User" "UID" "GID" "Home directory" "Shell"

    print_line $line_length

    while IFS= read -r line
    do
        local name=$(printf "$line\n" | cut -d ":" -f 1)
        local uid=$(printf "$line\n" | cut -d ":" -f 3)
        local gid=$(printf "$line\n" | cut -d ":" -f 4)
        local directory=$(printf "$line\n" | cut -d ":" -f 6)
        local shell=$(printf "$line\n" | cut -d ":" -f 7)

        printf "%-16s %-10s %-10s %-20s %-24s\n" $name $uid $gid $directory $shell
    done

    print_line $line_length
}

print_users() {
    while true
    do 
        read -p "Print only simple users (yes/no)?: " is_show_simple
        if [[ $is_show_simple == "yes" || $is_show_simple == "y" ]]
        then
            local str=$(cat "/etc/passwd" | grep -E "^root|/home" | sort -t ':' -k3n)
            format_print_users <<< "$str"

            break
        elif [[ $is_show_simple == "no" || $is_show_simple == "n" ]]
        then
            local str=$(cat "/etc/passwd" | sort -t ':' -k3n)
            format_print_users <<< "$str"
            break
        else
            printf "Wrong value, try again\n"
        fi
    done
}

print_about_user() {
    read -p "Input username: " username

    local groups=$(id "$username" | cut -d "=" -f 4 | tr -s "," " ")
    local uid=$(cat /etc/passwd | grep "^$username" | cut -d ":" -f 3)
    local directory=$(cat /etc/passwd | grep "^$username" | cut -d ":" -f 6)
    local shell=$(cat /etc/passwd | grep "^$username" | cut -d ":" -f 7)
    local lastlog=$(lastlog -u user | awk '/user/ { print $1, $2, $3, $4, $5, $6, $7 }' | cut -d " " -f 3-7)

    local groups_length=$(echo "- Shell by default: $shell" | wc -c)
    local shell_length=$(echo "- Shell by default: $shell" | wc -c)

    printf "\nInformation about '$username'\n"
    
    print_line 40

    echo "- User ID: $uid"
    echo "- Groups: $groups"
    echo "- Home directory: $directory"
    echo "- Shell by default: $shell"
    echo "- Last login: $lastlog"
    echo "- Sessions:"
    who | grep user
    
    print_line 40
}

show_user_interface() {
    while true
    do
        printf "\nAvailable action\n"
        printf "1. Add user\n"
        printf "2. Set password for user\n"
        printf "3. Remove user\n"
        printf "4. Print all users\n"
        printf "5. Print about certain user\n"
        printf "6. Exit\n\n"

        read -p "Input action: " action
        case $action in
            1)
                add_user
                ;;
            2)
                set_password
                ;;
            3)
                remove_user
                ;;
            4)
                print_users
                ;;
            5)
                print_about_user
                ;;
            6)
                exit 0
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