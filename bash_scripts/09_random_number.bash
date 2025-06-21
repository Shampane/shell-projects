#!/bin/bash

read -p "Input two numbers: " a b
if [[ a > b ]];
then
    printf "Random: $(( $RANDOM % $a + $b ))\n"
else
    printf "Random: $(( $RANDOM % $b + $a ))\n"
fi

exit 0