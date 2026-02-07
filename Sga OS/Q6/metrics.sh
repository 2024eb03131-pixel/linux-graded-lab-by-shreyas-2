#!/bin/bash

FILE="input.txt"

# Check if input file exists
if [ ! -f "$FILE" ]; then
    echo "Error: input.txt file not found."
    exit 1
fi

# Convert text to one word per line (remove punctuation)
WORDS=$(tr -cs 'A-Za-z' '\n' < "$FILE")

# Longest word
LONGEST=$(echo "$WORDS" | awk '{ print length, $0 }' | sort -nr | head -n 1 | awk '{ print $2 }')

# Shortest word
SHORTEST=$(echo "$WORDS" | awk '{ print length, $0 }' | sort -n | head -n 1 | awk '{ print $2 }')

# Total number of words
TOTAL_WORDS=$(echo "$WORDS" | wc -l)

# Total characters in all words
TOTAL_CHARS=$(echo "$WORDS" | awk '{ sum += length } END { print sum }')

# Average word length
AVG_LENGTH=$(echo "scale=2; $TOTAL_CHARS / $TOTAL_WORDS" | bc)

# Total unique words
UNIQUE_WORDS=$(echo "$WORDS" | sort | uniq | wc -l)

# Display results
echo "Longest word: $LONGEST"
echo "Shortest word: $SHORTEST"
echo "Average word length: $AVG_LENGTH"
echo "Total unique words: $UNIQUE_WORDS"
