/*
 * Psinder Analytics ETL Query
 * 
 * This query extracts, transforms, and loads data from the Psinder database
 * into a format suitable for analytics. It provides comprehensive metrics
 * about pet profiles, their interactions, and match patterns.
 *
 * Use cases:
 * - Analyzing user behavior and engagement
 * - Understanding matching patterns between different types of profiles
 * - Identifying popular breeds and locations
 * - Measuring conversion rates from likes to matches
 */

WITH
-- Count of active photos for each profile
-- This helps analyze the correlation between photo count and match success
photo_counts AS (
    SELECT profile_id, COUNT(*) AS active_photos
    FROM photo_data
    WHERE is_active = TRUE
    GROUP BY profile_id
),

-- Count of likes sent by each profile
-- Helps measure user engagement and outbound activity
sent_likes AS (
    SELECT profile_initiator_id, COUNT(*) AS sent_like_count
    FROM pet_like
    GROUP BY profile_initiator_id
),

-- Count of likes received by each profile
-- Indicates profile popularity and attractiveness
received_likes AS (
    SELECT profile_target_id, COUNT(*) AS received_like_count
    FROM pet_like
    GROUP BY profile_target_id
),

-- Count of mutual matches for each profile
-- Key metric for measuring success in the platform
matches AS (
    SELECT profile_id_1, COUNT(*) AS match_count
    FROM pet_match
    GROUP BY profile_id_1
),

-- Liked profile details (avoiding redundant joins)
-- Contains data about each like interaction and whether it resulted in a match
liked_profiles AS (
    SELECT
        pl.profile_initiator_id,
        pl.profile_target_id,
        pl.created_datetime AS like_created_at,
        pm.created_datetime AS match_created_at,
        CASE WHEN pm.profile_id_1 IS NOT NULL THEN 1 ELSE 0 END AS is_matched,
        EXTRACT(DAY FROM (pm.created_datetime - pl.created_datetime)) AS days_until_match
    FROM pet_like pl
    LEFT JOIN pet_match pm
        ON (pm.profile_id_1 = pl.profile_initiator_id AND pm.profile_id_2 = pl.profile_target_id)
        OR (pm.profile_id_2 = pl.profile_initiator_id AND pm.profile_id_1 = pl.profile_target_id)
)

-- Main query combining all the data for comprehensive analytics
SELECT
    -- Animal profile details
    p.profile_id AS animal_profile_id,
    c.country_name AS country,
    g.gender_name AS pet_gender,
    a.type_name AS animal_type,
    b.breed_name AS breed,
    ci.city_name AS city,
    COALESCE(EXTRACT(YEAR FROM AGE(p.date_of_birth)), 0) AS pet_age,
    p.price,
    COALESCE(p.purebred_percentage, 0) AS purebred_percentage,
    CASE WHEN p.certification_url IS NOT NULL THEN 1 ELSE 0 END AS has_certification,

    -- Profile metadata
    p.created_datetime AS profile_created_at,
    COALESCE(pc.active_photos, 0) AS num_active_photos,

    -- Sent and received likes
    COALESCE(sl.sent_like_count, 0) AS sent_likes,
    COALESCE(rl.received_like_count, 0) AS received_likes,

    -- Behavioral metrics
    -- Match rate: percentage of received likes compared to sent likes
    CASE
        WHEN sl.sent_like_count > 0 THEN ROUND(rl.received_like_count::NUMERIC / sl.sent_like_count, 2)
        ELSE NULL
    END AS match_rate,

    -- Mutual like rate: percentage of matches compared to sent likes
    CASE
        WHEN sl.sent_like_count > 0 THEN ROUND(m.match_count::NUMERIC / sl.sent_like_count, 2)
        ELSE NULL
    END AS mutual_like_rate,

    -- Liked profile details
    -- Information about the profiles this user has liked
    lp.profile_target_id AS liked_profile_id,
    lg.gender_name AS liked_pet_gender,
    la.type_name AS liked_animal_type,
    lb.breed_name AS liked_breed,
    lci.city_name AS liked_city,
    lco.country_name AS liked_country,
    COALESCE(EXTRACT(YEAR FROM AGE(lp_data.date_of_birth)), 0) AS liked_pet_age,
    lp_data.price AS liked_price,
    COALESCE(lp_data.purebred_percentage, 0) AS liked_purebred_percentage,
    CASE WHEN lp_data.certification_url IS NOT NULL THEN 1 ELSE 0 END AS liked_has_certification,

    -- Liked profile photos
    COALESCE(lpc.active_photos, 0) AS liked_num_active_photos,

    -- Interaction times
    lp.like_created_at,
    lp.match_created_at,
    lp.is_matched,
    lp.days_until_match

FROM pet_profile p
LEFT JOIN gender g ON p.gender_id = g.gender_id
LEFT JOIN animal_type a ON p.type_id = a.type_id
LEFT JOIN breed b ON p.breed_id = b.breed_id
LEFT JOIN city ci ON p.city_id = ci.city_id
LEFT JOIN country c ON ci.country_id = c.country_id

-- Join aggregated photo count
LEFT JOIN photo_counts pc ON p.profile_id = pc.profile_id

-- Join sent and received likes
LEFT JOIN sent_likes sl ON p.profile_id = sl.profile_initiator_id
LEFT JOIN received_likes rl ON p.profile_id = rl.profile_target_id

-- Join mutual matches
LEFT JOIN matches m ON p.profile_id = m.profile_id_1

-- Join liked profile data
LEFT JOIN liked_profiles lp ON p.profile_id = lp.profile_initiator_id
LEFT JOIN pet_profile lp_data ON lp.profile_target_id = lp_data.profile_id
LEFT JOIN gender lg ON lp_data.gender_id = lg.gender_id
LEFT JOIN animal_type la ON lp_data.type_id = la.type_id
LEFT JOIN breed lb ON lp_data.breed_id = lb.breed_id
LEFT JOIN city lci ON lp_data.city_id = lci.city_id
LEFT JOIN country lco ON lci.country_id = lco.country_id

-- Join liked profile photo count
LEFT JOIN photo_counts lpc ON lp.profile_target_id = lpc.profile_id;
