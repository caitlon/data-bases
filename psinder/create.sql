-- Remove if there is a function to remove tables and sequences
DROP FUNCTION IF EXISTS remove_all();

-- Create a function that removes tables and sequences
CREATE or replace FUNCTION remove_all() RETURNS void AS
$$
DECLARE
    rec RECORD;
    cmd text;
BEGIN
    cmd := '';

    FOR rec IN SELECT 'DROP SEQUENCE ' || quote_ident(n.nspname) || '.'
                          || quote_ident(c.relname) || ' CASCADE;' AS name
               FROM pg_catalog.pg_class AS c
                        LEFT JOIN
                    pg_catalog.pg_namespace AS n
                    ON
                        n.oid = c.relnamespace
               WHERE relkind = 'S'
                 AND n.nspname NOT IN ('pg_catalog', 'pg_toast')
                 AND pg_catalog.pg_table_is_visible(c.oid)
        LOOP
            cmd := cmd || rec.name;
        END LOOP;

    FOR rec IN SELECT 'DROP TABLE ' || quote_ident(n.nspname) || '.'
                          || quote_ident(c.relname) || ' CASCADE;' AS name
               FROM pg_catalog.pg_class AS c
                        LEFT JOIN
                    pg_catalog.pg_namespace AS n
                    ON
                        n.oid = c.relnamespace
               WHERE relkind = 'r'
                 AND n.nspname NOT IN ('pg_catalog', 'pg_toast')
                 AND pg_catalog.pg_table_is_visible(c.oid)
        LOOP
            cmd := cmd || rec.name;
        END LOOP;

    EXECUTE cmd;
    RETURN;
END;
$$ LANGUAGE plpgsql;
-- Call a function that takes tables and sequences
select remove_all();
-- Remove conflicting tables
DROP TABLE IF EXISTS animal_type CASCADE;
DROP TABLE IF EXISTS breed CASCADE;
DROP TABLE IF EXISTS city CASCADE;
DROP TABLE IF EXISTS city_preference CASCADE;
DROP TABLE IF EXISTS conversation CASCADE;
DROP TABLE IF EXISTS conversation_member CASCADE;
DROP TABLE IF EXISTS country CASCADE;
DROP TABLE IF EXISTS country_preference CASCADE;
DROP TABLE IF EXISTS gender CASCADE;
DROP TABLE IF EXISTS language CASCADE;
DROP TABLE IF EXISTS message CASCADE;
DROP TABLE IF EXISTS pet_like CASCADE;
DROP TABLE IF EXISTS pet_match CASCADE;
DROP TABLE IF EXISTS pet_preference CASCADE;
DROP TABLE IF EXISTS pet_profile CASCADE;
DROP TABLE IF EXISTS phone_code CASCADE;
DROP TABLE IF EXISTS photo_data CASCADE;
DROP TABLE IF EXISTS user_account CASCADE;
DROP TABLE IF EXISTS user_block CASCADE;
DROP TABLE IF EXISTS user_grade CASCADE;
DROP TABLE IF EXISTS user_language CASCADE;
-- End of removing

CREATE TABLE animal_type
(
    type_id   SERIAL       NOT NULL,
    type_name VARCHAR(100) NOT NULL
);
ALTER TABLE animal_type
    ADD CONSTRAINT pk_animal_type PRIMARY KEY (type_id);
ALTER TABLE animal_type
    ADD CONSTRAINT uc_animal_type_name UNIQUE (type_name);

CREATE TABLE breed
(
    breed_id   SERIAL       NOT NULL,
    type_id    INTEGER      NOT NULL,
    breed_name VARCHAR(100) NOT NULL
);
ALTER TABLE breed
    ADD CONSTRAINT pk_breed PRIMARY KEY (breed_id);

CREATE TABLE city
(
    city_id    SERIAL       NOT NULL,
    country_id INTEGER      NOT NULL,
    city_name  VARCHAR(100) NOT NULL
);
ALTER TABLE city
    ADD CONSTRAINT pk_city PRIMARY KEY (city_id);

CREATE TABLE city_preference
(
    city_id       INTEGER NOT NULL,
    preference_id INTEGER NOT NULL
);
ALTER TABLE city_preference
    ADD CONSTRAINT pk_city_preference PRIMARY KEY (city_id, preference_id);

