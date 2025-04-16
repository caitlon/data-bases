# Psinder Database Tests

This directory contains SQL tests to verify the integrity, functionality, and performance of the Psinder database.

## Test Categories

### 1. Schema Integrity Tests (`test_schema_integrity.sql`)

Verifies that the database schema matches the expected structure:
- All required tables exist
- Primary key constraints are in place
- Required columns have NOT NULL constraints
- Expected indexes exist for performance-critical tables
- Foreign key relationships are properly defined

### 2. Trigger Tests (`test_match_trigger.sql`)

Tests the functionality of database triggers:
- Tests that the pet_match_trigger creates matches when two profiles like each other
- Verifies that the create_conversation_trigger creates conversations for new matches
- Confirms that match creation only occurs with mutual likes

### 3. Performance Tests (`test_query_performance.sql`)

Measures and verifies the performance of critical database queries:
- Profile search performance
- Match finding performance
- Message fetching performance
- Pet recommendation algorithm performance
- Verifies that indexes are used in execution plans

## Running Tests

To run all tests, execute the `run_tests.sh` script:

```bash
cd tests
chmod +x run_tests.sh
./run_tests.sh
```

The script will run all SQL test files and save the results to a temporary file.

## Prerequisites

Before running tests, ensure you have:
1. A PostgreSQL database with the Psinder schema loaded
2. Valid database credentials in `../credentials.txt`
3. Required test dependencies:
   - PostgreSQL client tools (`psql`)
   - Bash shell

## Test Development Guidelines for Contribution

When adding new tests:
1. Create a new SQL file with descriptive name (e.g., `test_feature_name.sql`)
2. Include clear comments explaining the test purpose
3. Use transaction blocks (`BEGIN`/`ROLLBACK`) for tests that modify data
4. Include clear PASS/FAIL indicators in the output
5. Add your test description to this README.md file 