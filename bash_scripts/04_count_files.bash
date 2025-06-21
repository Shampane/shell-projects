#!/bin/bash

dir=$(pwd)
count=$(ls -1 | wc -l)

printf "Count of files in $dir: $count\n"

exit 0
