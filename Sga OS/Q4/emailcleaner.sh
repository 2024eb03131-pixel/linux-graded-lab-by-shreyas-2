#!/bin/bash

INPUT="emails.txt"

# Check if input file exists
if [ ! -f "$INPUT" ]; then
    echo "Error: emails.txt file not found."
    exit 1
fi

# Extract valid email addresses
grep -E '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$' "$INPUT" > valid_temp.txt

# Remove duplicates from valid emails
sort valid_temp.txt | uniq > valid.txt

# Extract invalid email addresses
grep -Ev '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$' "$INPUT" > invalid.txt

# Cleanup temporary file
rm valid_temp.txt

echo "Email processing completed."
echo "Valid emails saved in valid.txt"
echo "Invalid emails saved in invalid.txt"

