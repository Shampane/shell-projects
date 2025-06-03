#!/bin/bash

seconds=$(date +%S)
minute=$(date +%M)
hour=$(date +%H)

day=$(date +%d)
month=$(date +%m)
year=$(date +%Y)

echo "Time: $hour:$minute:$seconds\n"
echo "Date: $day/$month/$year\n"

exit 0
