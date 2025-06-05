#!/bin/bash

files=($(ls))

for file in ${files[@]}
do
    printf "$file\n"
done

exit 0