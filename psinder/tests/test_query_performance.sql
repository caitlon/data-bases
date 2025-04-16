-- Test: Query Performance
-- This file contains tests to verify that key queries perform efficiently
-- and use indexes as expected.

-- 1. Test profile search query performance
EXPLAIN ANALYZE
SELECT p.profile_id, p.pet_name, g.gender_name, b.breed_name, c.city_name
FROM pet_profile p
JOIN gender g ON p.gender_id = g.gender_id
JOIN breed b ON p.breed_id = b.breed_id
JOIN city c ON p.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
WHERE co.country_name = 'Czechia'
  AND p.gender_id = 1
  AND p.is_active = TRUE
ORDER BY p.created_datetime DESC
LIMIT 20;

-- 2. Test match finding performance
EXPLAIN ANALYZE
SELECT m.profile_id_1, m.profile_id_2, m.created_datetime
FROM pet_match m
JOIN pet_profile p1 ON m.profile_id_1 = p1.profile_id
JOIN pet_profile p2 ON m.profile_id_2 = p2.profile_id
WHERE p1.user_id = 101
   OR p2.user_id = 101
ORDER BY m.created_datetime DESC
LIMIT 10;

-- 3. Test message fetch performance
EXPLAIN ANALYZE
SELECT m.message_id, m.content, m.sent_datetime, p.pet_name
FROM message m
JOIN conversation_member cm ON m.conversation_id = cm.conversation_id
JOIN pet_profile p ON m.profile_id = p.profile_id
WHERE m.conversation_id = 42
ORDER BY m.sent_datetime ASC;

-- 4. Test pet recommendation algorithm performance
EXPLAIN ANALYZE
SELECT 
    p.profile_id,
    p.pet_name,
    b.breed_name,
    c.city_name,
    co.country_name,
    EXTRACT(YEAR FROM AGE(p.date_of_birth)) AS age,
    (
        SELECT COUNT(*) 
        FROM photo_data pd 
        WHERE pd.profile_id = p.profile_id
          AND pd.is_active = TRUE
    ) AS photo_count,
    (
        SELECT COUNT(*) 
        FROM pet_like pl 
        WHERE pl.profile_target_id = p.profile_id
    ) AS received_likes_count
FROM pet_profile p
JOIN breed b ON p.breed_id = b.breed_id
JOIN city c ON p.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
JOIN gender g ON p.gender_id = g.gender_id
JOIN pet_preference pp ON TRUE
WHERE p.is_active = TRUE
    AND p.profile_id <> pp.profile_id
    AND p.gender_id = pp.preferred_gender_id
    AND EXTRACT(YEAR FROM AGE(p.date_of_birth)) BETWEEN COALESCE(pp.min_age, 0) AND COALESCE(pp.max_age, 100)
    AND NOT EXISTS (
        SELECT 1 FROM pet_like pl 
        WHERE pl.profile_initiator_id = pp.profile_id 
          AND pl.profile_target_id = p.profile_id
    )
    AND pp.profile_id = 101  -- Test with specific profile_id
ORDER BY received_likes_count DESC, p.created_datetime DESC
LIMIT 10;

-- 5. Check that execution plans use indexes for core operations
SELECT 
    (CASE 
        WHEN query_plan LIKE '%Index Scan%' THEN 'PASSED: Profile search uses index'
        ELSE 'FAILED: Profile search not using index' 
     END) AS profile_search_index_check
FROM pg_catalog.pg_stat_statements
WHERE query ILIKE '%FROM pet_profile p JOIN gender%'
LIMIT 1;

-- Output a summary
SELECT 'Performance Tests Completed' AS test_summary; 