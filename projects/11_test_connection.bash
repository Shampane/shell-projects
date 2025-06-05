#!/bin/bash

host=$1
port=$2

get_traceroute () {
    local ipv4=$1
    printf "Traceroute\n"
    length=$(( $(traceroute localhost | grep "^ 1" | wc -c) + 20 ))
    printf "%*s\n" $length "-" | tr " " "-"
    traceroute $ipv4 | grep "^ [0-9]"
    printf "%*s\n" $length "-" | tr " " "-"
}

if nc -z $host $port
then
    ipv4=$(host "$host" | grep -i "has address" | awk '{print $NF}')
    ipv6=$(host "$host" | grep -i "ipv6" | awk '{print $NF}')
    mail=$(host "$host" | grep -i "mail" | awk '{print $NF}')

    printf "Server on the port is open\n\n"

    printf "Domain name: $host\n"
    printf "Port: $port\n"
    printf "IPv4 address: $ipv4\n"
    printf "IPv6 address: $ipv6\n"
    printf "Mail address: $mail\n\n"

    get_traceroute $ipv4
else
    printf "Server on the port is closed\n"
fi

exit 0