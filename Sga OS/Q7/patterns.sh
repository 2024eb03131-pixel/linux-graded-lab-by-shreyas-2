#!/bin/bash

FILE="input.txt"

# Check if input file exists
if [ ! -f "$FILE" ]; then
    echo "Error: input.txt file not found."
    exit 1
fi

# Clear output files
> vowels.txt
> consonants.txt
> mixed.txt

# Convert text to lowercase and one word per line
tr -cs 'A-Za-z' '\n' < "$FILE" | tr 'A-Z' 'a-z' | while read word
do
    # Only vowels
    if echo "$word" | grep -Eq '^[aeiou]+$'; then
        echo "$word" >> vowels.txt

    # Only consonants
    elif echo "$word" | grep -Eq '^[bcdfghjklmnpqrstvwxyz]+$'; then
        echo "$word" >> consonants.txt

    # Mixed but starting with a consonant
    elif echo "$word" | grep -Eq '^[bcdfghjklmnpqrstvwxyz][a-z]*$' &&
         echo "$word" | grep -Eq '[aeiou]' &&
         echo "$word" | grep -Eq '[bcdfghjklmnpqrstvwxyz]'; then
        echo "$word" >> mixed.txt
    fi
done

echo "Pattern classification completed."
