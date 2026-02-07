#!/bin/bash

DIRA="dirA"
DIRB="dirB"

# Check if both directories exist
if [ ! -d "$DIRA" ] || [ ! -d "$DIRB" ]; then
    echo "Error: One or both directories do not exist."
    exit 1
fi

echo "Files only in $DIRA:"
echo "-------------------"
ls "$DIRA" | while read file
do
    if [ ! -e "$DIRB/$file" ]; then
        echo "$file"
    fi
done

echo
echo "Files only in $DIRB:"
echo "-------------------"
ls "$DIRB" | while read file
do
    if [ ! -e "$DIRA/$file" ]; then
        echo "$file"
    fi
done

echo
echo "Files present in both directories but with different content:"
echo "-------------------------------------------------------------"

ls "$DIRA" | while read file
do
    if [ -f "$DIRA/$file" ] && [ -f "$DIRB/$file" ]; then
        cmp -s "$DIRA/$file" "$DIRB/$file"
        if [ "$?" -ne 0 ]; then
            echo "$file"
        fi
    fi
done
