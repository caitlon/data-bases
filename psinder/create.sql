-- remove if there is a function to remove tables and sequences
DROP FUNCTION IF EXISTS remove_all();

-- create a function that removes tables and sequences
CREATE or replace FUNCTION remove_all() RETURNS void AS $$
DECLARE
    rec RECORD;
    cmd text;
BEGIN
    cmd := '';

    FOR rec IN SELECT
            'DROP SEQUENCE ' || quote_ident(n.nspname) || '.'
                || quote_ident(c.relname) || ' CASCADE;' AS name
        FROM
            pg_catalog.pg_class AS c
        LEFT JOIN
            pg_catalog.pg_namespace AS n
        ON
            n.oid = c.relnamespace
        WHERE
            relkind = 'S' AND
            n.nspname NOT IN ('pg_catalog', 'pg_toast') AND
            pg_catalog.pg_table_is_visible(c.oid)
    LOOP
        cmd := cmd || rec.name;
    END LOOP;

    FOR rec IN SELECT
            'DROP TABLE ' || quote_ident(n.nspname) || '.'
                || quote_ident(c.relname) || ' CASCADE;' AS name
        FROM
            pg_catalog.pg_class AS c
        LEFT JOIN
            pg_catalog.pg_namespace AS n
        ON
            n.oid = c.relnamespace WHERE relkind = 'r' AND
            n.nspname NOT IN ('pg_catalog', 'pg_toast') AND
            pg_catalog.pg_table_is_visible(c.oid)
    LOOP
        cmd := cmd || rec.name;
    END LOOP;

    EXECUTE cmd;
    RETURN;
END;
$$ LANGUAGE plpgsql;
-- call a function that takes tables and sequences
select remove_all();

-- remove conflicting tables
DROP TABLE IF EXISTS animal_type CASCADE;
DROP TABLE IF EXISTS breed CASCADE;
DROP TABLE IF EXISTS breed_preference CASCADE;
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
-- end of removing

CREATE TABLE animal_type (
    type_id SERIAL NOT NULL,
    type_name VARCHAR(100) NOT NULL
);
ALTER TABLE animal_type ADD CONSTRAINT pk_animal_type PRIMARY KEY (type_id);

CREATE TABLE breed (
    breed_id SERIAL NOT NULL,
    type_id INTEGER NOT NULL,
    breed_name VARCHAR(100) NOT NULL
);
ALTER TABLE breed ADD CONSTRAINT pk_breed PRIMARY KEY (breed_id);

CREATE TABLE breed_preference (
    breed_id INTEGER NOT NULL,
    preference_id INTEGER NOT NULL
);
ALTER TABLE breed_preference ADD CONSTRAINT pk_breed_preference PRIMARY KEY (breed_id, preference_id);

CREATE TABLE city (
    city_id SERIAL NOT NULL,
    country_id INTEGER NOT NULL,
    city_name VARCHAR(100) NOT NULL
);
ALTER TABLE city ADD CONSTRAINT pk_city PRIMARY KEY (city_id);

CREATE TABLE city_preference (
    city_id INTEGER NOT NULL,
    preference_id INTEGER NOT NULL
);
ALTER TABLE city_preference ADD CONSTRAINT pk_city_preference PRIMARY KEY (city_id, preference_id);

CREATE TABLE conversation (
    conversation_id SERIAL NOT NULL,
    created_datetime TIMESTAMP NOT NULL
);
ALTER TABLE conversation ADD CONSTRAINT pk_conversation PRIMARY KEY (conversation_id);

CREATE TABLE conversation_member (
    conversation_id INTEGER NOT NULL,
    profile_id INTEGER NOT NULL
);
ALTER TABLE conversation_member ADD CONSTRAINT pk_conversation_member PRIMARY KEY (conversation_id, profile_id);

CREATE TABLE country (
    country_id SERIAL NOT NULL,
    country_name VARCHAR(100) NOT NULL
);
ALTER TABLE country ADD CONSTRAINT pk_country PRIMARY KEY (country_id);

