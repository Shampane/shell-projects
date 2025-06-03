#!/bin/bash

read -p "Input seconds: " seconds

while [[ $seconds > 0 ]]
do
    printf "Current seconds: $seconds\n"
    sleep 1
    ((seconds--))
done

printf "Time's up!\n"
exit 0