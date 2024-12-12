-- Delete all records from tables
CREATE or replace FUNCTION clean_tables() RETURNS void AS
$$
declare
    l_stmt text;
begin
    select 'truncate ' || string_agg(format('%I.%I', schemaname, tablename), ',')
    into l_stmt
    from pg_tables
    where schemaname in ('public');

    execute l_stmt || ' cascade';
end;
$$ LANGUAGE plpgsql;
select clean_tables();

-- Reset sequence
CREATE or replace FUNCTION restart_sequences() RETURNS void AS
$$
DECLARE
    i TEXT;
BEGIN
    FOR i IN (SELECT column_default FROM information_schema.columns WHERE column_default SIMILAR TO 'nextval%')
        LOOP
            EXECUTE 'ALTER SEQUENCE' || ' ' || substring(substring(i from '''[a-z_]*') from '[a-z_]+') || ' ' ||
                    ' RESTART 1;';
        END LOOP;
END
$$ LANGUAGE plpgsql;
select restart_sequences();
-- End of reset

INSERT INTO country (country_name)
VALUES ('Austria'),
       ('Belarus'),
       ('Belgium'),
       ('Bulgaria'),
       ('Croatia'),
       ('Cyprus'),
       ('Czechia'),
       ('Denmark'),
       ('Estonia'),
       ('Finland'),
       ('France'),
       ('Germany'),
       ('Greece'),
       ('Hungary'),
       ('Ireland'),
       ('Italy'),
       ('Latvia'),
       ('Lithuania'),
       ('Luxembourg'),
       ('Malta'),
       ('Netherlands'),
       ('Poland'),
       ('Portugal'),
       ('Romania'),
       ('Russia'),
       ('Slovakia'),
       ('Slovenia'),
       ('Spain'),
       ('Sweden'),
       ('Ukraine'),
       ('United Kingdom'),
       ('Uzbekistan');

INSERT INTO city (city_name, country_id)
VALUES ('Vienna', (SELECT country_id FROM country WHERE country_name = 'Austria')),
       ('Graz', (SELECT country_id FROM country WHERE country_name = 'Austria')),
       ('Linz', (SELECT country_id FROM country WHERE country_name = 'Austria')),
       ('Salzburg', (SELECT country_id FROM country WHERE country_name = 'Austria')),
       ('Innsbruck', (SELECT country_id FROM country WHERE country_name = 'Austria')),

       ('Minsk', (SELECT country_id FROM country WHERE country_name = 'Belarus')),
       ('Gomel', (SELECT country_id FROM country WHERE country_name = 'Belarus')),
       ('Mogilev', (SELECT country_id FROM country WHERE country_name = 'Belarus')),
       ('Vitebsk', (SELECT country_id FROM country WHERE country_name = 'Belarus')),
       ('Grodno', (SELECT country_id FROM country WHERE country_name = 'Belarus')),

       ('Brussels', (SELECT country_id FROM country WHERE country_name = 'Belgium')),
       ('Antwerp', (SELECT country_id FROM country WHERE country_name = 'Belgium')),
       ('Ghent', (SELECT country_id FROM country WHERE country_name = 'Belgium')),
       ('Charleroi', (SELECT country_id FROM country WHERE country_name = 'Belgium')),
       ('Liège', (SELECT country_id FROM country WHERE country_name = 'Belgium')),

       ('Sofia', (SELECT country_id FROM country WHERE country_name = 'Bulgaria')),
       ('Plovdiv', (SELECT country_id FROM country WHERE country_name = 'Bulgaria')),
       ('Varna', (SELECT country_id FROM country WHERE country_name = 'Bulgaria')),
       ('Burgas', (SELECT country_id FROM country WHERE country_name = 'Bulgaria')),
       ('Ruse', (SELECT country_id FROM country WHERE country_name = 'Bulgaria')),

       ('Zagreb', (SELECT country_id FROM country WHERE country_name = 'Croatia')),
       ('Split', (SELECT country_id FROM country WHERE country_name = 'Croatia')),
       ('Rijeka', (SELECT country_id FROM country WHERE country_name = 'Croatia')),
       ('Osijek', (SELECT country_id FROM country WHERE country_name = 'Croatia')),
       ('Zadar', (SELECT country_id FROM country WHERE country_name = 'Croatia')),

       ('Nicosia', (SELECT country_id FROM country WHERE country_name = 'Cyprus')),
       ('Limassol', (SELECT country_id FROM country WHERE country_name = 'Cyprus')),
       ('Larnaca', (SELECT country_id FROM country WHERE country_name = 'Cyprus')),
       ('Paphos', (SELECT country_id FROM country WHERE country_name = 'Cyprus')),
       ('Famagusta', (SELECT country_id FROM country WHERE country_name = 'Cyprus')),

       ('Prague', (SELECT country_id FROM country WHERE country_name = 'Czechia')),
       ('Brno', (SELECT country_id FROM country WHERE country_name = 'Czechia')),
       ('Ostrava', (SELECT country_id FROM country WHERE country_name = 'Czechia')),
       ('Plzeň', (SELECT country_id FROM country WHERE country_name = 'Czechia')),
       ('Liberec', (SELECT country_id FROM country WHERE country_name = 'Czechia')),

       ('Copenhagen', (SELECT country_id FROM country WHERE country_name = 'Denmark')),
       ('Aarhus', (SELECT country_id FROM country WHERE country_name = 'Denmark')),
       ('Odense', (SELECT country_id FROM country WHERE country_name = 'Denmark')),
       ('Aalborg', (SELECT country_id FROM country WHERE country_name = 'Denmark')),
       ('Esbjerg', (SELECT country_id FROM country WHERE country_name = 'Denmark')),

       ('Tallinn', (SELECT country_id FROM country WHERE country_name = 'Estonia')),
       ('Tartu', (SELECT country_id FROM country WHERE country_name = 'Estonia')),
       ('Narva', (SELECT country_id FROM country WHERE country_name = 'Estonia')),
       ('Pärnu', (SELECT country_id FROM country WHERE country_name = 'Estonia')),
       ('Kohtla-Järve', (SELECT country_id FROM country WHERE country_name = 'Estonia')),

       ('Helsinki', (SELECT country_id FROM country WHERE country_name = 'Finland')),
       ('Espoo', (SELECT country_id FROM country WHERE country_name = 'Finland')),
       ('Tampere', (SELECT country_id FROM country WHERE country_name = 'Finland')),
       ('Vantaa', (SELECT country_id FROM country WHERE country_name = 'Finland')),
       ('Oulu', (SELECT country_id FROM country WHERE country_name = 'Finland')),

       ('Paris', (SELECT country_id FROM country WHERE country_name = 'France')),
       ('Marseille', (SELECT country_id FROM country WHERE country_name = 'France')),
       ('Lyon', (SELECT country_id FROM country WHERE country_name = 'France')),
       ('Toulouse', (SELECT country_id FROM country WHERE country_name = 'France')),
       ('Nice', (SELECT country_id FROM country WHERE country_name = 'France')),

       ('Berlin', (SELECT country_id FROM country WHERE country_name = 'Germany')),
       ('Hamburg', (SELECT country_id FROM country WHERE country_name = 'Germany')),
       ('Munich', (SELECT country_id FROM country WHERE country_name = 'Germany')),
       ('Cologne', (SELECT country_id FROM country WHERE country_name = 'Germany')),
       ('Frankfurt', (SELECT country_id FROM country WHERE country_name = 'Germany')),

       ('Athens', (SELECT country_id FROM country WHERE country_name = 'Greece')),
       ('Thessaloniki', (SELECT country_id FROM country WHERE country_name = 'Greece')),
       ('Patras', (SELECT country_id FROM country WHERE country_name = 'Greece')),
       ('Heraklion', (SELECT country_id FROM country WHERE country_name = 'Greece')),
       ('Larissa', (SELECT country_id FROM country WHERE country_name = 'Greece')),

       ('Budapest', (SELECT country_id FROM country WHERE country_name = 'Hungary')),
       ('Debrecen', (SELECT country_id FROM country WHERE country_name = 'Hungary')),
       ('Szeged', (SELECT country_id FROM country WHERE country_name = 'Hungary')),
       ('Miskolc', (SELECT country_id FROM country WHERE country_name = 'Hungary')),
       ('Pécs', (SELECT country_id FROM country WHERE country_name = 'Hungary')),

       ('Dublin', (SELECT country_id FROM country WHERE country_name = 'Ireland')),
       ('Cork', (SELECT country_id FROM country WHERE country_name = 'Ireland')),
       ('Limerick', (SELECT country_id FROM country WHERE country_name = 'Ireland')),
       ('Galway', (SELECT country_id FROM country WHERE country_name = 'Ireland')),
       ('Waterford', (SELECT country_id FROM country WHERE country_name = 'Ireland')),

       ('Rome', (SELECT country_id FROM country WHERE country_name = 'Italy')),
       ('Milan', (SELECT country_id FROM country WHERE country_name = 'Italy')),
       ('Naples', (SELECT country_id FROM country WHERE country_name = 'Italy')),
       ('Turin', (SELECT country_id FROM country WHERE country_name = 'Italy')),
       ('Palermo', (SELECT country_id FROM country WHERE country_name = 'Italy')),

       ('Riga', (SELECT country_id FROM country WHERE country_name = 'Latvia')),
       ('Daugavpils', (SELECT country_id FROM country WHERE country_name = 'Latvia')),
       ('Liepāja', (SELECT country_id FROM country WHERE country_name = 'Latvia')),
       ('Jelgava', (SELECT country_id FROM country WHERE country_name = 'Latvia')),
       ('Jūrmala', (SELECT country_id FROM country WHERE country_name = 'Latvia')),

       ('Vilnius', (SELECT country_id FROM country WHERE country_name = 'Lithuania')),
       ('Kaunas', (SELECT country_id FROM country WHERE country_name = 'Lithuania')),
       ('Klaipėda', (SELECT country_id FROM country WHERE country_name = 'Lithuania')),
       ('Šiauliai', (SELECT country_id FROM country WHERE country_name = 'Lithuania')),
       ('Panevėžys', (SELECT country_id FROM country WHERE country_name = 'Lithuania')),

       ('Luxembourg City', (SELECT country_id FROM country WHERE country_name = 'Luxembourg')),
       ('Esch-sur-Alzette', (SELECT country_id FROM country WHERE country_name = 'Luxembourg')),
       ('Dudelange', (SELECT country_id FROM country WHERE country_name = 'Luxembourg')),
       ('Differdange', (SELECT country_id FROM country WHERE country_name = 'Luxembourg')),
       ('Ettelbruck', (SELECT country_id FROM country WHERE country_name = 'Luxembourg')),

       ('Birkirkara', (SELECT country_id FROM country WHERE country_name = 'Malta')),
       ('Mosta', (SELECT country_id FROM country WHERE country_name = 'Malta')),
       ('Qormi', (SELECT country_id FROM country WHERE country_name = 'Malta')),
       ('Żabbar', (SELECT country_id FROM country WHERE country_name = 'Malta')),
       ('Żejtun', (SELECT country_id FROM country WHERE country_name = 'Malta')),

       ('Amsterdam', (SELECT country_id FROM country WHERE country_name = 'Netherlands')),
       ('Rotterdam', (SELECT country_id FROM country WHERE country_name = 'Netherlands')),
       ('The Hague', (SELECT country_id FROM country WHERE country_name = 'Netherlands')),
       ('Utrecht', (SELECT country_id FROM country WHERE country_name = 'Netherlands')),
       ('Eindhoven', (SELECT country_id FROM country WHERE country_name = 'Netherlands')),

       ('Warsaw', (SELECT country_id FROM country WHERE country_name = 'Poland')),
       ('Kraków', (SELECT country_id FROM country WHERE country_name = 'Poland')),
       ('Łódź', (SELECT country_id FROM country WHERE country_name = 'Poland')),
       ('Wrocław', (SELECT country_id FROM country WHERE country_name = 'Poland')),
       ('Poznań', (SELECT country_id FROM country WHERE country_name = 'Poland')),

       ('Lisbon', (SELECT country_id FROM country WHERE country_name = 'Portugal')),
       ('Porto', (SELECT country_id FROM country WHERE country_name = 'Portugal')),
       ('Vila Nova de Gaia', (SELECT country_id FROM country WHERE country_name = 'Portugal')),
       ('Amadora', (SELECT country_id FROM country WHERE country_name = 'Portugal')),
       ('Braga', (SELECT country_id FROM country WHERE country_name = 'Portugal')),

       ('Bucharest', (SELECT country_id FROM country WHERE country_name = 'Romania')),
       ('Cluj-Napoca', (SELECT country_id FROM country WHERE country_name = 'Romania')),
       ('Timișoara', (SELECT country_id FROM country WHERE country_name = 'Romania')),
       ('Iași', (SELECT country_id FROM country WHERE country_name = 'Romania')),
       ('Constanța', (SELECT country_id FROM country WHERE country_name = 'Romania')),

       ('Moscow', (SELECT country_id FROM country WHERE country_name = 'Russia')),
       ('Saint Petersburg', (SELECT country_id FROM country WHERE country_name = 'Russia')),
       ('Novosibirsk', (SELECT country_id FROM country WHERE country_name = 'Russia')),
       ('Yekaterinburg', (SELECT country_id FROM country WHERE country_name = 'Russia')),
       ('Nizhny Novgorod', (SELECT country_id FROM country WHERE country_name = 'Russia')),

       ('Bratislava', (SELECT country_id FROM country WHERE country_name = 'Slovakia')),
       ('Košice', (SELECT country_id FROM country WHERE country_name = 'Slovakia')),
       ('Prešov', (SELECT country_id FROM country WHERE country_name = 'Slovakia')),
       ('Žilina', (SELECT country_id FROM country WHERE country_name = 'Slovakia')),
       ('Nitra', (SELECT country_id FROM country WHERE country_name = 'Slovakia')),

       ('Ljubljana', (SELECT country_id FROM country WHERE country_name = 'Slovenia')),
       ('Maribor', (SELECT country_id FROM country WHERE country_name = 'Slovenia')),
       ('Celje', (SELECT country_id FROM country WHERE country_name = 'Slovenia')),
       ('Kranj', (SELECT country_id FROM country WHERE country_name = 'Slovenia')),
       ('Velenje', (SELECT country_id FROM country WHERE country_name = 'Slovenia')),

       ('Madrid', (SELECT country_id FROM country WHERE country_name = 'Spain')),
       ('Barcelona', (SELECT country_id FROM country WHERE country_name = 'Spain')),
       ('Valencia', (SELECT country_id FROM country WHERE country_name = 'Spain')),
       ('Seville', (SELECT country_id FROM country WHERE country_name = 'Spain')),
       ('Zaragoza', (SELECT country_id FROM country WHERE country_name = 'Spain')),

       ('Stockholm', (SELECT country_id FROM country WHERE country_name = 'Sweden')),
       ('Gothenburg', (SELECT country_id FROM country WHERE country_name = 'Sweden')),
       ('Malmö', (SELECT country_id FROM country WHERE country_name = 'Sweden')),
       ('Uppsala', (SELECT country_id FROM country WHERE country_name = 'Sweden')),
       ('Västerås', (SELECT country_id FROM country WHERE country_name = 'Sweden')),

       ('Kyiv', (SELECT country_id FROM country WHERE country_name = 'Ukraine')),
       ('Kharkiv', (SELECT country_id FROM country WHERE country_name = 'Ukraine')),
       ('Odesa', (SELECT country_id FROM country WHERE country_name = 'Ukraine')),
       ('Dnipro', (SELECT country_id FROM country WHERE country_name = 'Ukraine')),
       ('Lviv', (SELECT country_id FROM country WHERE country_name = 'Ukraine')),

       ('London', (SELECT country_id FROM country WHERE country_name = 'United Kingdom')),
       ('Birmingham', (SELECT country_id FROM country WHERE country_name = 'United Kingdom')),
       ('Glasgow', (SELECT country_id FROM country WHERE country_name = 'United Kingdom')),
       ('Liverpool', (SELECT country_id FROM country WHERE country_name = 'United Kingdom')),
       ('Manchester', (SELECT country_id FROM country WHERE country_name = 'United Kingdom')),

       ('Tashkent', (SELECT country_id FROM country WHERE country_name = 'Uzbekistan')),
       ('Samarkand', (SELECT country_id FROM country WHERE country_name = 'Uzbekistan')),
       ('Namangan', (SELECT country_id FROM country WHERE country_name = 'Uzbekistan')),
       ('Andijan', (SELECT country_id FROM country WHERE country_name = 'Uzbekistan')),
       ('Bukhara', (SELECT country_id FROM country WHERE country_name = 'Uzbekistan'));

INSERT INTO phone_code (code_number, country_id)
VALUES ('+43', (SELECT country_id FROM country WHERE country_name = 'Austria')),
       ('+375', (SELECT country_id FROM country WHERE country_name = 'Belarus')),
       ('+32', (SELECT country_id FROM country WHERE country_name = 'Belgium')),
       ('+359', (SELECT country_id FROM country WHERE country_name = 'Bulgaria')),
       ('+385', (SELECT country_id FROM country WHERE country_name = 'Croatia')),
       ('+357', (SELECT country_id FROM country WHERE country_name = 'Cyprus')),
       ('+420', (SELECT country_id FROM country WHERE country_name = 'Czechia')),
       ('+45', (SELECT country_id FROM country WHERE country_name = 'Denmark')),
       ('+372', (SELECT country_id FROM country WHERE country_name = 'Estonia')),
       ('+358', (SELECT country_id FROM country WHERE country_name = 'Finland')),
       ('+33', (SELECT country_id FROM country WHERE country_name = 'France')),
       ('+49', (SELECT country_id FROM country WHERE country_name = 'Germany')),
       ('+30', (SELECT country_id FROM country WHERE country_name = 'Greece')),
       ('+36', (SELECT country_id FROM country WHERE country_name = 'Hungary')),
       ('+353', (SELECT country_id FROM country WHERE country_name = 'Ireland')),
       ('+39', (SELECT country_id FROM country WHERE country_name = 'Italy')),
       ('+371', (SELECT country_id FROM country WHERE country_name = 'Latvia')),
       ('+370', (SELECT country_id FROM country WHERE country_name = 'Lithuania')),
       ('+352', (SELECT country_id FROM country WHERE country_name = 'Luxembourg')),
       ('+356', (SELECT country_id FROM country WHERE country_name = 'Malta')),
       ('+31', (SELECT country_id FROM country WHERE country_name = 'Netherlands')),
       ('+48', (SELECT country_id FROM country WHERE country_name = 'Poland')),
       ('+351', (SELECT country_id FROM country WHERE country_name = 'Portugal')),
       ('+40', (SELECT country_id FROM country WHERE country_name = 'Romania')),
       ('+7', (SELECT country_id FROM country WHERE country_name = 'Russia')),
       ('+421', (SELECT country_id FROM country WHERE country_name = 'Slovakia')),
       ('+386', (SELECT country_id FROM country WHERE country_name = 'Slovenia')),
       ('+34', (SELECT country_id FROM country WHERE country_name = 'Spain')),
       ('+46', (SELECT country_id FROM country WHERE country_name = 'Sweden')),
       ('+380', (SELECT country_id FROM country WHERE country_name = 'Ukraine')),
       ('+44', (SELECT country_id FROM country WHERE country_name = 'United Kingdom')),
       ('+998', (SELECT country_id FROM country WHERE country_name = 'Uzbekistan'));

INSERT INTO language (language_name)
VALUES ('English'),
       ('Czech'),
       ('Russian'),
       ('German'),
       ('French'),
       ('Spanish'),
       ('Italian'),
       ('Polish'),
       ('Dutch'),
       ('Portuguese'),
       ('Swedish'),
       ('Hungarian'),
       ('Danish'),
       ('Finnish'),
       ('Slovak'),
       ('Slovenian'),
       ('Estonian'),
       ('Latvian'),
       ('Lithuanian'),
       ('Romanian'),
       ('Bulgarian'),
       ('Croatian'),
       ('Greek'),
       ('Irish'),
       ('Maltese'),
       ('Hindi');

INSERT INTO gender (gender_name)
VALUES ('Male'),
       ('Female'),
       ('Non-binary'),
       ('Genderqueer'),
       ('Agender'),
       ('Bigender'),
       ('Genderfluid'),
       ('Transgender Male'),
       ('Transgender Female'),
       ('Two-Spirit'),
       ('Pangender'),
       ('Androgyne'),
       ('Demigender'),
       ('Intergender'),
       ('Neutrois'),
       ('Third Gender'),
       ('Other'),
       ('Prefer not to say');

INSERT INTO animal_type (type_name)
VALUES ('Dog'),
       ('Cat'),
       ('Parrot'),
       ('Hamster'),
       ('Rabbit'),
       ('Fish'),
       ('Reptile'),
       ('Bird'),
       ('Horse'),
       ('Other');

INSERT INTO breed (breed_name, type_id)
VALUES ('Labrador Retriever', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
       ('German Shepherd', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
       ('Bulldog', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
       ('Beagle', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
       ('Poodle', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
       ('Rottweiler', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
       ('Yorkshire Terrier', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
       ('Boxer', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
       ('Dachshund', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
       ('King Charles Spaniel', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),

       ('Persian', (SELECT type_id FROM animal_type WHERE type_name = 'Cat')),
       ('Maine Coon', (SELECT type_id FROM animal_type WHERE type_name = 'Cat')),
       ('Siamese', (SELECT type_id FROM animal_type WHERE type_name = 'Cat')),
       ('British Shorthair', (SELECT type_id FROM animal_type WHERE type_name = 'Cat')),
       ('Sphynx', (SELECT type_id FROM animal_type WHERE type_name = 'Cat')),
       ('Ragdoll', (SELECT type_id FROM animal_type WHERE type_name = 'Cat')),
       ('Bengal', (SELECT type_id FROM animal_type WHERE type_name = 'Cat')),
       ('Russian Blue', (SELECT type_id FROM animal_type WHERE type_name = 'Cat')),
       ('Scottish Fold', (SELECT type_id FROM animal_type WHERE type_name = 'Cat')),
       ('Abyssinian', (SELECT type_id FROM animal_type WHERE type_name = 'Cat')),
       ('Munchkin', (SELECT type_id FROM animal_type WHERE type_name = 'Cat')),
       ('Exotic Shorthair', (SELECT type_id FROM animal_type WHERE type_name = 'Cat')),

       ('African Grey Parrot', (SELECT type_id FROM animal_type WHERE type_name = 'Parrot')),
       ('Budgerigar', (SELECT type_id FROM animal_type WHERE type_name = 'Parrot')),
       ('Cockatiel', (SELECT type_id FROM animal_type WHERE type_name = 'Parrot')),
       ('Macaw', (SELECT type_id FROM animal_type WHERE type_name = 'Parrot')),
       ('Cockatoo', (SELECT type_id FROM animal_type WHERE type_name = 'Parrot')),

       ('Syrian Hamster', (SELECT type_id FROM animal_type WHERE type_name = 'Hamster')),
       ('Dwarf Campbell Russian Hamster', (SELECT type_id FROM animal_type WHERE type_name = 'Hamster')),
       ('Roborovski Dwarf Hamster', (SELECT type_id FROM animal_type WHERE type_name = 'Hamster')),
       ('Chinese Hamster', (SELECT type_id FROM animal_type WHERE type_name = 'Hamster')),
       ('Winter White Russian Dwarf Hamster', (SELECT type_id FROM animal_type WHERE type_name = 'Hamster')),

       ('Goldfish', (SELECT type_id FROM animal_type WHERE type_name = 'Fish')),
       ('Betta', (SELECT type_id FROM animal_type WHERE type_name = 'Fish')),
       ('Guppy', (SELECT type_id FROM animal_type WHERE type_name = 'Fish')),
       ('Angelfish', (SELECT type_id FROM animal_type WHERE type_name = 'Fish')),
       ('Molly', (SELECT type_id FROM animal_type WHERE type_name = 'Fish')),

       ('Leopard Gecko', (SELECT type_id FROM animal_type WHERE type_name = 'Reptile')),
       ('Bearded Dragon', (SELECT type_id FROM animal_type WHERE type_name = 'Reptile')),
       ('Ball Python', (SELECT type_id FROM animal_type WHERE type_name = 'Reptile')),
       ('Corn Snake', (SELECT type_id FROM animal_type WHERE type_name = 'Reptile')),
       ('Red-Eared Slider', (SELECT type_id FROM animal_type WHERE type_name = 'Reptile'));

INSERT INTO user_account (code_id,
                          gender_id,
                          nickname,
                          email,
                          phone_number,
                          date_of_birth,
                          firstname,
                          lastname,
                          account_description,
                          password_hash,
                          salt,
                          created_datetime,
                          is_active)
VALUES ((SELECT code_id FROM phone_code WHERE code_number = '+420'), -- Czechia
        (SELECT gender_id FROM gender WHERE gender_name = 'Female'),
        'mashkerz',
        'marijabatan@gmail.com',
        '773056892',
        '2006-11-05',
        'Marija',
        NULL,
        'Proud mom of kittens and King Charles Spaniels, ready to share joy and help continue their lineage!',
        '3b8e32e8c4ff4a2e3c1541d2c9a4c86a4e6b6a3d8ef6c3db6243f8f5d5d8c9a1',
        'X4xZkPm7Y+2vQ9uLtC3zOg',
        '2024-01-08 04:05:06',
        TRUE),

       ((SELECT code_id FROM phone_code WHERE code_number = '+420'), -- Czechia
        (SELECT gender_id FROM gender WHERE gender_name = 'Female'),
        'margo96',
        'margaret1996@seznam.cz',
        '789635112',
        '1996-06-23',
        'Margaret',
        'Hamadej',
        'I am a professional breeder with a well-established network spanning multiple countries. ' ||
        'Dedicated to ensuring healthy and high-quality litters, I work with a variety of exceptional breeds. ' ||
        'Whether you’re seeking a loyal companion or the perfect match for your pet, ' ||
        'one of my carefully raised dogs is sure to be an ideal candidate for breeding and continuing their outstanding lineage.',
        'a1e2b3c4d5f6789012a3b4c5d6e7f8901a2b3c4d5e6f7890a1b2c3d4e5f6a7b8',
        'R8kYpW5eJ2oLxN9uOm2zRg',
        '2024-01-01 00:11:10',
        TRUE),

       ((SELECT code_id FROM phone_code WHERE code_number = '+420'), -- Czechia
        (SELECT gender_id FROM gender WHERE gender_name = 'Non-binary'),
        'max4ever',
        'maxnomoneyzara@icloud.com',
        '3456789012',
        '2005-11-05',
        'Max',
        NULL,
        NULL,
        'd41d8cd98f00b204e9800998ecf8427eafbf3c3c6f7f8f9a0b1c2d3e4f5a6b7',
        'Q1lXpZ8vT7oKmN5cO3rZPg',
        '2024-03-20 23:30:09',
        TRUE),

       ((SELECT code_id FROM phone_code WHERE code_number = '+33'), -- France
        (SELECT gender_id FROM gender WHERE gender_name = 'Non-binary'),
        'kittens101',
        'macaroninfrance@gmail.com',
        '4567890123',
        '1999-09-12',
        'Chris',
        'Wilson',
        'Built an impressive meme collection, now looking for a partner to co-create a collection of dog memes.',
        'f2ca1bb6c7e907d06dafe4687e579fce2e3b4c5a1d2e3f4b5c6d7e8f9a0b1c2',
        'W7jLpQ2cR5zOnX9vTm3zYg',
        '2024-03-25 00:00:59',
        TRUE),

       ((SELECT code_id FROM phone_code WHERE code_number = '+998'), -- Uzbekistan
        (SELECT gender_id FROM gender WHERE gender_name = 'Prefer not to say'),
        'pat_kim',
        'pat.kim@eoutlook.com',
        '5678901234',
        '1995-03-30',
        'Pat',
        'Kim',
        'My pet is a professional slipper thief. If you have slippers, we’re probably soulmates.',
        '5d41402abc4b2a76b9719d911017c592b8a3c4d5f6e7f8c9d0e1f2a3b4c5d6e7',
        'T4oYpX9vJ2kLZ7cOm1rQg',
        '2024-09-01 05:13:20',
        TRUE),

       ((SELECT code_id FROM phone_code WHERE code_number = '+7'), -- Russia
        (SELECT gender_id FROM gender WHERE gender_name = 'Female'),
        '777katya777',
        'katya.biser@icloud.com',
        '9123456789',
        '2001-05-04',
        'Katya',
        NULL,
        'Instead of music, my cat enjoys listening to aquarium bubbles. Together we’re seeking support.',
        'e99a18c428cb38d5f260853678922e03f5b6a7b8c9d0e1f2b3c4d5e6f7a8b9c0',
        'V3kLpR2cW5zOmX8oJ1nYq',
        '2024-05-06 19:30:23',
        TRUE),

       ((SELECT code_id FROM phone_code WHERE code_number = '+44'), -- United Kingdom
        (SELECT gender_id FROM gender WHERE gender_name = 'Female'),
        'Josef4cats',
        'josja_smith@gmail.com',
        '602123456',
        '1988-08-20',
        'Josef',
        'Smith',
        'I’m the official servant to my dog. Looking for someone to share this noble burden.',
        'c5d9b52ac8dfc9baf3d19e8cfc4a96b2d8b9c0e1f2a3b4c5e6f7f8d0c1e2b3a4',
        'P9xZkW2eT7oLQ3mJ5yOg',
        '2024-10-10 22:19:00',
        TRUE),

       ((SELECT code_id FROM phone_code WHERE code_number = '+34'), -- Spain
        (SELECT gender_id FROM gender WHERE gender_name = 'Female'),
        'sarah_connor',
        'sarah.connor@icloud.com',
        '412345678',
        '1998-02-28',
        'Sarah',
        'Connor',
        'I have a hamster who’s tried to escape twice already. Help me convince him to stay.',
        'f6c3d2e1b0a1c2d3e4f5a6b7c8d9f0e1f2a3b4c5e6f7f8d9e0a1b2c3d4e5f6a7',
        'O1lYpQ9vW7zKnR5cT3mZg',
        '2024-11-01 20:00:59',
        TRUE),

       ((SELECT code_id FROM phone_code WHERE code_number = '+34'), -- Spain
        (SELECT gender_id FROM gender WHERE gender_name = 'Male'),
        'rahul6sharma',
        'rahul.sharma01@icloud.com',
        '9876543210',
        '1993-07-15',
        'Rahul',
        NULL,
        'Bought my cat a toy castle, now I live in her kingdom. Welcome, brave traveler!',
        '74b87337454200d4d33f80c4663dc5e5f2a3c4b5d6e7f8c9d0e1f2a3b4c5d6e7',
        'N8kLpX2cJ5oOmT9rW3zYq',
        '2024-11-10 08:50:03',
        TRUE),

       ((SELECT code_id FROM phone_code WHERE code_number = '+34'), -- Spain
        (SELECT gender_id FROM gender WHERE gender_name = 'Male'),
        'carlos_chivava',
        'carlos.garcia@gmail.com',
        '612345678',
        '2000-12-05',
        'Carlos',
        'Garcia',
        'My dog looks at me like I’m a superstar, and I look at her like she’s a future TikTok star. Wanna help us film?',
        'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3b0c4d6f7a8b9c0e1f2a3c4d5',
        'M4oYpT7vQ2kLZ9cOm1rRg',
        '2024-08-11 10:33:18',
        TRUE);

INSERT INTO user_language (user_id, language_id)
VALUES (1, (SELECT language_id FROM language WHERE language_name = 'English')),
       (1, (SELECT language_id FROM language WHERE language_name = 'Czech')),
       (1, (SELECT language_id FROM language WHERE language_name = 'Russian')),

       (2, (SELECT language_id FROM language WHERE language_name = 'English')),
       (2, (SELECT language_id FROM language WHERE language_name = 'Czech')),

       (3, (SELECT language_id FROM language WHERE language_name = 'English')),
       (3, (SELECT language_id FROM language WHERE language_name = 'German')),

       (4, (SELECT language_id FROM language WHERE language_name = 'English')),
       (4, (SELECT language_id FROM language WHERE language_name = 'French')),

       (6, (SELECT language_id FROM language WHERE language_name = 'Russian')),
       (6, (SELECT language_id FROM language WHERE language_name = 'English')),

       (7, (SELECT language_id FROM language WHERE language_name = 'English')),

       (8, (SELECT language_id FROM language WHERE language_name = 'English')),
       (8, (SELECT language_id FROM language WHERE language_name = 'Spanish')),

       (10, (SELECT language_id FROM language WHERE language_name = 'English')),
       (10, (SELECT language_id FROM language WHERE language_name = 'Hindi'));

INSERT INTO pet_profile (gender_id, city_id, breed_id, type_id, user_id, pet_name, date_of_birth, price,
                         certification_url, profile_description, purebred_percantage, created_datetime)
VALUES ((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Masha
        (SELECT city_id FROM City WHERE city_name = 'Prague'),
        (SELECT breed_id FROM breed WHERE breed_name = 'King Charles Spaniel'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        1, 'Snusicha', '2022-04-05', 5000, NULL,
        'Meet Snusicha, a stunning King Charles Spaniel with a charming personality and impeccable lineage. ' ||
        'Playful yet calm, Snusicha adores cuddles, long walks, and, of course, being the center of attention. ' ||
        'If you’re looking for a top-quality companion for breeding, Snusicha is ready to meet her match! 🐾 ' ||
        'Feel free to contact me for further details or to arrange a meet-up. Let’s make some adorable King Charles Spaniel puppies together! 🐶✨',
        100, '2024-01-08 06:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Masha
        (SELECT city_id FROM City WHERE city_name = 'Prague'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Ragdoll'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Cat'),
        1, 'Tulupchik', '2021-04-12', 1300, NULL,
        'Tulupchik is my fluffy little gentleman with the softest fur and the sweetest personality. ' ||
        'He loves lounging in sunny spots and following me around the house for cuddles. ' ||
        'If you’re looking for a calm and affectionate companion, Tulupchik is the one!', 100, '2024-02-09 11:30:12'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Masha
        (SELECT city_id FROM City WHERE city_name = 'Prague'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Munchkin'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Cat'),
        1, 'Kozjavka', '2022-02-05', 1250, NULL,
        'Meet Kozjavka, my little adventurer with the tiniest legs and the biggest heart. ' ||
        'He’s playful, curious, and always up for exploring new corners of the house. ' ||
        'A perfect companion for someone who loves a quirky and lovable pet!', 100, '2024-02-09 11:02:30'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Masha
        (SELECT city_id FROM City WHERE city_name = 'Prague'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Maine Coon'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Cat'),
        1, 'Bobik', '2020-01-25', 1400, NULL,
        'Bobik is my majestic Maine Coon with a luxurious coat and an even more luxurious personality. ' ||
        'He’s a friendly giant who loves attention and will greet you with a happy meow every time you walk in. ' ||
        'Perfect for someone who wants a loving, regal companion!', 100, '2024-02-08 07:30:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Masha
        (SELECT city_id FROM City WHERE city_name = 'Prague'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Exotic Shorthair'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Cat'),
        1, 'Ajkosik', '2020-01-25', 1000, NULL,
        'Ajkosik is my charming Exotic Shorthair with the cutest squishy face and a heart full of love. ' ||
        'He’s calm, affectionate, and loves to curl up beside you for a cozy nap. ' ||
        'If you’re looking for a sweet and easygoing companion, Ajkosik is ready to meet you!', 100,
        '2024-02-08 07:30:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Margo
        (SELECT city_id FROM City WHERE city_name = 'Prague'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Labrador Retriever'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        2, 'Pusicka', '2021-06-15', 1000, NULL,
        'Pusicka is a playful and loyal companion, perfect for breeding. Gentle, friendly, and full of energy.', 90,
        '2024-01-01 12:11:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Margo
        (SELECT city_id FROM City WHERE city_name = 'Manchester'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Labrador Retriever'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        2,
        'Skibidi',
        '2021-02-20',
        1700,
        NULL,
        'A friendly Labrador Retriever who loves kids and outdoor activities.',
        100,
        '2024-01-01 03:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Margo
        (SELECT city_id FROM City WHERE city_name = 'London'),
        (SELECT breed_id FROM breed WHERE breed_name = 'German Shepherd'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        2, 'Tuz', '2020-11-25', 2300, NULL,
        'Tuz is a strong and intelligent German Shepherd ready to sire amazing puppies. Loyal and confident.', 100,
        '2024-01-02 11:11:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Margo
        (SELECT city_id FROM City WHERE city_name = 'Sofia'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Bulldog'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        2, 'Dusnilka', '2021-08-30', 900, NULL,
        'Dusnilka is a loving and calm Bulldog with great temperament. Perfect choice for breeding Bulldogs.', 80,
        '2024-01-02 11:20:10'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Margo
        (SELECT city_id FROM City WHERE city_name = 'Prague'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Beagle'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        2, 'Sigma', '2021-02-26', 1000, NULL,
        'Sigma is a curious and cheerful Beagle. A great partner for playful and healthy puppies.', 90,
        '2024-01-03 22:01:30'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Margo
        (SELECT city_id FROM City WHERE city_name = 'Grodno'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Poodle'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        2, 'Archi', '2021-04-05', 1000, NULL,
        'Archi is an elegant and intelligent Poodle. Ideal for anyone looking to breed a charming companion.', 90,
        '2024-01-03 09:12:11'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Margo
        (SELECT city_id FROM City WHERE city_name = 'Grodno'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Rottweiler'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        2, 'Vorona', '2022-01-18', 1000, NULL,
        'Vorona is a bold and powerful Rottweiler. Loyal, confident, and perfect for strong, healthy litters.', 90,
        '2024-04-01 02:11:59'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Margo
        (SELECT city_id FROM City WHERE city_name = 'Brno'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Yorkshire Terrier'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        2, 'Krikacka', '2022-07-12', 1000, NULL,
        'Krikacka is a lively and affectionate Yorkie. Perfect for breeding tiny bundles of joy.', 90,
        '2024-02-09 07:33:22'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Margo
        (SELECT city_id FROM City WHERE city_name = 'Brno'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Boxer'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        2, 'Chempion', '2021-05-20', 1000, NULL,
        'Chempion is an athletic and energetic Boxer with a loving nature. Ready to pass on his champion traits.', 90,
        '2024-02-08 07:30:10'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Margo
        (SELECT city_id FROM City WHERE city_name = 'Liberec'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Dachshund'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        2, 'Flex', '2021-10-01', 1000, NULL,
        'Flex is a spirited and clever Dachshund. Great for breeding playful and loyal pups.', 90,
        '2024-10-11 05:59:59'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Margo
        (SELECT city_id FROM City WHERE city_name = 'Prague'),
        (SELECT breed_id FROM breed WHERE breed_name = 'King Charles Spaniel'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        2, 'Chasecka', '2022-04-15', 2500, NULL,
        'Chasecka is a charming and affectionate King Charles Spaniel. A wonderful choice for breeding regal companions.',
        100, '2024-11-01 08:23:02'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Max
        (SELECT city_id FROM City WHERE city_name = 'Birmingham'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Goldfish'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Fish'),
        3,
        'Goldie',
        '2023-03-15',
        350,
        NULL,
        'A vibrant male goldfish looking for a mate.',
        100,
        '2024-03-21 11:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Max
        (SELECT city_id FROM City WHERE city_name = 'Birmingham'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Syrian Hamster'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Hamster'),
        3,
        'Chewy',
        '2023-04-15',
        35,
        NULL,
        'A curious male Syrian hamster looking for a mate.',
        NULL,
        '2024-03-21 12:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Chris Wilson
        (SELECT city_id FROM City WHERE city_name = 'Paris'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Siamese'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Cat'),
        4,
        'Murzik',
        '2021-03-22',
        1200,
        NULL,
        'A graceful Siamese cat with striking blue eyes and a curious nature.',
        100,
        '2024-03-25 08:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Chris Wilson
        (SELECT city_id FROM City WHERE city_name = 'Saint Petersburg'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Scottish Fold'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Cat'),
        4,
        'Cleopatra',
        '2019-05-25',
        1300,
        NULL,
        'A beautiful Scottish Fold with a gentle nature.',
        100,
        '2024-03-25 09:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Chris Wilson
        (SELECT city_id FROM City WHERE city_name = 'Paris'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Persian'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Cat'),
        4,
        'Simba',
        '2020-06-10',
        1600,
        NULL,
        'A majestic male Persian cat with a luxurious coat. Seeking a female Persian for breeding.',
        100,
        '2024-03-25 12:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Pat Kim
        (SELECT city_id FROM City WHERE city_name = 'Tashkent'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Syrian Hamster'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Hamster'),
        5,
        'Nibbles',
        '2023-05-10',
        30,
        NULL,
        'An energetic Syrian hamster who loves exploring and storing food.',
        NULL,
        '2024-09-01 06:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Pat Kim
        (SELECT city_id FROM City WHERE city_name = 'Tashkent'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Goldfish'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Fish'),
        5,
        'Nesushka',
        '2023-02-11',
        300,
        NULL,
        'Radiant goldfish ready for elegant and quality breeding.',
        100,
        '2024-09-01 07:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Katya
        (SELECT city_id FROM City WHERE city_name = 'Moscow'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Scottish Fold'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Cat'),
        6,
        'Baron',
        '2021-12-01',
        1100,
        NULL,
        'A playful Scottish Fold with adorable folded ears and a loving demeanor.',
        100,
        '2024-05-07 08:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Katya
        (SELECT city_id FROM City WHERE city_name = 'Liverpool'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Beagle'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        6,
        'Bella',
        '2021-11-05',
        1800,
        NULL,
        'A cheerful Beagle with a loving nature.',
        100,
        '2024-05-07 09:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Josef Smith
        (SELECT city_id FROM City WHERE city_name = 'London'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Labrador Retriever'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        7,
        'PiDidi',
        '2020-11-11',
        1800,
        NULL,
        'An enthusiastic Labrador Retriever who loves playing fetch and swimming.',
        100,
        '2024-10-11 09:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Josef Smith
        (SELECT city_id FROM City WHERE city_name = 'London'),
        (SELECT breed_id FROM breed WHERE breed_name = 'German Shepherd'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        7,
        'Rizzler',
        '2020-02-20',
        2200,
        NULL,
        'A strong and intelligent German Shepherd ready to sire amazing puppies.',
        100,
        '2024-10-11 10:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Sarah Connor
        (SELECT city_id FROM City WHERE city_name = 'Madrid'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Budgerigar'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Parrot'),
        8,
        'Kesha',
        '2022-07-05',
        50,
        NULL,
        'A vibrant Budgerigar with beautiful plumage and a cheerful song.',
        NULL,
        '2024-11-02 08:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Sarah Connor
        (SELECT city_id FROM City WHERE city_name = 'Seville'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Roborovski Dwarf Hamster'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Hamster'),
        8,
        'Oparysh',
        '2023-01-10',
        40,
        NULL,
        'A lively Roborovski Hamster who loves running on her wheel.',
        NULL,
        '2024-11-02 09:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Male'), -- Rahul
        (SELECT city_id FROM City WHERE city_name = 'Varna'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Labrador Retriever'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
        9,
        'Cherchil',
        '2020-11-11',
        1800,
        NULL,
        'An enthusiastic Labrador Retriever who loves playing fetch and swimming. Looking for a breeding partner.',
        100,
        '2024-11-10 09:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Rahul
        (SELECT city_id FROM City WHERE city_name = 'Zagreb'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Persian'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Cat'),
        9,
        'Zoja',
        '2021-05-20',
        1500,
        NULL,
        'A beautiful Persian cat with a luxurious coat. Looking for a male companion for breeding.',
        100,
        '2024-11-10 10:00:00'),

       ((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Rahul
        (SELECT city_id FROM City WHERE city_name = 'Varna'),
        (SELECT breed_id FROM breed WHERE breed_name = 'Goldfish'),
        (SELECT type_id FROM animal_type WHERE type_name = 'Fish'),
        9,
        'Akulina',
        '2023-03-15',
        300,
        NULL,
        'A radiant goldfish ready for quality breeding.',
        100,
        '2024-11-10 11:00:00');

INSERT INTO photo_data (profile_id, user_id, added_datetime, is_active, photo_url)
VALUES
-- User photos
(NULL, 1, '2024-01-08 10:00:00', true, 'https://example.com/photos/users/masha_1_profile.jpg'),
(NULL, 2, '2024-01-02 10:00:00', true, 'https://example.com/photos/users/margo_2_profile.jpg'),
(NULL, 3, '2024-03-22 10:00:00', true, 'https://example.com/photos/users/max_3_profile.jpg'),
(NULL, 4, '2024-03-26 10:00:00', true, 'https://example.com/photos/users/chris_wilson_4_profile.jpg'),
(NULL, 6, '2024-05-08 10:00:00', true, 'https://example.com/photos/users/katya_6_profile.jpg'),
(NULL, 7, '2024-10-12 10:00:00', true, 'https://example.com/photos/users/josef_smith_7_profile.jpg'),
(NULL, 8, '2024-11-03 10:00:00', true, 'https://example.com/photos/users/sarah_connor_8_profile.jpg'),
(NULL, 9, '2024-11-11 10:00:00', true, 'https://example.com/photos/users/rahul_9_profile.jpg'),

-- Pet photos
(1, NULL, '2024-01-08 11:00:00', true, 'https://example.com/photos/pets/Snusicha_user1_photo1.jpg'),
(1, NULL, '2024-01-08 11:05:00', true, 'https://example.com/photos/pets/Snusicha_user1_photo2.jpg'),
(1, NULL, '2024-01-08 11:10:00', true, 'https://example.com/photos/pets/Snusicha_user1_photo3.jpg'),
(1, NULL, '2024-01-08 11:15:00', true, 'https://example.com/photos/pets/Snusicha_user1_photo4.jpg'),
(1, NULL, '2024-01-08 11:20:00', true, 'https://example.com/photos/pets/Snusicha_user1_photo5.jpg'),

(2, NULL, '2024-02-09 12:00:00', true, 'https://example.com/photos/pets/Tulupchik_user1_photo1.jpg'),
(2, NULL, '2024-02-09 12:05:00', true, 'https://example.com/photos/pets/Tulupchik_user1_photo2.jpg'),
(2, NULL, '2024-02-09 12:10:00', true, 'https://example.com/photos/pets/Tulupchik_user1_photo3.jpg'),

(3, NULL, '2024-02-09 12:15:00', true, 'https://example.com/photos/pets/Kozjavka_user1_photo1.jpg'),
(3, NULL, '2024-02-09 12:20:00', true, 'https://example.com/photos/pets/Kozjavka_user1_photo2.jpg'),
(3, NULL, '2024-02-09 12:25:00', true, 'https://example.com/photos/pets/Kozjavka_user1_photo3.jpg'),
(3, NULL, '2024-02-09 12:30:00', true, 'https://example.com/photos/pets/Kozjavka_user1_photo4.jpg'),

(4, NULL, '2024-02-08 08:00:00', true, 'https://example.com/photos/pets/Bobik_user1_photo1.jpg'),
(4, NULL, '2024-02-08 08:05:00', true, 'https://example.com/photos/pets/Bobik_user1_photo2.jpg'),

(5, NULL, '2024-02-08 08:10:00', true, 'https://example.com/photos/pets/Ajkosik_user1_photo1.jpg'),
(5, NULL, '2024-02-08 08:15:00', true, 'https://example.com/photos/pets/Ajkosik_user1_photo2.jpg'),
(5, NULL, '2024-02-08 08:20:00', true, 'https://example.com/photos/pets/Ajkosik_user1_photo3.jpg'),

(6, NULL, '2024-01-02 12:30:00', true, 'https://example.com/photos/pets/Pusicka_user2_photo1.jpg'),
(6, NULL, '2024-01-02 12:35:00', true, 'https://example.com/photos/pets/Pusicka_user2_photo2.jpg'),
(6, NULL, '2024-01-02 12:40:00', true, 'https://example.com/photos/pets/Pusicka_user2_photo3.jpg'),

(7, NULL, '2024-01-02 13:00:00', true, 'https://example.com/photos/pets/Skibidi_user2_photo1.jpg'),
(7, NULL, '2024-01-02 13:05:00', true, 'https://example.com/photos/pets/Skibidi_user2_photo2.jpg'),

(8, NULL, '2024-01-02 13:10:00', true, 'https://example.com/photos/pets/Tuz_user2_photo1.jpg'),
(8, NULL, '2024-01-02 13:15:00', true, 'https://example.com/photos/pets/Tuz_user2_photo2.jpg'),
(8, NULL, '2024-01-02 13:20:00', true, 'https://example.com/photos/pets/Tuz_user2_photo3.jpg'),

(9, NULL, '2024-01-02 13:25:00', true, 'https://example.com/photos/pets/Dusnilka_user2_photo1.jpg'),
(9, NULL, '2024-01-02 13:30:00', true, 'https://example.com/photos/pets/Dusnilka_user2_photo2.jpg'),

(10, NULL, '2024-01-03 23:00:00', true, 'https://example.com/photos/pets/Sigma_user2_photo1.jpg'),
(10, NULL, '2024-01-03 23:05:00', true, 'https://example.com/photos/pets/Sigma_user2_photo2.jpg'),
(10, NULL, '2024-01-03 23:10:00', true, 'https://example.com/photos/pets/Sigma_user2_photo3.jpg'),

(11, NULL, '2024-01-03 10:00:00', true, 'https://example.com/photos/pets/Archi_user2_photo1.jpg'),
(11, NULL, '2024-01-03 10:05:00', true, 'https://example.com/photos/pets/Archi_user2_photo2.jpg'),

(12, NULL, '2024-04-01 03:00:00', true, 'https://example.com/photos/pets/Vorona_user2_photo1.jpg'),
(12, NULL, '2024-04-01 03:05:00', true, 'https://example.com/photos/pets/Vorona_user2_photo2.jpg'),
(12, NULL, '2024-04-01 03:10:00', true, 'https://example.com/photos/pets/Vorona_user2_photo3.jpg'),

(13, NULL, '2024-02-09 08:00:00', true, 'https://example.com/photos/pets/Krikacka_user2_photo1.jpg'),
(13, NULL, '2024-02-09 08:05:00', true, 'https://example.com/photos/pets/Krikacka_user2_photo2.jpg'),

(14, NULL, '2024-02-08 08:30:00', true, 'https://example.com/photos/pets/Chempion_user2_photo1.jpg'),
(14, NULL, '2024-02-08 08:35:00', true, 'https://example.com/photos/pets/Chempion_user2_photo2.jpg'),
(14, NULL, '2024-02-08 08:40:00', true, 'https://example.com/photos/pets/Chempion_user2_photo3.jpg'),

(15, NULL, '2024-10-11 06:00:00', true, 'https://example.com/photos/pets/Flex_user2_photo1.jpg'),
(15, NULL, '2024-10-11 06:05:00', true, 'https://example.com/photos/pets/Flex_user2_photo2.jpg'),

(16, NULL, '2024-11-01 09:00:00', true, 'https://example.com/photos/pets/Chasecka_user2_photo1.jpg'),
(16, NULL, '2024-11-01 09:05:00', true, 'https://example.com/photos/pets/Chasecka_user2_photo2.jpg'),
(16, NULL, '2024-11-01 09:10:00', true, 'https://example.com/photos/pets/Chasecka_user2_photo3.jpg'),

(17, NULL, '2024-03-22 11:00:00', true, 'https://example.com/photos/pets/Goldie_user3_photo1.jpg'),
(17, NULL, '2024-03-22 11:05:00', true, 'https://example.com/photos/pets/Goldie_user3_photo2.jpg'),

(18, NULL, '2024-03-22 12:00:00', true, 'https://example.com/photos/pets/Chewy_user3_photo1.jpg'),
(18, NULL, '2024-03-22 12:05:00', true, 'https://example.com/photos/pets/Chewy_user3_photo2.jpg'),
(18, NULL, '2024-03-22 12:10:00', true, 'https://example.com/photos/pets/Chewy_user3_photo3.jpg'),

(19, NULL, '2024-03-26 09:00:00', true, 'https://example.com/photos/pets/Murzik_user4_photo1.jpg'),
(19, NULL, '2024-03-26 09:05:00', true, 'https://example.com/photos/pets/Murzik_user4_photo2.jpg'),
(19, NULL, '2024-03-26 09:10:00', true, 'https://example.com/photos/pets/Murzik_user4_photo3.jpg'),

(20, NULL, '2024-03-26 09:15:00', true, 'https://example.com/photos/pets/Cleo_user4_photo1.jpg'),
(20, NULL, '2024-03-26 09:20:00', true, 'https://example.com/photos/pets/Cleo_user4_photo2.jpg'),

(21, NULL, '2024-03-26 12:30:00', true, 'https://example.com/photos/pets/Simba_user4_photo1.jpg'),
(21, NULL, '2024-03-26 12:35:00', true, 'https://example.com/photos/pets/Simba_user4_photo2.jpg'),
(21, NULL, '2024-03-26 12:40:00', true, 'https://example.com/photos/pets/Simba_user4_photo3.jpg'),

(22, NULL, '2024-09-01 06:30:00', true, 'https://example.com/photos/pets/Nibbles_user5_photo1.jpg'),
(22, NULL, '2024-09-01 06:35:00', true, 'https://example.com/photos/pets/Nibbles_user5_photo2.jpg'),

(23, NULL, '2024-09-01 07:30:00', true, 'https://example.com/photos/pets/Nesushka_user5_photo1.jpg'),
(23, NULL, '2024-09-01 07:35:00', true, 'https://example.com/photos/pets/Nesushka_user5_photo2.jpg'),

(24, NULL, '2024-05-07 09:00:00', true, 'https://example.com/photos/pets/Whiskers_user6_photo1.jpg'),
(24, NULL, '2024-05-07 09:05:00', true, 'https://example.com/photos/pets/Whiskers_user6_photo2.jpg'),
(24, NULL, '2024-05-07 09:10:00', true, 'https://example.com/photos/pets/Whiskers_user6_photo3.jpg'),

(25, NULL, '2024-05-07 10:00:00', true, 'https://example.com/photos/pets/Bella_Beagle_user6_photo1.jpg'),
(25, NULL, '2024-05-07 10:05:00', true, 'https://example.com/photos/pets/Bella_Beagle_user6_photo2.jpg'),

(26, NULL, '2024-10-12 11:00:00', true, 'https://example.com/photos/pets/Buddy_user7_photo1.jpg'),
(26, NULL, '2024-10-12 11:05:00', true, 'https://example.com/photos/pets/Buddy_user7_photo2.jpg'),
(26, NULL, '2024-10-12 11:10:00', true, 'https://example.com/photos/pets/Buddy_user7_photo3.jpg'),

(27, NULL, '2024-10-12 12:00:00', true, 'https://example.com/photos/pets/Max_GS_user7_photo1.jpg'),
(27, NULL, '2024-10-12 12:05:00', true, 'https://example.com/photos/pets/Max_GS_user7_photo2.jpg'),

(28, NULL, '2024-11-02 08:30:00', true, 'https://example.com/photos/pets/Sky_user8_photo1.jpg'),
(28, NULL, '2024-11-02 08:35:00', true, 'https://example.com/photos/pets/Sky_user8_photo2.jpg'),

(29, NULL, '2024-11-02 09:30:00', true, 'https://example.com/photos/pets/Daisy_Hamster_user8_photo1.jpg'),
(29, NULL, '2024-11-02 09:35:00', true, 'https://example.com/photos/pets/Daisy_Hamster_user8_photo2.jpg'),

(30, NULL, '2024-11-10 09:30:00', true, 'https://example.com/photos/pets/Max_Lab_user9_photo1.jpg'),
(30, NULL, '2024-11-10 09:35:00', true, 'https://example.com/photos/pets/Max_Lab_user9_photo2.jpg'),
(30, NULL, '2024-11-10 09:40:00', true, 'https://example.com/photos/pets/Max_Lab_user9_photo3.jpg'),

(31, NULL, '2024-11-10 10:30:00', true, 'https://example.com/photos/pets/Bella_Persian_user9_photo1.jpg'),
(31, NULL, '2024-11-10 10:35:00', true, 'https://example.com/photos/pets/Bella_Persian_user9_photo2.jpg'),

(32, NULL, '2024-11-10 11:30:00', true, 'https://example.com/photos/pets/Goldie_user9_photo1.jpg'),
(32, NULL, '2024-11-10 11:35:00', true, 'https://example.com/photos/pets/Goldie_user9_photo2.jpg');

INSERT INTO pet_preference (profile_id, min_age, max_age, min_price, max_price, min_purebred_precentage,
                            max_purebred_precentage, has_certification_uploaded)
VALUES
-- Snusicha
(1, 2, 6, 2000, 3000, 100, 100, NULL),
-- Chasecka
(16, 1, 3, 4000, 6000, 100, NULL, NULL),
-- Pusicka
(6, 3, 4, 1500, 2000, 100, NULL, NULL),
-- PiDidi
(26, 2, 4, 800, 1500, 90, NULL, NULL),
-- Cleopatra
(20, 1, 6, 1000, 1200, 100, NULL, NULL),
-- Baron
(24, 4, 7, 1200, 1400, NULL, NULL, NULL),
-- Goldie
(17, 1, 4, 200, 400, NULL, NULL, NULL),
-- Nesushka
(23, 1, 4, 300, 400, NULL, NULL, NULL),
-- Nibbles
(22, 1, 4, 30, 50, NULL, NULL, NULL),
-- Chewy
(18, 2, 4, 25, 40, NULL, NULL, NULL),
-- Zoja
(31, 4, 6, 1500, 1700, NULL, NULL, NULL),
-- Simba
(21, 3, 4, 1400, 1600, NULL, NULL, NULL),
-- Tulupchik
(2, 1, NULL, NULL, NULL, NULL, NULL, NULL),
-- Kozjavka
(3, NULL, NULL, 1000, 1500, NULL, NULL, NULL),
-- Bobik
(4, NULL, NULL, NULL, NULL, 90, NULL, NULL),
-- Skibidi
(7, NULL, 6, NULL, NULL, NULL, NULL, NULL);

INSERT INTO country_preference (country_id, preference_id)
VALUES
-- Snusicha
((SELECT country_id FROM country WHERE country_name = 'Czechia'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 1)),
-- Chasecka
((SELECT country_id FROM country WHERE country_name = 'Czechia'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 16)),
-- Pusicka
((SELECT country_id FROM country WHERE country_name = 'United Kingdom'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 6)),
-- PiDidi
((SELECT country_id FROM country WHERE country_name = 'Czechia'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 26)),
-- Cleopatra
((SELECT country_id FROM country WHERE country_name = 'Russia'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 20)),
-- Baron
((SELECT country_id FROM country WHERE country_name = 'Russia'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 24)),
-- Goldie
((SELECT country_id FROM country WHERE country_name = 'Uzbekistan'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 17)),
-- Nesushka
((SELECT country_id FROM country WHERE country_name = 'United Kingdom'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 23)),
-- Nibbles
((SELECT country_id FROM country WHERE country_name = 'United Kingdom'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 22)),
-- Chewy
((SELECT country_id FROM country WHERE country_name = 'Uzbekistan'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 18)),
-- Zoja
((SELECT country_id FROM country WHERE country_name = 'France'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 31)),
-- Simba
((SELECT country_id FROM country WHERE country_name = 'Croatia'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 21));

INSERT INTO city_preference (city_id, preference_id)
VALUES
-- Snusicha
((SELECT city_id FROM city WHERE city_name = 'Prague'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 1)),
-- Chasecka
((SELECT city_id FROM city WHERE city_name = 'Prague'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 16)),
-- Pusicka
((SELECT city_id FROM city WHERE city_name = 'London'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 6)),
-- PiDidi
((SELECT city_id FROM city WHERE city_name = 'Prague'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 26)),
-- Cleopatra
((SELECT city_id FROM city WHERE city_name = 'Moscow'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 20)),
-- Baron
((SELECT city_id FROM city WHERE city_name = 'Saint Petersburg'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 24)),
-- Goldie
((SELECT city_id FROM city WHERE city_name = 'Tashkent'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 17)),
-- Nesushka
((SELECT city_id FROM city WHERE city_name = 'Birmingham'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 23)),
-- Nibbles
((SELECT city_id FROM city WHERE city_name = 'Birmingham'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 22)),
-- Chewy
((SELECT city_id FROM city WHERE city_name = 'Tashkent'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 18)),
-- Zoja
((SELECT city_id FROM city WHERE city_name = 'Paris'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 31)),
-- Simba
((SELECT city_id FROM city WHERE city_name = 'Zagreb'),
 (SELECT preference_id FROM pet_preference WHERE profile_id = 21));

INSERT INTO pet_like (profile_initiator_id, profile_target_id, created_datetime)
-- 1. Mutual likes: Snusicha (user_id = 1) and Chasecka (user_id = 2)
VALUES (1, 16, '2024-01-08 09:30:12'),
       (16, 1, '2024-01-10 04:01:01'),
-- 2. Mutual likes: Pusicka (user_id = 2) and PiDidi (user_id = 7)
       (6, 26, '2024-01-01 06:00:00'),
       (26, 6, '2024-10-11 11:00:00'),
-- 3. Mutual likes: Skibidi (user_id = 2) and PiDidi (user_id = 7)
       (7, 26, '2024-01-01 07:00:00'),
       (26, 7, '2024-10-11 12:00:00'),
-- 4. Mutual likes: Cleopatra (user_id = 4) and Baron (user_id = 6)
       (20, 24, '2024-03-25 10:00:00'),
       (24, 20, '2024-05-07 10:00:00'),
-- 5. Mutual likes: Goldie (user_id = 3) and Nesushka (user_id = 5)
       (17, 23, '2024-03-21 14:00:00'),
       (23, 17, '2024-09-01 08:00:00'),
-- 6. Mutual likes: Nibbles (user_id = 5) and Chewy (user_id = 3)
       (22, 18, '2024-09-01 09:00:00'),
       (18, 22, '2024-03-21 15:00:00'),
-- 7. Mutual likes: Zoja (user_id = 9) and Simba (user_id = 4)
       (31, 21, '2024-11-10 12:00:00'),
       (21, 31, '2024-03-25 13:00:00'),

-- Non-mutual likes
-- 1. Cherchil (user_id = 9) liked Skibidi (user_id = 2), but Skibidi did not like Cherchil
       (30, 7, '2024-11-10 13:10:00'),
-- 2. Tulupchik (user_id = 1) liked Murzik (user_id = 4), but Murzik did not like Tulupchik
       (2, 19, '2024-02-10 08:00:00'),
-- 3. Chewy (user_id = 3) liked Oparysh (user_id = 8), but Oparysh did not like Chewy
       (18, 29, '2024-03-21 16:00:00'),
-- 4. Akulina (user_id = 9) liked Goldie (user_id = 3), but Goldie (user_id = 3) did not like Akulina (user_id = 9)
       (32, 17, '2024-11-10 14:10:00'),
-- 5. Baron (user_id = 6) liked Murzik (user_id = 4), but Murzik did not like Baron
       (24, 19, '2024-05-07 11:00:00');

-- Snusicha и Chasecka
INSERT INTO message (conversation_id, profile_id, content, sent_datetime)
VALUES (1, 1, 'Hi, Chasecka! Nice to meet you. 🐾', '2024-01-08 10:05:00'),
       (1, 16, 'Hi, Snusicha! Nice to meet you. How are you doing?', '2024-01-08 10:07:00'),
       (1, 1, 'Everything is perfect! Enjoying a sunny day in Prague. Do you like to walk in the park?', '2024-01-08 10:10:00'),
       (1, 16, 'Of course! The park is my favourite place. Maybe we could meet there sometime?', '2024-01-08 10:12:00');

-- Pusicka и PiDidi
INSERT INTO message (conversation_id, profile_id, content, sent_datetime)
VALUES (2, 6, 'Hi PiDidi! Your photos are just wonderful! 🐶', '2024-01-01 06:15:00'),
       (2, 26, 'Thanks, Pusicka! You look great too. Are you from London?', '2024-01-01 06:17:00'),
       (2, 6, 'No, Im from Prague, but sometimes Im in London. It would be great to play together!', '2024-01-01 06:20:00'),
       (2, 26, 'Sounds great! Let me know when you re in town.', '2024-01-01 06:22:00');

-- Skibidi и PiDidi
INSERT INTO message (conversation_id, profile_id, content, sent_datetime)
VALUES (3, 7, 'Hi PiDidi! Nice to meet another labrador!', '2024-01-01 07:15:00'),
       (3, 26, 'Hi, Skibidi! Likewise. What do you do in your spare time?', '2024-01-01 07:17:00'),
       (3, 7, 'I like long walks and splashing in the water. What about you?', '2024-01-01 07:20:00'),
       (3, 26, 'Same thing! Maybe we could go for a walk together sometime.', '2024-01-01 07:22:00');

-- Cleopatra и Baron
INSERT INTO message (conversation_id, profile_id, content, sent_datetime)
VALUES (4, 20, 'Hello Baron! Your profile caught my attention.', '2024-05-07 10:15:00'),
       (4, 24, 'Hi, Cleopatra! Thank you. You are an amazing Scottish lop.', '2024-05-07 10:17:00'),
       (4, 20, 'You are very kind! Shall we share stories over a bowl of milk?', '2024-05-07 10:20:00'),
       (4, 24, 'Id love to. Lets make an appointment.', '2024-05-07 10:22:00');

-- Goldie и Nesushka
INSERT INTO message (conversation_id, profile_id, content, sent_datetime)
VALUES (5, 17, 'Hi, Nesushka! How is your swim today?', '2024-03-21 14:15:00'),
       (5, 23, 'Hey, Goldie! Yeah, enjoying the water. How about you?', '2024-03-21 14:17:00'),
       (5, 17, 'Ditto! It is a great day for swimming. Maybe we could swim together sometime.', '2024-03-21 14:20:00'),
       (5, 23, 'Id love to! Lets plan it.', '2024-03-21 14:22:00');

-- Nibbles и Chewy
INSERT INTO message (conversation_id, profile_id, content, sent_datetime)
VALUES (6, 22, 'Hey, Chewy! I hear you like to explore!', '2024-09-01 09:15:00'),
       (6, 18, 'Hi, Nibbles! Yes, love finding new places to stock up!', '2024-09-01 09:17:00'),
       (6, 22, 'Me too! Maybe we can share some tips?', '2024-09-01 09:20:00'),
       (6, 18, 'That a great idea! Lets talk about it.', '2024-09-01 09:22:00');

-- Zoja и Simba
INSERT INTO message (conversation_id, profile_id, content, sent_datetime)
VALUES (7, 31, 'Hi, Simba! You have such a majestic look!', '2024-11-10 12:15:00'),
       (7, 21, 'Hi Zoja! Thank you, you are very elegant too.', '2024-11-10 12:17:00'),
       (7, 31, 'I would like to meet someday.', '2024-11-10 12:20:00'),
       (7, 21, 'Id love to. Let''s find a good time.', '2024-11-10 12:22:00');

INSERT INTO user_grade (user_giver_id, user_receiver_id, grade, graded_datetime, content)
VALUES
-- User 1 (Masha) rates User 2 (Margo)
(1, 2, 10, '2024-02-15 10:00:00', 'Excellent experience! Very friendly and communicative.'),
-- User 2 (Margo) rates User 1 (Masha)
(2, 1, 10, '2024-02-16 11:00:00', 'Wonderful collaboration. Highly recommend!'),
-- User 3 (Max) rates User 4 (Chris Wilson)
(3, 4, 8, '2024-03-20 14:30:00', 'Good experience, but there are some minor issues.'),
-- User 4 (Chris Wilson) rates User 3 (Max)
(4, 3, 8, '2024-03-21 15:00:00', 'Everything went smoothly, recommend.'),
-- User 6 (Katya) rates User 7 (Joseph Smith)
(6, 7, 6, '2024-04-10 09:00:00', 'Average experience; communication could be better.'),
-- User 7 (Joseph Smith) rates User 6 (Katya)
(7, 6, 7, '2024-04-11 10:30:00', 'Good interaction, thank you.'),
-- User 8 (Sarah Connor) rates User 9 (Rahul)
(8, 9, 10, '2024-05-05 12:00:00', 'Excellent collaboration! Very professional.'),
-- User 9 (Rahul) rates User 8 (Sarah Connor)
(9, 8, 10, '2024-05-06 13:00:00', 'Great experience, highly recommend collaborating.'),
-- User 1 (Masha) rates User 3 (Max)
(1, 3, 4, '2024-06-15 14:00:00', 'Unfortunately, the interaction was not the best.'),
-- User 3 (Max) rates User 1 (Masha)
(3, 1, 5, '2024-06-16 15:00:00', 'Could have been better, but overall okay.'),
-- User 2 (Margo) rates User 6 (Katya)
(2, 6, 9, '2024-07-10 16:00:00', 'Superb! Everything went great.'),
-- User 6 (Katya) rates User 2 (Margo)
(6, 2, 9, '2024-07-11 17:00:00', 'Very pleased with the collaboration.'),
-- User 4 (Chris Wilson) rates User 5 (Pat Kim)
(4, 5, 8, '2024-08-20 18:00:00', 'Good interaction, recommend.'),
-- User 5 (Pat Kim) rates User 4 (Chris Wilson)
(5, 4, 8, '2024-08-21 19:00:00', 'Everything went smoothly, thanks.'),
-- User 7 (Joseph Smith) rates User 9 (Rahul)
(7, 9, 10, '2024-09-15 20:00:00', 'Excellent partner, highly recommend.'),
-- User 9 (Rahul) rates User 7 (Joseph Smith)
(9, 7, 10, '2024-09-16 21:00:00', 'Fantastic collaboration, top-notch.'),
-- User 8 (Sarah Connor) rates User 5 (Pat Kim)
(8, 5, 6, '2024-10-05 22:00:00', 'Average experience, room for improvement.'),
-- User 5 (Pat Kim) rates User 8 (Sarah Connor)
(5, 8, 6, '2024-10-06 23:00:00', 'Expected more, but overall not bad.'),
-- User 2 (Margo) rates User 9 (Rahul)
(2, 9, 10, '2024-11-10 08:00:00', 'Superb! Very satisfied with the interaction.'),
-- User 9 (Rahul) rates User 2 (Margo)
(9, 2, 10, '2024-11-11 09:00:00', 'Excellent experience, highly recommend.');

INSERT INTO user_block (user_giver_id, user_receiver_id, blocked_datetime, content)
VALUES
-- User 1 (Masha) blocks User 3 (Max)
(1, 3, '2024-06-17 16:00:00', 'Repeated negative interactions.'),
-- User 5 (Pat Kim) blocks User 8 (Sarah Connor)
(5, 8, '2024-10-07 10:00:00', 'Unprofessional behavior.'),
-- User 6 (Katya) blocks User 7 (Joseph Smith)
(6, 7, '2024-04-12 11:00:00', 'Inappropriate messages.'),
-- User 3 (Max) blocks User 1 (Masha)
(3, 1, '2024-06-18 17:00:00', 'Disrespectful communication.'),
-- User 9 (Rahul) blocks User 5 (Pat Kim)
(9, 5, '2024-11-12 12:00:00', 'Spamming and unsolicited messages.'),
-- User 2 (Margo) blocks User 4 (Chris Wilson)
(2, 4, '2024-02-17 13:00:00', 'Violation of terms of service.'),
-- User 4 (Chris Wilson) blocks User 2 (Margo)
(4, 2, '2024-02-18 14:00:00', 'Harassment and abuse.'),
-- User 7 (Joseph Smith) blocks User 6 (Katya)
(7, 6, '2024-04-13 12:00:00', 'Conflict of interest.'),
-- User 8 (Sarah Connor) blocks User 5 (Pat Kim)
(8, 5, '2024-10-08 11:00:00', 'Disrespectful behavior.'),
-- User 5 (Pat Kim) blocks User 9 (Rahul)
(5, 9, '2024-10-09 12:00:00', 'Unwanted contact.');