-- Test: Schema Integrity
-- This test checks that all expected tables exist in the database
-- and that required constraints are properly defined.

-- 1. Check if all required tables exist
SELECT 
    CASE 
        WHEN COUNT(*) = 20 THEN 'PASSED: All tables exist'
        ELSE 'FAILED: Missing tables. Expected 20, found ' || COUNT(*)::TEXT
    END AS test_all_tables_exist 
FROM (
    SELECT 1 FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_name IN (
        'animal_type', 'breed', 'city', 'city_preference', 'conversation',
        'conversation_member', 'country', 'country_preference', 'gender',
        'language', 'message', 'pet_like', 'pet_match', 'pet_preference',
        'pet_profile', 'phone_code', 'photo_data', 'user_account',
        'user_block', 'user_language'
    )
) t;

-- 2. Check that primary key constraints exist for core tables
SELECT 
    CASE 
        WHEN COUNT(*) = 5 THEN 'PASSED: All primary key constraints exist'
        ELSE 'FAILED: Missing primary key constraints. Expected 5, found ' || COUNT(*)::TEXT
    END AS test_primary_keys
FROM information_schema.table_constraints
WHERE constraint_type = 'PRIMARY KEY' 
AND table_name IN (
    'pet_profile', 'user_account', 'breed', 'animal_type', 'country'
);

-- 3. Check that required columns are set to NOT NULL
SELECT 
    CASE 
        WHEN COUNT(*) = 6 THEN 'PASSED: All required columns have NOT NULL constraint'
        ELSE 'FAILED: Missing NOT NULL constraints. Expected 6, found ' || COUNT(*)::TEXT
    END AS test_not_null_constraints
FROM information_schema.columns
WHERE table_name = 'pet_profile' 
AND column_name IN (
    'profile_id', 'user_id', 'gender_id', 'type_id', 'breed_id', 'date_of_birth'
) 
AND is_nullable = 'NO';

-- 4. Check indexes for performance critical tables
SELECT 
    CASE 
        WHEN COUNT(*) >= 2 THEN 'PASSED: Required indexes exist for pet_like table'
        ELSE 'FAILED: Missing indexes on pet_like table. Expected at least 2, found ' || COUNT(*)::TEXT
    END AS test_pet_like_indexes
FROM pg_indexes
WHERE tablename = 'pet_like';

-- 5. Check foreign key constraints in the breed table
SELECT 
    CASE 
        WHEN COUNT(*) >= 1 THEN 'PASSED: Foreign key constraint exists in breed table'
        ELSE 'FAILED: Missing foreign key constraint in breed table'
    END AS test_breed_foreign_key
FROM information_schema.table_constraints tc
JOIN information_schema.constraint_column_usage ccu 
    ON tc.constraint_name = ccu.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY' 
AND tc.table_name = 'breed'
AND ccu.table_name = 'animal_type';

-- Summarize all test results
SELECT 'Schema Integrity Tests Completed' AS test_summary; 