CREATE TABLE country_preference (
    country_id INTEGER NOT NULL,
    preference_id INTEGER NOT NULL
);
ALTER TABLE country_preference ADD CONSTRAINT pk_country_preference PRIMARY KEY (country_id, preference_id);

CREATE TABLE gender (
    gender_id SERIAL NOT NULL,
    gender_name VARCHAR(100) NOT NULL
);
ALTER TABLE gender ADD CONSTRAINT pk_gender PRIMARY KEY (gender_id);

CREATE TABLE language (
    language_id SERIAL NOT NULL,
    language_name VARCHAR(100) NOT NULL
);
ALTER TABLE language ADD CONSTRAINT pk_language PRIMARY KEY (language_id);

CREATE TABLE message (
    message_id SERIAL NOT NULL,
    conversation_id INTEGER NOT NULL,
    profile_id INTEGER NOT NULL,
    content VARCHAR(500) NOT NULL,
    sent_datetime TIMESTAMP NOT NULL
);
ALTER TABLE message ADD CONSTRAINT pk_message PRIMARY KEY (message_id);

CREATE TABLE pet_like (
    profile_id INTEGER NOT NULL,
    pet_profile_profile_id INTEGER NOT NULL,
    created_datetime TIMESTAMP NOT NULL
);
ALTER TABLE pet_like ADD CONSTRAINT pk_pet_like PRIMARY KEY (profile_id, pet_profile_profile_id);

CREATE TABLE pet_match (
    profile_id INTEGER NOT NULL,
    pet_profile_profile_id INTEGER NOT NULL,
    created_datetime TIMESTAMP NOT NULL
);
ALTER TABLE pet_match ADD CONSTRAINT pk_pet_match PRIMARY KEY (profile_id, pet_profile_profile_id);

CREATE TABLE pet_preference (
    preference_id SERIAL NOT NULL,
    profile_id INTEGER NOT NULL,
    min_age INTEGER,
    max_age INTEGER,
    min_price INTEGER,
    max_price INTEGER,
    min_purebred_precentage INTEGER,
    max_purebred_precentage INTEGER,
    has_certification_uploaded BOOLEAN
);
ALTER TABLE pet_preference ADD CONSTRAINT pk_pet_preference PRIMARY KEY (preference_id);
ALTER TABLE pet_preference ADD CONSTRAINT u_fk_pet_preference_pet_profile UNIQUE (profile_id);

CREATE TABLE pet_profile (
    profile_id SERIAL NOT NULL,
    gender_id INTEGER NOT NULL,
    city_id INTEGER NOT NULL,
    breed_id INTEGER NOT NULL,
    type_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    pet_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    price INTEGER,
    certification_url TEXT,
    profile_description VARCHAR(500),
    purebred_percantage INTEGER,
    created_datetime TIMESTAMP NOT NULL
);
ALTER TABLE pet_profile ADD CONSTRAINT pk_pet_profile PRIMARY KEY (profile_id);
ALTER TABLE pet_profile ADD CONSTRAINT uc_pet_profile_certification_ur UNIQUE (certification_url);

CREATE TABLE phone_code (
    code_id SERIAL NOT NULL,
    country_id INTEGER NOT NULL,
    code_number VARCHAR(5) NOT NULL
);
ALTER TABLE phone_code ADD CONSTRAINT pk_phone_code PRIMARY KEY (code_id);
ALTER TABLE phone_code ADD CONSTRAINT u_fk_phone_code_country UNIQUE (country_id);

CREATE TABLE photo_data (
    photo_id SERIAL NOT NULL,
    profile_id INTEGER,
    user_id INTEGER,
    added_datetime TIMESTAMP NOT NULL,
    is_active BYTEA NOT NULL,
    photo_url TEXT NOT NULL
);
ALTER TABLE photo_data ADD CONSTRAINT pk_photo_data PRIMARY KEY (photo_id);
ALTER TABLE photo_data ADD CONSTRAINT uc_photo_data_photo_url UNIQUE (photo_url);
ALTER TABLE photo_data ADD CONSTRAINT u_fk_photo_data_user_account UNIQUE (user_id);

