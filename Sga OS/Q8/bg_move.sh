#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one directory path."
    exit 1
fi

DIR="$1"

# Check if directory exists
if [ ! -d "$DIR" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

BACKUP="$DIR/backup"

# Create backup directory if it does not exist
mkdir -p "$BACKUP"

echo "Parent script PID: $$"
echo

# Move each file in background
for file in "$DIR"/*
do
    if [ -f "$file" ]; then
        mv "$file" "$BACKUP/" &
        echo "Started background move for $(basename "$file") with PID $!"
    fi
done

# Wait for all background processes to finish
wait

echo
echo "All background file move operations completed."