CREATE TABLE conversation
(
    conversation_id  SERIAL    NOT NULL,
    created_datetime TIMESTAMP NOT NULL
);
ALTER TABLE conversation
    ADD CONSTRAINT pk_conversation PRIMARY KEY (conversation_id);

CREATE TABLE conversation_member
(
    conversation_id INTEGER NOT NULL,
    profile_id      INTEGER NOT NULL
);
ALTER TABLE conversation_member
    ADD CONSTRAINT pk_conversation_member PRIMARY KEY (conversation_id, profile_id);

CREATE TABLE country
(
    country_id   SERIAL       NOT NULL,
    country_name VARCHAR(100) NOT NULL
);
ALTER TABLE country
    ADD CONSTRAINT pk_country PRIMARY KEY (country_id);
ALTER TABLE country
    ADD CONSTRAINT uc_country_name UNIQUE (country_name);

CREATE TABLE country_preference
(
    country_id    INTEGER NOT NULL,
    preference_id INTEGER NOT NULL
);
ALTER TABLE country_preference
    ADD CONSTRAINT pk_country_preference PRIMARY KEY (country_id, preference_id);

CREATE TABLE gender
(
    gender_id   SERIAL       NOT NULL,
    gender_name VARCHAR(100) NOT NULL
);
ALTER TABLE gender
    ADD CONSTRAINT pk_gender PRIMARY KEY (gender_id);
ALTER TABLE gender
    ADD CONSTRAINT uc_gender_name UNIQUE (gender_name);

CREATE TABLE language
(
    language_id   SERIAL       NOT NULL,
    language_name VARCHAR(100) NOT NULL
);
ALTER TABLE language
    ADD CONSTRAINT pk_language PRIMARY KEY (language_id);
ALTER TABLE language
    ADD CONSTRAINT uc_language_name UNIQUE (language_name);

CREATE TABLE message
(
    message_id      SERIAL       NOT NULL,
    conversation_id INTEGER      NOT NULL,
    profile_id      INTEGER      NOT NULL,
    content         VARCHAR(500) NOT NULL,
    sent_datetime   TIMESTAMP    NOT NULL
);
ALTER TABLE message
    ADD CONSTRAINT pk_message PRIMARY KEY (message_id);

CREATE TABLE pet_like
(
    profile_initiator_id INTEGER   NOT NULL,
    profile_target_id    INTEGER   NOT NULL,
    created_datetime     TIMESTAMP NOT NULL
);
ALTER TABLE pet_like
    ADD CONSTRAINT pk_pet_like PRIMARY KEY (profile_initiator_id, profile_target_id);
CREATE INDEX idx_pet_like_initiator_target ON pet_like (profile_initiator_id, profile_target_id);
CREATE INDEX idx_pet_like_target_initiator ON pet_like (profile_target_id, profile_initiator_id);

CREATE TABLE pet_match
(
    profile_id_1     INTEGER   NOT NULL,
    profile_id_2     INTEGER   NOT NULL,
    created_datetime TIMESTAMP NOT NULL
);
ALTER TABLE pet_match
    ADD CONSTRAINT pk_pet_match PRIMARY KEY (profile_id_1, profile_id_2);

CREATE TABLE pet_preference
(
    preference_id              SERIAL  NOT NULL,
    profile_id                 INTEGER NOT NULL,
    min_age                    INTEGER,
    max_age                    INTEGER,
    min_price                  INTEGER,
    max_price                  INTEGER,
    min_purebred_precentage    INTEGER,
    max_purebred_precentage    INTEGER,
    has_certification_uploaded BOOLEAN
);
ALTER TABLE pet_preference
    ADD CONSTRAINT pk_pet_preference PRIMARY KEY (preference_id);
ALTER TABLE pet_preference
    ADD CONSTRAINT u_fk_pet_preference_pet_profile UNIQUE (profile_id);

