SELECT
    p.profile_id,
    p.pet_name,
    g.gender_name AS pet_gender,
    a.type_name AS animal_type,
    b.breed_name,
    c.city_name,
    COALESCE(EXTRACT(YEAR FROM AGE(p.date_of_birth)), 0) AS pet_age,
    p.price,
    COALESCE(p.purebred_percentage, 0) AS purebred_percentage,
    CASE WHEN p.certification_url IS NOT NULL THEN 1 ELSE 0 END AS has_certification,
    COALESCE(pl.like_count, 0) AS received_likes,
    COALESCE(pm.match_count, 0) AS matches,
    COALESCE(msg.sent_messages, 0) AS sent_messages,
    CASE WHEN ph.active_photos > 0 THEN 1 ELSE 0 END AS has_active_photos,
    CASE WHEN pm.match_count > 0 THEN 1 ELSE 0 END AS is_matched

FROM
    pet_profile p
    LEFT JOIN gender g ON p.gender_id = g.gender_id
    LEFT JOIN animal_type a ON p.type_id = a.type_id
    LEFT JOIN breed b ON p.breed_id = b.breed_id
    LEFT JOIN city c ON p.city_id = c.city_id
    LEFT JOIN (
        SELECT profile_target_id, COUNT(*) AS like_count
        FROM pet_like
        GROUP BY profile_target_id
    ) pl ON p.profile_id = pl.profile_target_id
    LEFT JOIN (
        SELECT profile_id_1, COUNT(*) AS match_count
        FROM pet_match
        GROUP BY profile_id_1
    ) pm ON p.profile_id = pm.profile_id_1
    LEFT JOIN (
        SELECT profile_id, COUNT(*) AS sent_messages
        FROM message
        GROUP BY profile_id
    ) msg ON p.profile_id = msg.profile_id
    LEFT JOIN (
        SELECT profile_id, COUNT(*) AS active_photos
        FROM photo_data
        WHERE is_active = TRUE
        GROUP BY profile_id
    ) ph ON p.profile_id = ph.profile_id;
