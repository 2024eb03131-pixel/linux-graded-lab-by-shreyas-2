#!/bin/bash

# Check if exactly one argument is passed
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one log file name."
    exit 1
fi

LOGFILE="$1"

# Check if file exists and is readable
if [ ! -f "$LOGFILE" ]; then
    echo "Error: File does not exist."
    exit 1
fi

if [ ! -r "$LOGFILE" ]; then
    echo "Error: File is not readable."
    exit 1
fi

# Count total entries
TOTAL=$(wc -l < "$LOGFILE")

# Count log levels
INFO_COUNT=$(grep -c " INFO " "$LOGFILE")
WARNING_COUNT=$(grep -c " WARNING " "$LOGFILE")
ERROR_COUNT=$(grep -c " ERROR " "$LOGFILE")

# Get most recent ERROR
RECENT_ERROR=$(grep " ERROR " "$LOGFILE" | tail -n 1)

# Date for report file
DATE=$(date +%Y-%m-%d)
REPORT="logsummary_${DATE}.txt"

# Display results
echo "Total log entries: $TOTAL"
echo "INFO messages: $INFO_COUNT"
echo "WARNING messages: $WARNING_COUNT"
echo "ERROR messages: $ERROR_COUNT"
echo "Most recent ERROR:"
echo "$RECENT_ERROR"

# Generate report file
{
    echo "Log Summary Report - $DATE"
    echo "----------------------------"
    echo "Total log entries: $TOTAL"
    echo "INFO messages: $INFO_COUNT"
    echo "WARNING messages: $WARNING_COUNT"
    echo "ERROR messages: $ERROR_COUNT"
    echo "Most recent ERROR:"
    echo "$RECENT_ERROR"
} > "$REPORT"

echo "Report generated: $REPORT"