CREATE TABLE pet_profile
(
    profile_id          SERIAL       NOT NULL,
    gender_id           INTEGER      NOT NULL,
    city_id             INTEGER      NOT NULL,
    type_id             INTEGER      NOT NULL,
    user_id             INTEGER      NOT NULL,
    pet_name            VARCHAR(100) NOT NULL,
    date_of_birth       DATE         NOT NULL,
    breed_id            INTEGER,
    price               INTEGER,
    certification_url   TEXT,
    profile_description VARCHAR(500),
    purebred_percantage INTEGER,
    created_datetime    TIMESTAMP    NOT NULL
);
ALTER TABLE pet_profile
    ADD CONSTRAINT pk_pet_profile PRIMARY KEY (profile_id);
ALTER TABLE pet_profile
    ADD CONSTRAINT uc_pet_profile_certification_ur UNIQUE (certification_url);

CREATE TABLE phone_code
(
    code_id     SERIAL     NOT NULL,
    country_id  INTEGER    NOT NULL,
    code_number VARCHAR(5) NOT NULL
);
ALTER TABLE phone_code
    ADD CONSTRAINT pk_phone_code PRIMARY KEY (code_id);
ALTER TABLE phone_code
    ADD CONSTRAINT u_fk_phone_code_country UNIQUE (country_id);
ALTER TABLE phone_code
    ADD CONSTRAINT uc_phone_code_number UNIQUE (code_number);

CREATE TABLE photo_data
(
    photo_id       SERIAL    NOT NULL,
    profile_id     INTEGER,
    user_id        INTEGER,
    added_datetime TIMESTAMP NOT NULL,
    is_active      BOOLEAN   NOT NULL,
    photo_url      TEXT      NOT NULL
);
ALTER TABLE photo_data
    ADD CONSTRAINT pk_photo_data PRIMARY KEY (photo_id);
ALTER TABLE photo_data
    ADD CONSTRAINT uc_photo_data_photo_url UNIQUE (photo_url);
ALTER TABLE photo_data
    ADD CONSTRAINT u_fk_photo_data_user_account UNIQUE (user_id);

CREATE TABLE user_account
(
    user_id             SERIAL       NOT NULL,
    code_id             INTEGER      NOT NULL,
    gender_id           INTEGER,
    nickname            VARCHAR(100) NOT NULL,
    email               VARCHAR(256) NOT NULL,
    phone_number        VARCHAR(15)  NOT NULL,
    date_of_birth       DATE         NOT NULL,
    firstname           VARCHAR(100) NOT NULL,
    lastname            VARCHAR(100),
    account_description VARCHAR(500),
    password_hash       TEXT         NOT NULL,
    salt                TEXT         NOT NULL,
    created_datetime    TIMESTAMP    NOT NULL,
    is_active           BOOLEAN      NOT NULL
);
ALTER TABLE user_account
    ADD CONSTRAINT pk_user_account PRIMARY KEY (user_id);
ALTER TABLE user_account
    ADD CONSTRAINT uc_user_account_nickname UNIQUE (nickname);
ALTER TABLE user_account
    ADD CONSTRAINT uc_user_account_email UNIQUE (email);
ALTER TABLE user_account
    ADD CONSTRAINT uc_user_account_phone_number UNIQUE (phone_number);

CREATE TABLE user_block
(
    user_giver_id    INTEGER   NOT NULL,
    user_receiver_id INTEGER   NOT NULL,
    blocked_datetime TIMESTAMP NOT NULL,
    content          VARCHAR(500)
);
ALTER TABLE user_block
    ADD CONSTRAINT pk_user_block PRIMARY KEY (user_giver_id, user_receiver_id);

CREATE TABLE user_grade
(
    user_giver_id    INTEGER   NOT NULL,
    user_receiver_id INTEGER   NOT NULL,
    grade            INTEGER   NOT NULL,
    graded_datetime  TIMESTAMP NOT NULL,
    content          VARCHAR(500)
);
ALTER TABLE user_grade
    ADD CONSTRAINT pk_user_grade PRIMARY KEY (user_giver_id, user_receiver_id);

CREATE TABLE user_language
(
    user_id     INTEGER NOT NULL,
    language_id INTEGER NOT NULL
);
ALTER TABLE user_language
    ADD CONSTRAINT pk_user_language PRIMARY KEY (user_id, language_id);

ALTER TABLE breed
    ADD CONSTRAINT fk_breed_animal_type FOREIGN KEY (type_id) REFERENCES animal_type (type_id) ON DELETE CASCADE;

