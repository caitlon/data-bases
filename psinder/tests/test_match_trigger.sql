-- Test: Match Trigger Functionality
-- This test verifies that the pet_match_trigger correctly creates matches
-- and that the create_conversation_trigger creates conversations for matches.

-- Start a transaction to safely roll back test data
BEGIN;

-- Create test users
INSERT INTO user_account (
    user_id, code_id, gender_id, nickname, email, 
    phone_number, firstname, lastname, password_hash, salt, 
    created_datetime, is_active
) VALUES 
(9001, 1, 1, 'test_user1', 'test1@example.com', 
 '1234567890', 'Test', 'User1', 'hash1', 'salt1', 
 NOW(), TRUE),
(9002, 1, 2, 'test_user2', 'test2@example.com', 
 '0987654321', 'Test', 'User2', 'hash2', 'salt2', 
 NOW(), TRUE);

-- Declare variables for profile IDs
DO $$
DECLARE
    test_profile_id_1 INT;
    test_profile_id_2 INT;
    match_count INT;
    conversation_count INT;
BEGIN
    -- Create test pet profiles
    INSERT INTO pet_profile (
        user_id, gender_id, type_id, breed_id, city_id,
        pet_name, date_of_birth, price, purebred_percentage,
        description, created_datetime, is_active
    ) VALUES (
        9001, 1, 1, 1, 1,
        'TestPet1', '2020-01-01', 100, 95,
        'Test pet profile 1', NOW(), TRUE
    ) RETURNING profile_id INTO test_profile_id_1;
    
    INSERT INTO pet_profile (
        user_id, gender_id, type_id, breed_id, city_id,
        pet_name, date_of_birth, price, purebred_percentage,
        description, created_datetime, is_active
    ) VALUES (
        9002, 2, 1, 1, 1,
        'TestPet2', '2020-02-02', 200, 90,
        'Test pet profile 2', NOW(), TRUE
    ) RETURNING profile_id INTO test_profile_id_2;

    -- Test 1: First like - should not create a match yet
    INSERT INTO pet_like (profile_initiator_id, profile_target_id, created_datetime)
    VALUES (test_profile_id_1, test_profile_id_2, NOW());
    
    -- Verify no match exists yet
    SELECT COUNT(*) INTO match_count FROM pet_match
    WHERE (profile_id_1 = test_profile_id_1 AND profile_id_2 = test_profile_id_2)
       OR (profile_id_1 = test_profile_id_2 AND profile_id_2 = test_profile_id_1);
    
    IF match_count = 0 THEN
        RAISE NOTICE 'PASSED: No match created after first like';
    ELSE
        RAISE NOTICE 'FAILED: Match incorrectly created after only one like';
    END IF;
    
    -- Test 2: Second like in the opposite direction - should create a match
    INSERT INTO pet_like (profile_initiator_id, profile_target_id, created_datetime)
    VALUES (test_profile_id_2, test_profile_id_1, NOW());
    
    -- Verify match was created
    SELECT COUNT(*) INTO match_count FROM pet_match
    WHERE (profile_id_1 = test_profile_id_1 AND profile_id_2 = test_profile_id_2)
       OR (profile_id_1 = test_profile_id_2 AND profile_id_2 = test_profile_id_1);
    
    IF match_count = 1 THEN
        RAISE NOTICE 'PASSED: Match correctly created after mutual likes';
    ELSE
        RAISE NOTICE 'FAILED: Match not created after mutual likes';
    END IF;
    
    -- Test 3: Verify conversation was created for the match
    SELECT COUNT(*) INTO conversation_count 
    FROM conversation_member cm1
    JOIN conversation_member cm2 ON cm1.conversation_id = cm2.conversation_id
    WHERE cm1.profile_id = test_profile_id_1
      AND cm2.profile_id = test_profile_id_2;
    
    IF conversation_count = 1 THEN
        RAISE NOTICE 'PASSED: Conversation correctly created for match';
    ELSE
        RAISE NOTICE 'FAILED: Conversation not created for match';
    END IF;
    
    -- Output final test results
    RAISE NOTICE 'Trigger Tests Completed';
END $$;

-- Rollback the transaction to clean up test data
ROLLBACK; 