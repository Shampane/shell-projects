#!/bin/bash

read -p "Write name of the file: " filename
if [ ! -f $filename ]
then
    printf "File doesn't exist\n"
else
    printf "File exists\n"
    ls -l $filename
fi