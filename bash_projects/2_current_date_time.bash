#!/bin/bash

SECONDS=$(date +%S)
MINUTE=$(date +%M)
HOUR=$(date +%H)

DAY=$(date +%d)
MONTH=$(date +%m)
YEAR=$(date +%Y)

echo "Time: $HOUR:$MINUTE:$SECONDS"
echo "Date: $DAY/$MONTH/$YEAR"