CREATE TABLE user_account (
    user_id SERIAL NOT NULL,
    code_id INTEGER NOT NULL,
    gender_id INTEGER,
    nickname VARCHAR(100) NOT NULL,
    email VARCHAR(256) NOT NULL,
    phone_number BIGINT NOT NULL,
    date_of_birth DATE NOT NULL,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100),
    account_description VARCHAR(500),
    password_hash TEXT NOT NULL,
    salt TEXT NOT NULL,
    created_datetime TIMESTAMP NOT NULL,
    is_active BOOLEAN NOT NULL
);
ALTER TABLE user_account ADD CONSTRAINT pk_user_account PRIMARY KEY (user_id);
ALTER TABLE user_account ADD CONSTRAINT uc_user_account_nickname UNIQUE (nickname);
ALTER TABLE user_account ADD CONSTRAINT uc_user_account_email UNIQUE (email);
ALTER TABLE user_account ADD CONSTRAINT uc_user_account_phone_number UNIQUE (phone_number);

CREATE TABLE user_block (
    user_id INTEGER NOT NULL,
    user_account_user_id INTEGER NOT NULL,
    blocked_datetime TIMESTAMP NOT NULL,
    content VARCHAR(500)
);
ALTER TABLE user_block ADD CONSTRAINT pk_user_block PRIMARY KEY (user_id, user_account_user_id);

CREATE TABLE user_grade (
    user_id INTEGER NOT NULL,
    user_account_user_id INTEGER NOT NULL,
    grade INTEGER NOT NULL,
    graded_datetime TIMESTAMP NOT NULL,
    content VARCHAR(500)
);
ALTER TABLE user_grade ADD CONSTRAINT pk_user_grade PRIMARY KEY (user_id, user_account_user_id);

CREATE TABLE user_language (
    user_id INTEGER NOT NULL,
    language_id INTEGER NOT NULL
);
ALTER TABLE user_language ADD CONSTRAINT pk_user_language PRIMARY KEY (user_id, language_id);

ALTER TABLE breed ADD CONSTRAINT fk_breed_animal_type FOREIGN KEY (type_id) REFERENCES animal_type (type_id) ON DELETE CASCADE;

ALTER TABLE breed_preference ADD CONSTRAINT fk_breed_preference_breed FOREIGN KEY (breed_id) REFERENCES breed (breed_id) ON DELETE CASCADE;
ALTER TABLE breed_preference ADD CONSTRAINT fk_breed_preference_pet_prefere FOREIGN KEY (preference_id) REFERENCES pet_preference (preference_id) ON DELETE CASCADE;

ALTER TABLE city ADD CONSTRAINT fk_city_country FOREIGN KEY (country_id) REFERENCES country (country_id) ON DELETE CASCADE;

ALTER TABLE city_preference ADD CONSTRAINT fk_city_preference_city FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE CASCADE;
ALTER TABLE city_preference ADD CONSTRAINT fk_city_preference_pet_preferen FOREIGN KEY (preference_id) REFERENCES pet_preference (preference_id) ON DELETE CASCADE;

ALTER TABLE conversation_member ADD CONSTRAINT fk_conversation_member_conversa FOREIGN KEY (conversation_id) REFERENCES conversation (conversation_id) ON DELETE CASCADE;
ALTER TABLE conversation_member ADD CONSTRAINT fk_conversation_member_pet_prof FOREIGN KEY (profile_id) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;

ALTER TABLE country_preference ADD CONSTRAINT fk_country_preference_country FOREIGN KEY (country_id) REFERENCES country (country_id) ON DELETE CASCADE;
ALTER TABLE country_preference ADD CONSTRAINT fk_country_preference_pet_prefe FOREIGN KEY (preference_id) REFERENCES pet_preference (preference_id) ON DELETE CASCADE;

ALTER TABLE message ADD CONSTRAINT fk_message_conversation FOREIGN KEY (conversation_id) REFERENCES conversation (conversation_id) ON DELETE CASCADE;
ALTER TABLE message ADD CONSTRAINT fk_message_pet_profile FOREIGN KEY (profile_id) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;

