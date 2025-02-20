SELECT
    -- Basic details about the animal's profile
    p.profile_id AS animal_profile_id,  -- Unique ID of the animal's profile
    c.country_name AS country,  -- Country where the pet is located
    g.gender_name AS pet_gender,  -- Gender of the pet
    a.type_name AS animal_type,  -- Type of animal (e.g., Dog, Cat)
    b.breed_name AS breed,  -- Breed of the pet
    ci.city_name AS city,  -- City where the pet is located
    COALESCE(EXTRACT(YEAR FROM AGE(p.date_of_birth)), 0) AS pet_age,  -- Age of the pet in years
    p.price,  -- Price (if applicable) of the pet
    COALESCE(p.purebred_percentage, 0) AS purebred_percentage,  -- Percentage indicating how purebred the pet is
    CASE WHEN p.certification_url IS NOT NULL THEN 1 ELSE 0 END AS has_certification,  -- Whether the pet has a certification

    -- Profile metadata and engagement statistics
    p.created_datetime AS profile_created_at,  -- Date when the profile was created

    -- Number of active photos associated with the pet's profile
    COALESCE(ph.active_photos, 0) AS num_active_photos,

    -- Number of likes sent and received by the pet's profile
    COALESCE(sent_likes.sent_like_count, 0) AS sent_likes,
    COALESCE(received_likes.received_like_count, 0) AS received_likes,

    -- Behavioral metrics for profile matching
    CASE
        WHEN sent_likes.sent_like_count > 0 THEN
            ROUND(received_likes.received_like_count::NUMERIC / sent_likes.sent_like_count, 2)
        ELSE NULL
    END AS match_rate,  -- Match rate: percentage of received likes compared to sent likes

    CASE
        WHEN sent_likes.sent_like_count > 0 THEN
            ROUND(matches.match_count::NUMERIC / sent_likes.sent_like_count, 2)
        ELSE NULL
    END AS mutual_like_rate,  -- Ratio of mutual matches compared to sent likes

    -- Information about the liked profile
    pl.profile_target_id AS liked_profile_id,  -- ID of the liked profile
    tg.gender_name AS liked_pet_gender,  -- Gender of the liked pet
    ta.type_name AS liked_animal_type,  -- Type of the liked animal
    tb.breed_name AS liked_breed,  -- Breed of the liked pet
    tci.city_name AS liked_city,  -- City of the liked pet
    tco.country_name AS liked_country,  -- Country of the liked pet
    COALESCE(EXTRACT(YEAR FROM AGE(tp.date_of_birth)), 0) AS liked_pet_age,  -- Age of the liked pet
    tp.price AS liked_price,  -- Price of the liked pet
    COALESCE(tp.purebred_percentage, 0) AS liked_purebred_percentage,  -- Purebred percentage of the liked pet
    CASE WHEN tp.certification_url IS NOT NULL THEN 1 ELSE 0 END AS liked_has_certification,  -- Whether the liked pet has certification

    -- Number of active photos for the liked profile
    COALESCE(liked_ph.active_photos, 0) AS liked_num_active_photos,

    -- Interaction timestamps
    pl.created_datetime AS like_created_at,  -- Timestamp when the like was given
    pm.created_datetime AS match_created_at,  -- Timestamp when a match occurred

    -- Whether the liked profile resulted in a mutual match
    CASE WHEN pm.profile_id_1 IS NOT NULL THEN 1 ELSE 0 END AS is_matched,

    -- Time (in days) until a match occurred after a like
    CASE
        WHEN pm.created_datetime IS NOT NULL THEN
            EXTRACT(DAY FROM (pm.created_datetime - pl.created_datetime))
        ELSE NULL
    END AS days_until_match

FROM
    pet_profile p
    LEFT JOIN gender g ON p.gender_id = g.gender_id
    LEFT JOIN animal_type a ON p.type_id = a.type_id
    LEFT JOIN breed b ON p.breed_id = b.breed_id
    LEFT JOIN city ci ON p.city_id = ci.city_id
    LEFT JOIN country c ON ci.country_id = c.country_id

    -- Counting the number of active photos for each profile
    LEFT JOIN (
        SELECT profile_id, COUNT(*) AS active_photos
        FROM photo_data
        WHERE is_active = TRUE
        GROUP BY profile_id
    ) ph ON p.profile_id = ph.profile_id

    -- Counting the number of likes sent by each profile
    LEFT JOIN (
        SELECT profile_initiator_id, COUNT(*) AS sent_like_count
        FROM pet_like
        GROUP BY profile_initiator_id
    ) sent_likes ON p.profile_id = sent_likes.profile_initiator_id

    -- Counting the number of likes received by each profile
    LEFT JOIN (
        SELECT profile_target_id, COUNT(*) AS received_like_count
        FROM pet_like
        GROUP BY profile_target_id
    ) received_likes ON p.profile_id = received_likes.profile_target_id

    -- Counting the number of mutual matches for each profile
    LEFT JOIN (
        SELECT profile_id_1, COUNT(*) AS match_count
        FROM pet_match
        GROUP BY profile_id_1
    ) matches ON p.profile_id = matches.profile_id_1

    -- Fetching details about the liked profile
    LEFT JOIN pet_like pl ON p.profile_id = pl.profile_initiator_id
    LEFT JOIN pet_profile tp ON pl.profile_target_id = tp.profile_id
    LEFT JOIN gender tg ON tp.gender_id = tg.gender_id
    LEFT JOIN animal_type ta ON tp.type_id = ta.type_id
    LEFT JOIN breed tb ON tp.breed_id = tb.breed_id
    LEFT JOIN city tci ON tp.city_id = tci.city_id
    LEFT JOIN country tco ON tci.country_id = tco.country_id

    -- Counting the number of active photos for the liked profile
    LEFT JOIN (
        SELECT profile_id, COUNT(*) AS active_photos
        FROM photo_data
        WHERE is_active = TRUE
        GROUP BY profile_id
    ) liked_ph ON tp.profile_id = liked_ph.profile_id

    -- Checking if there was a mutual match
    LEFT JOIN pet_match pm ON (
        (pm.profile_id_1 = p.profile_id AND pm.profile_id_2 = pl.profile_target_id)
        OR (pm.profile_id_2 = p.profile_id AND pm.profile_id_1 = pl.profile_target_id)
    );
