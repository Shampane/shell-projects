#!/bin/bash

dir=$(pwd)
count=$(ls -1 | wc -l)

echo "Count of files in $dir: $count"