ALTER TABLE pet_like ADD CONSTRAINT fk_pet_like_pet_profile FOREIGN KEY (profile_id) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;
ALTER TABLE pet_like ADD CONSTRAINT fk_pet_like_pet_profile_1 FOREIGN KEY (pet_profile_profile_id) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;

ALTER TABLE pet_match ADD CONSTRAINT fk_pet_match_pet_profile FOREIGN KEY (profile_id) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;
ALTER TABLE pet_match ADD CONSTRAINT fk_pet_match_pet_profile_1 FOREIGN KEY (pet_profile_profile_id) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;

ALTER TABLE pet_preference ADD CONSTRAINT fk_pet_preference_pet_profile FOREIGN KEY (profile_id) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;

ALTER TABLE pet_profile ADD CONSTRAINT fk_pet_profile_gender FOREIGN KEY (gender_id) REFERENCES gender (gender_id) ON DELETE CASCADE;
ALTER TABLE pet_profile ADD CONSTRAINT fk_pet_profile_city FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE CASCADE;
ALTER TABLE pet_profile ADD CONSTRAINT fk_pet_profile_breed FOREIGN KEY (breed_id) REFERENCES breed (breed_id) ON DELETE CASCADE;
ALTER TABLE pet_profile ADD CONSTRAINT fk_pet_profile_animal_type FOREIGN KEY (type_id) REFERENCES animal_type (type_id) ON DELETE CASCADE;
ALTER TABLE pet_profile ADD CONSTRAINT fk_pet_profile_user_account FOREIGN KEY (user_id) REFERENCES user_account (user_id) ON DELETE CASCADE;

ALTER TABLE phone_code ADD CONSTRAINT fk_phone_code_country FOREIGN KEY (country_id) REFERENCES country (country_id) ON DELETE CASCADE;

ALTER TABLE photo_data ADD CONSTRAINT fk_photo_data_pet_profile FOREIGN KEY (profile_id) REFERENCES pet_profile (profile_id) ON DELETE CASCADE;
ALTER TABLE photo_data ADD CONSTRAINT fk_photo_data_user_account FOREIGN KEY (user_id) REFERENCES user_account (user_id) ON DELETE CASCADE;

ALTER TABLE user_account ADD CONSTRAINT fk_user_account_phone_code FOREIGN KEY (code_id) REFERENCES phone_code (code_id) ON DELETE CASCADE;
ALTER TABLE user_account ADD CONSTRAINT fk_user_account_gender FOREIGN KEY (gender_id) REFERENCES gender (gender_id) ON DELETE CASCADE;

ALTER TABLE user_block ADD CONSTRAINT fk_user_block_user_account FOREIGN KEY (user_id) REFERENCES user_account (user_id) ON DELETE CASCADE;
ALTER TABLE user_block ADD CONSTRAINT fk_user_block_user_account_1 FOREIGN KEY (user_account_user_id) REFERENCES user_account (user_id) ON DELETE CASCADE;

ALTER TABLE user_grade ADD CONSTRAINT fk_user_grade_user_account FOREIGN KEY (user_id) REFERENCES user_account (user_id) ON DELETE CASCADE;
ALTER TABLE user_grade ADD CONSTRAINT fk_user_grade_user_account_1 FOREIGN KEY (user_account_user_id) REFERENCES user_account (user_id) ON DELETE CASCADE;

ALTER TABLE user_language ADD CONSTRAINT fk_user_language_user_account FOREIGN KEY (user_id) REFERENCES user_account (user_id) ON DELETE CASCADE;
ALTER TABLE user_language ADD CONSTRAINT fk_user_language_language FOREIGN KEY (language_id) REFERENCES language (language_id) ON DELETE CASCADE;

ALTER TABLE photo_data ADD CONSTRAINT xc_photo_data_profile_id_user_i CHECK ((profile_id IS NOT NULL AND user_id IS NULL) OR (profile_id IS NULL AND user_id IS NOT NULL));