ALTER TABLE city
    ADD CONSTRAINT fk_city_country FOREIGN KEY (country_id) REFERENCES country (country_id) ON DELETE CASCADE;

ALTER TABLE city_preference
    ADD CONSTRAINT fk_city_preference_city FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE CASCADE;
ALTER TABLE city_preference
    ADD CONSTRAINT fk_city_preference_pet_preferen FOREIGN KEY (preference_id) REFERENCES pet_preference (preference_id) ON DELETE CASCADE;

ALTER TABLE conversation_member
    ADD CONSTRAINT fk_conversation_member_conversa FOREIGN KEY (conversation_id) REFERENCES conversation (conversation_id) ON DELETE CASCADE;
ALTER TABLE conversation_member
    ADD CONSTRAINT fk_conversation_member_pet_prof FOREIGN KEY (profile_id) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;

ALTER TABLE country_preference
    ADD CONSTRAINT fk_country_preference_country FOREIGN KEY (country_id) REFERENCES country (country_id) ON DELETE CASCADE;
ALTER TABLE country_preference
    ADD CONSTRAINT fk_country_preference_pet_prefe FOREIGN KEY (preference_id) REFERENCES pet_preference (preference_id) ON DELETE CASCADE;

ALTER TABLE message
    ADD CONSTRAINT fk_message_conversation FOREIGN KEY (conversation_id) REFERENCES conversation (conversation_id) ON DELETE CASCADE;
ALTER TABLE message
    ADD CONSTRAINT fk_message_pet_profile FOREIGN KEY (profile_id) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;

ALTER TABLE pet_like
    ADD CONSTRAINT fk_pet_like_pet_profile FOREIGN KEY (profile_initiator_id) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;
ALTER TABLE pet_like
    ADD CONSTRAINT fk_pet_like_pet_profile_1 FOREIGN KEY (profile_target_id) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;

ALTER TABLE pet_match
    ADD CONSTRAINT fk_pet_match_pet_profile FOREIGN KEY (profile_id_1) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;
ALTER TABLE pet_match
    ADD CONSTRAINT fk_pet_match_pet_profile_1 FOREIGN KEY (profile_id_2) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;

ALTER TABLE pet_preference
    ADD CONSTRAINT fk_pet_preference_pet_profile FOREIGN KEY (profile_id) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;

ALTER TABLE pet_profile
    ADD CONSTRAINT fk_pet_profile_gender FOREIGN KEY (gender_id) REFERENCES gender (gender_id) ON DELETE CASCADE;
ALTER TABLE pet_profile
    ADD CONSTRAINT fk_pet_profile_city FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE CASCADE;
ALTER TABLE pet_profile
    ADD CONSTRAINT fk_pet_profile_breed FOREIGN KEY (breed_id) REFERENCES breed (breed_id) ON DELETE CASCADE;
ALTER TABLE pet_profile
    ADD CONSTRAINT fk_pet_profile_animal_type FOREIGN KEY (type_id) REFERENCES animal_type (type_id) ON DELETE CASCADE;
ALTER TABLE pet_profile
    ADD CONSTRAINT fk_pet_profile_user_account FOREIGN KEY (user_id) REFERENCES user_account (user_id) ON DELETE CASCADE;

ALTER TABLE phone_code
    ADD CONSTRAINT fk_phone_code_country FOREIGN KEY (country_id) REFERENCES country (country_id) ON DELETE CASCADE;

ALTER TABLE photo_data
    ADD CONSTRAINT fk_photo_data_pet_profile FOREIGN KEY (profile_id) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;
ALTER TABLE photo_data
    ADD CONSTRAINT fk_photo_data_user_account FOREIGN KEY (user_id) REFERENCES user_account (user_id) ON DELETE CASCADE;

ALTER TABLE user_account
    ADD CONSTRAINT fk_user_account_phone_code FOREIGN KEY (code_id) REFERENCES phone_code (code_id) ON DELETE CASCADE;
ALTER TABLE user_account
    ADD CONSTRAINT fk_user_account_gender FOREIGN KEY (gender_id) REFERENCES gender (gender_id) ON DELETE CASCADE;

