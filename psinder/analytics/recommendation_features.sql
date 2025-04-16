/*
 * Feature Engineering Query for Pet Recommendation System
 *
 * This query extracts features that can be used to train a machine learning model
 * for recommending potential pet matches. It captures both:
 * 1. Profile-level features (attributes of each pet profile)
 * 2. Interaction features (patterns of likes and matches)
 *
 * The resulting dataset can be used for:
 * - Training a recommendation system
 * - Building similarity matrices
 * - Analyzing like/match patterns
 */

-- Get all active pet profiles with their detailed features
WITH pet_profiles AS (
    SELECT
        p.profile_id,
        -- Basic profile information
        p.pet_name,
        g.gender_name AS gender,
        at.type_name AS animal_type,
        b.breed_name AS breed,
        EXTRACT(YEAR FROM AGE(p.date_of_birth)) AS age,
        p.price,
        p.purebred_percentage,
        CASE WHEN p.certification_url IS NOT NULL THEN 1 ELSE 0 END AS is_certified,
        
        -- Location features
        c.country_name AS country,
        ci.city_name AS city,
        
        -- Profile engagement features
        (SELECT COUNT(*) FROM photo_data pd WHERE pd.profile_id = p.profile_id AND pd.is_active = TRUE) AS photo_count,
        LENGTH(p.description) AS description_length,
        
        -- User features
        ua.user_id,
        (SELECT COUNT(*) FROM user_language ul WHERE ul.user_id = ua.user_id) AS languages_count,
        (SELECT COUNT(*) FROM pet_profile pp WHERE pp.user_id = ua.user_id) AS user_pets_count
        
    FROM pet_profile p
    JOIN gender g ON p.gender_id = g.gender_id
    JOIN animal_type at ON p.type_id = at.type_id
    JOIN breed b ON p.breed_id = b.breed_id
    JOIN city ci ON p.city_id = ci.city_id
    JOIN country c ON ci.country_id = c.country_id
    JOIN user_account ua ON p.user_id = ua.user_id
    WHERE p.is_active = TRUE
),

-- Get like interaction statistics
like_stats AS (
    SELECT
        profile_id,
        COUNT(DISTINCT profile_initiator_id) AS received_likes_count,
        COUNT(DISTINCT profile_target_id) AS sent_likes_count
    FROM (
        -- Likes received
        SELECT profile_target_id AS profile_id, profile_initiator_id, NULL::INTEGER AS profile_target_id 
        FROM pet_like
        
        UNION ALL
        
        -- Likes sent
        SELECT profile_initiator_id AS profile_id, NULL::INTEGER AS profile_initiator_id, profile_target_id 
        FROM pet_like
    ) AS all_likes
    GROUP BY profile_id
),

-- Get match statistics
match_stats AS (
    SELECT
        profile_id,
        COUNT(*) AS match_count,
        AVG(EXTRACT(DAY FROM (m.created_datetime - pl.created_datetime))) AS avg_days_to_match
    FROM (
        -- All profiles involved in matches
        SELECT profile_id_1 AS profile_id, created_datetime FROM pet_match
        UNION ALL
        SELECT profile_id_2 AS profile_id, created_datetime FROM pet_match
    ) AS m
    JOIN pet_like pl ON 
        (pl.profile_initiator_id = m.profile_id) OR 
        (pl.profile_target_id = m.profile_id)
    GROUP BY profile_id
),

-- Get messaging engagement
message_stats AS (
    SELECT
        cm.profile_id,
        COUNT(DISTINCT cm.conversation_id) AS conversation_count,
        COUNT(m.message_id) AS messages_sent,
        AVG(LENGTH(m.content)) AS avg_message_length
    FROM conversation_member cm
    LEFT JOIN message m ON cm.conversation_id = m.conversation_id AND cm.profile_id = m.profile_id
    GROUP BY cm.profile_id
)

-- Combine all features for machine learning
SELECT
    pp.*,
    
    -- Interaction features
    COALESCE(ls.received_likes_count, 0) AS received_likes,
    COALESCE(ls.sent_likes_count, 0) AS sent_likes,
    
    -- Calculate like ratio (popularity indicator)
    CASE 
        WHEN COALESCE(ls.sent_likes_count, 0) > 0 
        THEN ROUND(COALESCE(ls.received_likes_count, 0)::NUMERIC / COALESCE(ls.sent_likes_count, 1), 2)
        ELSE NULL 
    END AS like_ratio,
    
    -- Match features
    COALESCE(ms.match_count, 0) AS matches,
    COALESCE(ms.avg_days_to_match, 0) AS avg_days_to_match,
    
    -- Match success rate
    CASE 
        WHEN COALESCE(ls.sent_likes_count, 0) > 0 
        THEN ROUND(COALESCE(ms.match_count, 0)::NUMERIC / COALESCE(ls.sent_likes_count, 1), 2)
        ELSE NULL 
    END AS match_success_rate,
    
    -- Messaging engagement
    COALESCE(msg.conversation_count, 0) AS conversations,
    COALESCE(msg.messages_sent, 0) AS messages_sent,
    COALESCE(msg.avg_message_length, 0) AS avg_message_length,
    
    -- Engagement score (simplified)
    (
        COALESCE(pp.photo_count, 0) * 0.2 + 
        COALESCE(ls.received_likes_count, 0) * 0.3 + 
        COALESCE(ms.match_count, 0) * 0.3 + 
        COALESCE(msg.messages_sent, 0) * 0.2
    ) AS engagement_score
    
FROM pet_profiles pp
LEFT JOIN like_stats ls ON pp.profile_id = ls.profile_id
LEFT JOIN match_stats ms ON pp.profile_id = ms.profile_id
LEFT JOIN message_stats msg ON pp.profile_id = msg.profile_id
ORDER BY pp.profile_id; 