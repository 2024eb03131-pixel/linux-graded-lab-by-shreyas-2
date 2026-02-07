i#!/bin/bash

# Check if marks file exists
FILE="marks.txt"

if [ ! -f "$FILE" ]; then
    echo "Error: marks.txt file not found."
    exit 1
fi

pass_all=0
fail_one=0

echo "Students who failed in exactly ONE subject:"
echo "------------------------------------------"

while IFS=',' read -r roll name m1 m2 m3
do
    # Count failed subjects
    fail_count=0

    if [ "$m1" -lt 33 ]; then
        fail_count=$((fail_count + 1))
    fi
    if [ "$m2" -lt 33 ]; then
        fail_count=$((fail_count + 1))
    fi
    if [ "$m3" -lt 33 ]; then
        fail_count=$((fail_count + 1))
    fi

    if [ "$fail_count" -eq 1 ]; then
        echo "$roll, $name"
        fail_one=$((fail_one + 1))
    fi

    if [ "$fail_count" -eq 0 ]; then
        pass_all=$((pass_all + 1))
    fi

done < "$FILE"

echo
echo "Students who passed in ALL subjects:"
echo "-----------------------------------"

while IFS=',' read -r roll name m1 m2 m3
do
    if [ "$m1" -ge 33 ] && [ "$m2" -ge 33 ] && [ "$m3" -ge 33 ]; then
        echo "$roll, $name"
    fi
done < "$FILE"

echo
echo "Summary:"
echo "--------"
echo "Students passed in all subjects: $pass_all"
echo "Students failed in exactly one subject: $fail_one"