ALTER TABLE user_block
    ADD CONSTRAINT fk_user_block_user_account FOREIGN KEY (user_giver_id) REFERENCES user_account (user_id) ON DELETE CASCADE;
ALTER TABLE user_block
    ADD CONSTRAINT fk_user_block_user_account_1 FOREIGN KEY (user_receiver_id) REFERENCES user_account (user_id) ON DELETE CASCADE;

ALTER TABLE user_grade
    ADD CONSTRAINT fk_user_grade_user_account FOREIGN KEY (user_giver_id) REFERENCES user_account (user_id) ON DELETE CASCADE;
ALTER TABLE user_grade
    ADD CONSTRAINT fk_user_grade_user_account_1 FOREIGN KEY (user_receiver_id) REFERENCES user_account (user_id) ON DELETE CASCADE;

ALTER TABLE user_language
    ADD CONSTRAINT fk_user_language_user_account FOREIGN KEY (user_id) REFERENCES user_account (user_id) ON DELETE CASCADE;
ALTER TABLE user_language
    ADD CONSTRAINT fk_user_language_language FOREIGN KEY (language_id) REFERENCES language (language_id) ON DELETE CASCADE;

ALTER TABLE photo_data
    ADD CONSTRAINT xc_photo_data_profile_id_user_i CHECK ((profile_id IS NOT NULL AND user_id IS NULL) OR
                                                          (profile_id IS NULL AND user_id IS NOT NULL));

CREATE OR REPLACE FUNCTION create_pet_match()
    RETURNS TRIGGER AS
$$
DECLARE
    mutual_like_exists BOOLEAN;
    match_exists       BOOLEAN;
    min_profile_id     INTEGER;
    max_profile_id     INTEGER;
    latest_like_time   TIMESTAMP;
BEGIN
    -- Checking to see if there is a mutual like
    SELECT EXISTS (SELECT 1
                   FROM pet_like
                   WHERE profile_initiator_id = NEW.profile_target_id
                     AND profile_target_id = NEW.profile_initiator_id)
    INTO mutual_like_exists;

    IF mutual_like_exists THEN
        -- Define minimum and maximum profile_id to maintain order
        IF NEW.profile_initiator_id < NEW.profile_target_id THEN
            min_profile_id := NEW.profile_initiator_id;
            max_profile_id := NEW.profile_target_id;
        ELSE
            min_profile_id := NEW.profile_target_id;
            max_profile_id := NEW.profile_initiator_id;
        END IF;

        -- Check if a match already exists between these profiles
        SELECT EXISTS (SELECT 1
                       FROM pet_match
                       WHERE profile_id_1 = min_profile_id
                         AND profile_id_2 = max_profile_id)
        INTO match_exists;

        -- Get the latest like time
        SELECT GREATEST(
                       (SELECT created_datetime
                        FROM pet_like
                        WHERE profile_initiator_id = NEW.profile_initiator_id
                          AND profile_target_id = NEW.profile_target_id),
                       (SELECT created_datetime
                        FROM pet_like
                        WHERE profile_initiator_id = NEW.profile_target_id
                          AND profile_target_id = NEW.profile_initiator_id)
               )
        INTO latest_like_time;

        IF NOT match_exists THEN
            INSERT INTO pet_match (profile_id_1, profile_id_2, created_datetime)
            VALUES (min_profile_id, max_profile_id, latest_like_time);
        END IF;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER pet_match_trigger
    AFTER INSERT
    ON pet_like
    FOR EACH ROW
EXECUTE FUNCTION create_pet_match();

CREATE OR REPLACE FUNCTION create_conversation_from_match()
    RETURNS TRIGGER AS
$$
DECLARE
    new_conversation_id INTEGER;
BEGIN
    -- Create a new record in the conversation table using the date from match.created_datetime
    INSERT INTO conversation (created_datetime)
    VALUES (NEW.created_datetime)
    RETURNING conversation_id INTO new_conversation_id;

    INSERT INTO conversation_member (conversation_id, profile_id)
    VALUES (new_conversation_id, NEW.profile_id_1),
           (new_conversation_id, NEW.profile_id_2);

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER create_conversation_trigger
    AFTER INSERT
    ON pet_match
    FOR EACH ROW
EXECUTE FUNCTION create_conversation_from_match();
