#!/usr/bin/bash

print_rules() {
    nft list ruleset | sed 's/\t/    /g'
}

print_table() {
    read -rp "Input rule family: " family
    read -rp "Input table name: " table_name

    nft list table "$family" "$table_name" | sed 's/\t/    /g'
}

is_table_exists() {
    local family=$1
    local table_name=$2

    if nft list tables | grep -qw "$family $table_name"
    then
        return 0
    else
        return 1
    fi
}

is_chain_exists() {
    local family=$1
    local table_name=$2
    local chain_name=$2

    if nft list table "$family" "$table_name" | grep -qw "chain $chain_name"
    then
        return 0
    else
        return 1
    fi
}

create_table() {
    read -rp "Input rule family: " family
    read -rp "Input table name: " table_name

    if is_table_exists "$family" "$table_name"
    then
        printf "%s\n" "Table already exists"
    else
        nft add table "$family" "$table_name"
        printf "%s\n" "Table was created"
    fi
}

create_chain() {
    local chain_type=""
    local chain_hook=""
    local chain_priority=""
    local chain_policy=""

    read -rp "Input rule family: " family
    read -rp "Input table name: " table_name
    read -rp "Input chain name: " chain_name

    if is_table_exists "$family" "$table_name"
    then
        if is_chain_exists "$family" "$table_name"
        then
            printf "%s\n" "Chain already exists"
        else
            set_chain_type chain_type
            set_chain_hook chain_hook
            set_chain_priority chain_priority
            set_chain_policy chain_policy

            nft add chain "$family" "$table_name" "$chain_name" \
             \{ type "$chain_type" hook "$chain_hook" priority "$chain_priority" \; policy "$chain_policy" \; \}
        fi
    else
        printf "%s\n" "Table doesn't exist"
    fi
}

set_chain_type() {
    declare -n type=$1
    printf "%s\n" "Available chain types"
    printf "%s\n" "1. filter (f)"
    printf "%s\n" "2. nat (n)"
    printf "%s\n" "3. route (ro)"
    printf "%s\n" "4. raw (ra)"
    printf "%s\n\n" "5. mangle (m)"

    while true
    do
        read -rp "Choose type: " _type
        case "$_type" in
            "f")
                type="filter"
                break
                ;;
            "n")
                type="nat"
                break
                ;;
            "ro")
                type="route"
                break
                ;;
            "ra")
                type="raw"
                break
                ;;
            "m")
                type="mangle"
                break
                ;;
            *)
                printf "%s\n" "Wrong value, try again"
                ;;
        esac
    done
}

set_chain_hook() {
    declare -n hook=$1
    printf "%s\n" "Available chain hooks"
    printf "%s\n" "1. prerouting (pr)"
    printf "%s\n" "2. input (i)"
    printf "%s\n" "3. forward (f)"
    printf "%s\n" "4. output (o)"
    printf "%s\n\n" "5. postrouting (po)"

    while true
    do
        read -rp "Choose hook: " _hook
        case "$_hook" in
            "pr")
                hook="prerouting"
                break
                ;;
            "i")
                hook="input"
                break
                ;;
            "f")
                hook="forward"
                break
                ;;
            "o")
                hook="output"
                break
                ;;
            "po")
                hook="postrouting"
                break
                ;;
            *)
                printf "%s\n" "Wrong value, try again"
                ;;
        esac
    done
}

set_chain_priority() {
    declare -n priority=$1

    while true
    do
        read -rp "Choose priority between -300 and 100 (0 by default): " _priority
        if [[ -z "$_priority" ]]
        then
            priority=0
            break
        elif [[ ! "$_priority" =~ ^-?[0-9]+$ || "$_priority" -lt -300 || "$_priority" -gt 100 ]]
        then
            printf "%s\n" "Wrong value, try again"
        else
            priority=$_priority
            break
        fi
    done
}

set_chain_policy() {
    declare -n policy=$1
    printf "%s\n" "Available chain policies"
    printf "%s\n" "1. accept (a)"
    printf "%s\n" "2. drop (d)"
    printf "%s\n\n" "3. continue (c)"

    while true
    do
        read -rp "Choose policy: " _policy
        case "$_policy" in
            "a")
                policy="accept"
                break
                ;;
            "d")
                policy="drop"
                break
                ;;
            "c")
                policy="continue"
                break
                ;;
            *)
                printf "%s\n" "Wrong value, try again"
                ;;
        esac
    done
}

create_table