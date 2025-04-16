#!/bin/bash
# Psinder Database Test Runner
# 
# This script executes all SQL tests in the tests directory against 
# the PostgreSQL database specified in credentials.txt.
#
# Usage: ./run_tests.sh

# Load database credentials
if [ -f "../credentials.txt" ]; then
    source "../credentials.txt"
else
    echo "Error: credentials.txt not found. Please create it with your database credentials."
    exit 1
fi

# Check if PGHOST, PGUSER, PGDATABASE are set
if [ -z "$PGHOST" ] || [ -z "$PGUSER" ] || [ -z "$PGDATABASE" ]; then
    echo "Error: Database credentials not properly set in credentials.txt."
    echo "Please ensure PGHOST, PGUSER, PGDATABASE, and PGPASSWORD are defined."
    exit 1
fi

# Create a temporary file for test results
RESULTS_FILE=$(mktemp)
echo "Psinder Database Test Results" > $RESULTS_FILE
echo "============================" >> $RESULTS_FILE
echo "Date: $(date)" >> $RESULTS_FILE
echo "Database: $PGDATABASE@$PGHOST" >> $RESULTS_FILE
echo "============================" >> $RESULTS_FILE
echo "" >> $RESULTS_FILE

# Execute each test file
for test_file in *.sql; do
    if [ -f "$test_file" ]; then
        echo "Running test: $test_file" | tee -a $RESULTS_FILE
        echo "----------------------------------" >> $RESULTS_FILE
        
        # Execute the SQL file and capture the output
        PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U $PGUSER -d $PGDATABASE -f "$test_file" >> $RESULTS_FILE 2>&1
        
        # Add a separator between test results
        echo "" >> $RESULTS_FILE
        echo "" >> $RESULTS_FILE
    fi
done

# Print results location
echo "Test execution completed. Results saved to: $RESULTS_FILE"
echo "To view results: cat $RESULTS_FILE"

# Make the script executable
chmod +x run_tests.sh 