-- delete all records from tables
CREATE or replace FUNCTION clean_tables() RETURNS void AS $$
declare
  l_stmt text;
begin
  select 'truncate ' || string_agg(format('%I.%I', schemaname, tablename) , ',')
    into l_stmt
  from pg_tables
  where schemaname in ('public');

  execute l_stmt || ' cascade';
end;
$$ LANGUAGE plpgsql;
select clean_tables();

-- reset sequence
CREATE or replace FUNCTION restart_sequences() RETURNS void AS $$
DECLARE
i TEXT;
BEGIN
 FOR i IN (SELECT column_default FROM information_schema.columns WHERE column_default SIMILAR TO 'nextval%')
  LOOP
         EXECUTE 'ALTER SEQUENCE'||' ' || substring(substring(i from '''[a-z_]*')from '[a-z_]+') || ' '||' RESTART 1;';
  END LOOP;
END $$ LANGUAGE plpgsql;
select restart_sequences();
-- end of reset

INSERT INTO country (country_name) VALUES
('Austria'),
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

-- Austria
INSERT INTO city (city_name, country_id) VALUES
('Vienna', (SELECT country_id FROM country WHERE country_name = 'Austria')),
('Graz', (SELECT country_id FROM country WHERE country_name = 'Austria')),
('Linz', (SELECT country_id FROM country WHERE country_name = 'Austria')),
('Salzburg', (SELECT country_id FROM country WHERE country_name = 'Austria')),
('Innsbruck', (SELECT country_id FROM country WHERE country_name = 'Austria'));

-- Belarus
INSERT INTO city (city_name, country_id) VALUES
('Minsk', (SELECT country_id FROM country WHERE country_name = 'Belarus')),
('Gomel', (SELECT country_id FROM country WHERE country_name = 'Belarus')),
('Mogilev', (SELECT country_id FROM country WHERE country_name = 'Belarus')),
('Vitebsk', (SELECT country_id FROM country WHERE country_name = 'Belarus')),
('Grodno', (SELECT country_id FROM country WHERE country_name = 'Belarus'));

-- Belgium
INSERT INTO city (city_name, country_id) VALUES
('Brussels', (SELECT country_id FROM country WHERE country_name = 'Belgium')),
('Antwerp', (SELECT country_id FROM country WHERE country_name = 'Belgium')),
('Ghent', (SELECT country_id FROM country WHERE country_name = 'Belgium')),
('Charleroi', (SELECT country_id FROM country WHERE country_name = 'Belgium')),
('Liège', (SELECT country_id FROM country WHERE country_name = 'Belgium'));

-- Bulgaria
INSERT INTO city (city_name, country_id) VALUES
('Sofia', (SELECT country_id FROM country WHERE country_name = 'Bulgaria')),
('Plovdiv', (SELECT country_id FROM country WHERE country_name = 'Bulgaria')),
('Varna', (SELECT country_id FROM country WHERE country_name = 'Bulgaria')),
('Burgas', (SELECT country_id FROM country WHERE country_name = 'Bulgaria')),
('Ruse', (SELECT country_id FROM country WHERE country_name = 'Bulgaria'));

-- Croatia
INSERT INTO city (city_name, country_id) VALUES
('Zagreb', (SELECT country_id FROM country WHERE country_name = 'Croatia')),
('Split', (SELECT country_id FROM country WHERE country_name = 'Croatia')),
('Rijeka', (SELECT country_id FROM country WHERE country_name = 'Croatia')),
('Osijek', (SELECT country_id FROM country WHERE country_name = 'Croatia')),
('Zadar', (SELECT country_id FROM country WHERE country_name = 'Croatia'));

-- Cyprus
INSERT INTO city (city_name, country_id) VALUES
('Nicosia', (SELECT country_id FROM country WHERE country_name = 'Cyprus')),
('Limassol', (SELECT country_id FROM country WHERE country_name = 'Cyprus')),
('Larnaca', (SELECT country_id FROM country WHERE country_name = 'Cyprus')),
('Paphos', (SELECT country_id FROM country WHERE country_name = 'Cyprus')),
('Famagusta', (SELECT country_id FROM country WHERE country_name = 'Cyprus'));

-- Czechia
INSERT INTO city (city_name, country_id) VALUES
('Prague', (SELECT country_id FROM country WHERE country_name = 'Czechia')),
('Brno', (SELECT country_id FROM country WHERE country_name = 'Czechia')),
('Ostrava', (SELECT country_id FROM country WHERE country_name = 'Czechia')),
('Plzeň', (SELECT country_id FROM country WHERE country_name = 'Czechia')),
('Liberec', (SELECT country_id FROM country WHERE country_name = 'Czechia'));

-- Denmark
INSERT INTO city (city_name, country_id) VALUES
('Copenhagen', (SELECT country_id FROM country WHERE country_name = 'Denmark')),
('Aarhus', (SELECT country_id FROM country WHERE country_name = 'Denmark')),
('Odense', (SELECT country_id FROM country WHERE country_name = 'Denmark')),
('Aalborg', (SELECT country_id FROM country WHERE country_name = 'Denmark')),
('Esbjerg', (SELECT country_id FROM country WHERE country_name = 'Denmark'));

-- Estonia
INSERT INTO city (city_name, country_id) VALUES
('Tallinn', (SELECT country_id FROM country WHERE country_name = 'Estonia')),
('Tartu', (SELECT country_id FROM country WHERE country_name = 'Estonia')),
('Narva', (SELECT country_id FROM country WHERE country_name = 'Estonia')),
('Pärnu', (SELECT country_id FROM country WHERE country_name = 'Estonia')),
('Kohtla-Järve', (SELECT country_id FROM country WHERE country_name = 'Estonia'));

-- Finland
INSERT INTO city (city_name, country_id) VALUES
('Helsinki', (SELECT country_id FROM country WHERE country_name = 'Finland')),
('Espoo', (SELECT country_id FROM country WHERE country_name = 'Finland')),
('Tampere', (SELECT country_id FROM country WHERE country_name = 'Finland')),
('Vantaa', (SELECT country_id FROM country WHERE country_name = 'Finland')),
('Oulu', (SELECT country_id FROM country WHERE country_name = 'Finland'));

-- France
INSERT INTO city (city_name, country_id) VALUES
('Paris', (SELECT country_id FROM country WHERE country_name = 'France')),
('Marseille', (SELECT country_id FROM country WHERE country_name = 'France')),
('Lyon', (SELECT country_id FROM country WHERE country_name = 'France')),
('Toulouse', (SELECT country_id FROM country WHERE country_name = 'France')),
('Nice', (SELECT country_id FROM country WHERE country_name = 'France'));

-- Germany
INSERT INTO city (city_name, country_id) VALUES
('Berlin', (SELECT country_id FROM country WHERE country_name = 'Germany')),
('Hamburg', (SELECT country_id FROM country WHERE country_name = 'Germany')),
('Munich', (SELECT country_id FROM country WHERE country_name = 'Germany')),
('Cologne', (SELECT country_id FROM country WHERE country_name = 'Germany')),
('Frankfurt', (SELECT country_id FROM country WHERE country_name = 'Germany'));

-- Greece
INSERT INTO city (city_name, country_id) VALUES
('Athens', (SELECT country_id FROM country WHERE country_name = 'Greece')),
('Thessaloniki', (SELECT country_id FROM country WHERE country_name = 'Greece')),
('Patras', (SELECT country_id FROM country WHERE country_name = 'Greece')),
('Heraklion', (SELECT country_id FROM country WHERE country_name = 'Greece')),
('Larissa', (SELECT country_id FROM country WHERE country_name = 'Greece'));

-- Hungary
INSERT INTO city (city_name, country_id) VALUES
('Budapest', (SELECT country_id FROM country WHERE country_name = 'Hungary')),
('Debrecen', (SELECT country_id FROM country WHERE country_name = 'Hungary')),
('Szeged', (SELECT country_id FROM country WHERE country_name = 'Hungary')),
('Miskolc', (SELECT country_id FROM country WHERE country_name = 'Hungary')),
('Pécs', (SELECT country_id FROM country WHERE country_name = 'Hungary'));

-- Ireland
INSERT INTO city (city_name, country_id) VALUES
('Dublin', (SELECT country_id FROM country WHERE country_name = 'Ireland')),
('Cork', (SELECT country_id FROM country WHERE country_name = 'Ireland')),
('Limerick', (SELECT country_id FROM country WHERE country_name = 'Ireland')),
('Galway', (SELECT country_id FROM country WHERE country_name = 'Ireland')),
('Waterford', (SELECT country_id FROM country WHERE country_name = 'Ireland'));

-- Italy
INSERT INTO city (city_name, country_id) VALUES
('Rome', (SELECT country_id FROM country WHERE country_name = 'Italy')),
('Milan', (SELECT country_id FROM country WHERE country_name = 'Italy')),
('Naples', (SELECT country_id FROM country WHERE country_name = 'Italy')),
('Turin', (SELECT country_id FROM country WHERE country_name = 'Italy')),
('Palermo', (SELECT country_id FROM country WHERE country_name = 'Italy'));

-- Latvia
INSERT INTO city (city_name, country_id) VALUES
('Riga', (SELECT country_id FROM country WHERE country_name = 'Latvia')),
('Daugavpils', (SELECT country_id FROM country WHERE country_name = 'Latvia')),
('Liepāja', (SELECT country_id FROM country WHERE country_name = 'Latvia')),
('Jelgava', (SELECT country_id FROM country WHERE country_name = 'Latvia')),
('Jūrmala', (SELECT country_id FROM country WHERE country_name = 'Latvia'));

-- Lithuania
INSERT INTO city (city_name, country_id) VALUES
('Vilnius', (SELECT country_id FROM country WHERE country_name = 'Lithuania')),
('Kaunas', (SELECT country_id FROM country WHERE country_name = 'Lithuania')),
('Klaipėda', (SELECT country_id FROM country WHERE country_name = 'Lithuania')),
('Šiauliai', (SELECT country_id FROM country WHERE country_name = 'Lithuania')),
('Panevėžys', (SELECT country_id FROM country WHERE country_name = 'Lithuania'));

-- Luxembourg
INSERT INTO city (city_name, country_id) VALUES
('Luxembourg City', (SELECT country_id FROM country WHERE country_name = 'Luxembourg')),
('Esch-sur-Alzette', (SELECT country_id FROM country WHERE country_name = 'Luxembourg')),
('Dudelange', (SELECT country_id FROM country WHERE country_name = 'Luxembourg')),
('Differdange', (SELECT country_id FROM country WHERE country_name = 'Luxembourg')),
('Ettelbruck', (SELECT country_id FROM country WHERE country_name = 'Luxembourg'));

-- Malta
INSERT INTO city (city_name, country_id) VALUES
('Birkirkara', (SELECT country_id FROM country WHERE country_name = 'Malta')),
('Mosta', (SELECT country_id FROM country WHERE country_name = 'Malta')),
('Qormi', (SELECT country_id FROM country WHERE country_name = 'Malta')),
('Żabbar', (SELECT country_id FROM country WHERE country_name = 'Malta')),
('Żejtun', (SELECT country_id FROM country WHERE country_name = 'Malta'));

-- Netherlands
INSERT INTO city (city_name, country_id) VALUES
('Amsterdam', (SELECT country_id FROM country WHERE country_name = 'Netherlands')),
('Rotterdam', (SELECT country_id FROM country WHERE country_name = 'Netherlands')),
('The Hague', (SELECT country_id FROM country WHERE country_name = 'Netherlands')),
('Utrecht', (SELECT country_id FROM country WHERE country_name = 'Netherlands')),
('Eindhoven', (SELECT country_id FROM country WHERE country_name = 'Netherlands'));

-- Poland
INSERT INTO city (city_name, country_id) VALUES
('Warsaw', (SELECT country_id FROM country WHERE country_name = 'Poland')),
('Kraków', (SELECT country_id FROM country WHERE country_name = 'Poland')),
('Łódź', (SELECT country_id FROM country WHERE country_name = 'Poland')),
('Wrocław', (SELECT country_id FROM country WHERE country_name = 'Poland')),
('Poznań', (SELECT country_id FROM country WHERE country_name = 'Poland'));

-- Portugal
INSERT INTO city (city_name, country_id) VALUES
('Lisbon', (SELECT country_id FROM country WHERE country_name = 'Portugal')),
('Porto', (SELECT country_id FROM country WHERE country_name = 'Portugal')),
('Vila Nova de Gaia', (SELECT country_id FROM country WHERE country_name = 'Portugal')),
('Amadora', (SELECT country_id FROM country WHERE country_name = 'Portugal')),
('Braga', (SELECT country_id FROM country WHERE country_name = 'Portugal'));

-- Romania
INSERT INTO city (city_name, country_id) VALUES
('Bucharest', (SELECT country_id FROM country WHERE country_name = 'Romania')),
('Cluj-Napoca', (SELECT country_id FROM country WHERE country_name = 'Romania')),
('Timișoara', (SELECT country_id FROM country WHERE country_name = 'Romania')),
('Iași', (SELECT country_id FROM country WHERE country_name = 'Romania')),
('Constanța', (SELECT country_id FROM country WHERE country_name = 'Romania'));

-- Russia
INSERT INTO city (city_name, country_id) VALUES
('Moscow', (SELECT country_id FROM country WHERE country_name = 'Russia')),
('Saint Petersburg', (SELECT country_id FROM country WHERE country_name = 'Russia')),
('Novosibirsk', (SELECT country_id FROM country WHERE country_name = 'Russia')),
('Yekaterinburg', (SELECT country_id FROM country WHERE country_name = 'Russia')),
('Nizhny Novgorod', (SELECT country_id FROM country WHERE country_name = 'Russia'));

-- Slovakia
INSERT INTO city (city_name, country_id) VALUES
('Bratislava', (SELECT country_id FROM country WHERE country_name = 'Slovakia')),
('Košice', (SELECT country_id FROM country WHERE country_name = 'Slovakia')),
('Prešov', (SELECT country_id FROM country WHERE country_name = 'Slovakia')),
('Žilina', (SELECT country_id FROM country WHERE country_name = 'Slovakia')),
('Nitra', (SELECT country_id FROM country WHERE country_name = 'Slovakia'));

-- Slovenia
INSERT INTO city (city_name, country_id) VALUES
('Ljubljana', (SELECT country_id FROM country WHERE country_name = 'Slovenia')),
('Maribor', (SELECT country_id FROM country WHERE country_name = 'Slovenia')),
('Celje', (SELECT country_id FROM country WHERE country_name = 'Slovenia')),
('Kranj', (SELECT country_id FROM country WHERE country_name = 'Slovenia')),
('Velenje', (SELECT country_id FROM country WHERE country_name = 'Slovenia'));

-- Spain
INSERT INTO city (city_name, country_id) VALUES
('Madrid', (SELECT country_id FROM country WHERE country_name = 'Spain')),
('Barcelona', (SELECT country_id FROM country WHERE country_name = 'Spain')),
('Valencia', (SELECT country_id FROM country WHERE country_name = 'Spain')),
('Seville', (SELECT country_id FROM country WHERE country_name = 'Spain')),
('Zaragoza', (SELECT country_id FROM country WHERE country_name = 'Spain'));

-- Sweden
INSERT INTO city (city_name, country_id) VALUES
('Stockholm', (SELECT country_id FROM country WHERE country_name = 'Sweden')),
('Gothenburg', (SELECT country_id FROM country WHERE country_name = 'Sweden')),
('Malmö', (SELECT country_id FROM country WHERE country_name = 'Sweden')),
('Uppsala', (SELECT country_id FROM country WHERE country_name = 'Sweden')),
('Västerås', (SELECT country_id FROM country WHERE country_name = 'Sweden'));

-- Ukraine
INSERT INTO city (city_name, country_id) VALUES
('Kyiv', (SELECT country_id FROM country WHERE country_name = 'Ukraine')),
('Kharkiv', (SELECT country_id FROM country WHERE country_name = 'Ukraine')),
('Odesa', (SELECT country_id FROM country WHERE country_name = 'Ukraine')),
('Dnipro', (SELECT country_id FROM country WHERE country_name = 'Ukraine')),
('Lviv', (SELECT country_id FROM country WHERE country_name = 'Ukraine'));

-- United Kingdom
INSERT INTO city (city_name, country_id) VALUES
('London', (SELECT country_id FROM country WHERE country_name = 'United Kingdom')),
('Birmingham', (SELECT country_id FROM country WHERE country_name = 'United Kingdom')),
('Glasgow', (SELECT country_id FROM country WHERE country_name = 'United Kingdom')),
('Liverpool', (SELECT country_id FROM country WHERE country_name = 'United Kingdom')),
('Manchester', (SELECT country_id FROM country WHERE country_name = 'United Kingdom'));

-- Uzbekistan
INSERT INTO city (city_name, country_id) VALUES
('Tashkent', (SELECT country_id FROM country WHERE country_name = 'Uzbekistan')),
('Samarkand', (SELECT country_id FROM country WHERE country_name = 'Uzbekistan')),
('Namangan', (SELECT country_id FROM country WHERE country_name = 'Uzbekistan')),
('Andijan', (SELECT country_id FROM country WHERE country_name = 'Uzbekistan')),
('Bukhara', (SELECT country_id FROM country WHERE country_name = 'Uzbekistan'));

INSERT INTO phone_code (code_number, country_id) VALUES
('+43', (SELECT country_id FROM country WHERE country_name = 'Austria')),
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

INSERT INTO gender (gender_name) VALUES
('Male'),
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

INSERT INTO animal_type (type_name) VALUES
('Dog'),
('Cat'),
('Parrot'),
('Hamster'),
('Rabbit'),
('Fish'),
('Reptile'),
('Bird'),
('Horse'),
('Other');

-- dog breeds
INSERT INTO breed (breed_name, type_id) VALUES
('Labrador Retriever', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
('German Shepherd', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
('Golden Retriever', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
('Bulldog', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
('Beagle', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
('Poodle', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
('Rottweiler', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
('Yorkshire Terrier', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
('Boxer', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
('Dachshund', (SELECT type_id FROM animal_type WHERE type_name = 'Dog')),
('King Charles Spaniel', (SELECT type_id FROM animal_type WHERE type_name = 'Dog'));

-- cat breeds
INSERT INTO breed (breed_name, type_id) VALUES
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
('Exotic Shorthair', (SELECT type_id FROM animal_type WHERE type_name = 'Cat'));

-- parrot breeds
INSERT INTO breed (breed_name, type_id) VALUES
('African Grey Parrot', (SELECT type_id FROM animal_type WHERE type_name = 'Parrot')),
('Budgerigar', (SELECT type_id FROM animal_type WHERE type_name = 'Parrot')),
('Cockatiel', (SELECT type_id FROM animal_type WHERE type_name = 'Parrot')),
('Macaw', (SELECT type_id FROM animal_type WHERE type_name = 'Parrot')),
('Cockatoo', (SELECT type_id FROM animal_type WHERE type_name = 'Parrot'));

-- hamster breeds
INSERT INTO breed (breed_name, type_id) VALUES
('Syrian Hamster', (SELECT type_id FROM animal_type WHERE type_name = 'Hamster')),
('Dwarf Campbell Russian Hamster', (SELECT type_id FROM animal_type WHERE type_name = 'Hamster')),
('Roborovski Dwarf Hamster', (SELECT type_id FROM animal_type WHERE type_name = 'Hamster')),
('Chinese Hamster', (SELECT type_id FROM animal_type WHERE type_name = 'Hamster')),
('Winter White Russian Dwarf Hamster', (SELECT type_id FROM animal_type WHERE type_name = 'Hamster'));

-- fish breeds (species)
INSERT INTO breed (breed_name, type_id) VALUES
('Goldfish', (SELECT type_id FROM animal_type WHERE type_name = 'Fish')),
('Betta', (SELECT type_id FROM animal_type WHERE type_name = 'Fish')),
('Guppy', (SELECT type_id FROM animal_type WHERE type_name = 'Fish')),
('Angelfish', (SELECT type_id FROM animal_type WHERE type_name = 'Fish')),
('Molly', (SELECT type_id FROM animal_type WHERE type_name = 'Fish'));

-- reptile breeds (species)
INSERT INTO breed (breed_name, type_id) VALUES
('Leopard Gecko', (SELECT type_id FROM animal_type WHERE type_name = 'Reptile')),
('Bearded Dragon', (SELECT type_id FROM animal_type WHERE type_name = 'Reptile')),
('Ball Python', (SELECT type_id FROM animal_type WHERE type_name = 'Reptile')),
('Corn Snake', (SELECT type_id FROM animal_type WHERE type_name = 'Reptile')),
('Red-Eared Slider', (SELECT type_id FROM animal_type WHERE type_name = 'Reptile'));

INSERT INTO user_account (
    code_id,
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
    is_active
) VALUES
-- User 1
(
    (SELECT code_id FROM phone_code WHERE code_number = '+420'), -- Czechia
    (SELECT gender_id FROM gender WHERE gender_name = 'Female'),
    'mashkerz',
    'marijabatan@gmail.com',
    '773056892',
    '2006-11-05',
    'Marija',
    NULL,
    'My cat runs my life. I’m just here to pay the bills and open cans.',
    '3b8e32e8c4ff4a2e3c1541d2c9a4c86a4e6b6a3d8ef6c3db6243f8f5d5d8c9a1',
    'X4xZkPm7Y+2vQ9uLtC3zOg',
    '2024-01-08 04:05:06',
    TRUE
),
-- User 2
(
    (SELECT code_id FROM phone_code WHERE code_number = '+420'), -- Czechia
    (SELECT gender_id FROM gender WHERE gender_name = 'Female'),
    'margo96',
    'margaret1996@seznam.cz',
    '789635112',
    '1996-06-23',
    'Margaret',
    'Hamadej',
    'I enjoy long walks... from the bed to the fridge and back. Especially if there’s ice cream involved.',
    'a1e2b3c4d5f6789012a3b4c5d6e7f8901a2b3c4d5e6f7890a1b2c3d4e5f6a7b8',
    'R8kYpW5eJ2oLxN9uOm2zRg',
    '2024-05-04 10:11:10',
    TRUE
),
-- User 3
(
    (SELECT code_id FROM phone_code WHERE code_number = '+420'), -- Czechia
    (SELECT gender_id FROM gender WHERE gender_name = 'Non-binary'),
    'max4ever',
    'maxnomoneyzara@icloud.com',
    '3456789012',
    '2005-11-05',
    'Max',
    NULL,
    'My dog knows more tricks than I do skills at work. And she’s not even stressed about it.',
    'd41d8cd98f00b204e9800998ecf8427eafbf3c3c6f7f8f9a0b1c2d3e4f5a6b7',
    'Q1lXpZ8vT7oKmN5cO3rZPg',
    '2024-03-20 23:30:09',
    TRUE
),
-- User 4
(
    (SELECT code_id FROM phone_code WHERE code_number = '+33'), -- France
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
    TRUE
),
-- User 5
(
    (SELECT code_id FROM phone_code WHERE code_number = '+998'), -- Uzbekistan
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
    TRUE
),
-- User 6
(
    (SELECT code_id FROM phone_code WHERE code_number = '+7'), -- Russia
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
    TRUE
),
-- User 7
(
    (SELECT code_id FROM phone_code WHERE code_number = '+44'), -- United Kingdom
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
    TRUE
),
-- User 8
(
    (SELECT code_id FROM phone_code WHERE code_number = '+34'), -- Spain
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
    TRUE
),
-- User 9
(
    (SELECT code_id FROM phone_code WHERE code_number = '+34'), -- Spain
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
    TRUE
),
-- User 10
(
    (SELECT code_id FROM phone_code WHERE code_number = '+34'), -- Spain
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
    TRUE
);

INSERT INTO pet_profile (
    gender_id, city_id, breed_id, type_id, user_id, pet_name, date_of_birth, price,
    certification_url, profile_description, purebred_percantage, created_datetime
)
VALUES
-- dogs
((SELECT gender_id FROM Gender WHERE gender_name = 'Female'), -- Masha
 (SELECT city_id FROM City WHERE city_name = 'Prague'),
 (SELECT breed_id FROM breed WHERE breed_name = 'King Charles Spaniel'),
 (SELECT type_id FROM animal_type WHERE type_name = 'Dog'),
 1, 'Snusicha', '2022-04-05', 5000, 'https://example.com/certificates/buddy_cert.pdf',
 'Meet Snusicha, a stunning King Charles Spaniel with a charming personality and impeccable lineage. ' ||
 'Playful yet calm, Snusicha adores cuddles, long walks, and, of course, being the center of attention. ' ||
 'If you’re looking for a top-quality companion for breeding, Snusicha is ready to meet her match! 🐾 ' ||
 'Feel free to contact me for further details or to arrange a meet-up. Let’s make some adorable King Charles Spaniel puppies together! 🐶✨', 100, '2024-01-08 06:00:00'),

-- cats
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
 'If you’re looking for a sweet and easygoing companion, Ajkosik is ready to meet you!', 100, '2024-02-08 07:30:00')
;
