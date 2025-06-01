#!/bin/bash

read -p "Write two numbers separated by space: " a b

trigger_error=0

test_error() {
    local trigger="$1"
    if ((trigger))
    then
        exit 1
    fi
}

is_number() {
    local value="$1"
    [[ "$value" =~ ^[+-]?([0-9]+(\.[0-9]*)?|\.[0-9]+)$ ]]
}

if ! is_number "$a"
then
    echo "Error: variable a is not number"
    trigger_error=1
fi

if ! is_number "$b"
then
    echo "Error: variable b is not number"
    trigger_error=1
fi

test_error "$trigger_error"

cat << _EOF_

Allowed action for the numbers:
1. Summarization
2. Subtraction
3. Multiply
4. Division

_EOF_

read -p "Choose action: " action

case $action in
    "1")
        echo "Summarization: $a + $b = $(($a+$b))"
        ;;
    "2")
        echo "Subtraction: $a - $b = $(($a-$b))"
        ;;
    "3")
        echo "Multiply: $a * $b = $(($a*$b))"
        ;;
    "4")
        echo "Division: $a / $b = $(($a/$b))"
        ;;
    *)
        echo "Error: action number is not valid"
        exit 1
        ;;
esac

exit 0