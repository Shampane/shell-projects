#!/bin/bash

print_line () {
    line_length=$1
    printf '%*s\n' $line_length '-' | tr ' ' '-'
}

get_cpu_info () {
    local line_length=$(( $(lscpu | grep -i '^model name' | wc -c) - 1 )) 

    printf "CPU information\n"
    print_line $line_length
    
    lscpu | grep -i '^architecture'
    lscpu | grep -i '^CPU(s)'
    lscpu | grep -i '^model name'
    lscpu | grep -i '^thread(s)'
    lscpu | grep -i '^core(s)'
    lscpu | grep -i 'cache'

    print_line $line_length
    printf "\n"
}

get_memory_info () {
    local line_length=24

    printf "Memory information\n"
    print_line $line_length
    
    printf "Memory\n"
    printf "– total: $(free -m | grep -i '^mem' | tr -s " " | cut -d " " -f 2)Mb \n" 
    printf "– used: $(free -m | grep -i '^mem' | tr -s " " | cut -d " " -f 3)Mb \n" 
    printf "– free: $(free -m | grep -i '^mem' | tr -s " " | cut -d " " -f 4)Mb \n" 

    printf "Swap\n"
    printf "– total: $(free -m | grep -i '^swap' | tr -s " " | cut -d " " -f 2)Mb \n" 
    printf "– used: $(free -m | grep -i '^swap' | tr -s " " | cut -d " " -f 3)Mb \n" 
    printf "– free: $(free -m | grep -i '^swap' | tr -s " " | cut -d " " -f 4)Mb \n" 

    print_line $line_length
    printf "\n"
}

get_filesystems_info () {
    local line_length=$(( $(df -hT | head -n 1 | wc -c) - 1 )) 

    printf "Filesystems information\n"
    print_line $line_length
    
    df -hT | head -n 1
    df -hT | sort | grep -iv 'filesystem'

    print_line $line_length
    printf "\n"
}

get_usb_info () {
    local line_length=$(( $(lsusb -t | head -n 1 | wc -c) - 1 )) 

    printf "USB information\n"
    print_line $line_length
    
    lsusb -t

    print_line $line_length
    printf "\n"
}

get_network_interfaces_info () {
    local line_length=$(( $(ip a | head -n 1 | wc -c) - 1 )) 

    printf "Network interfaces information\n"
    print_line $line_length
    
    ip a

    print_line $line_length
    printf "\n"
}

get_cpu_info
get_memory_info
get_filesystems_info
get_usb_info
get_network_interfaces_infoexit 0

exit 0