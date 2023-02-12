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

-- end of erasing

insert into bar (id_bar, name, rules, description) values (1, 'Bar Quindecim', '1. Arbiter is unable to tell guests where they are. ' ||
                                                                                  '2. The two of guests must play a game. ' ||
                                                                                  '3. The Game will be chosen by roulette. ' ||
                                                                                  '4. The two guests stake their lives on The Game. ' ||
                                                                                  '5. Guests cannot leave until the game is over.',
                                                                                  'Quindecim appears to be modeled as a modern European bar. At the counter, it is lavishly decorated in a Grecian/Roman design. ' ||
                                                                                  'It consists of several shelves stocked with fine wine and alcohol.');

insert into worker (id_worker, id_bar, name) values (1, 1, 'Decim');
insert into worker (id_worker, id_bar, name) values (2, 1, 'Quin');
insert into worker (id_worker, id_bar, name) values (3, 1, 'Kurokami no Onna');


insert into arbiter (id_worker, id_bar, additional_role) values (1, 1, 'Owner of the bar Quindecim');
insert into assistent (id_worker) values (2);
insert into bartender (id_worker) values (3);

insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (1, 2, 1, 'L Lawliet',
                                                           'Death caused by heart attack.', '2002-10-23',
                                                           'Was calm all his life and honest.', 'Bowling',
                                                           'Behaved calmly and balanced, used cunning to win, but behaved with dignity.',
                                                           'Sent to reincarnation.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (2, 2, 1, 'Light Yagami',
                                                           'Death caused by heart attack.', '2000-08-08',
                                                           'Was cunning, perspicacious and went over the heads for the sake of success.',
                                                           'Bowling', 'Was calm, but ruthless, went to meanness for the sake of losing.',
                                                           'Sent into oblivion.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (3, 2, 1, 'Lelouch Lamperouge',
                                                           'Killed by Suzaku.', '1999-09-04',
                                                           'Was frisky and cunning, but was kind to other people.',
                                                           'Billiards', 'Was active, but kind to the rival, lost with honor.',
                                                           'Sent into oblivion.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (4, 2, 1, 'Minoru Tanaka',
                                                           'Suicides by hanging.', '2002-10-12',
                                                           'Was an envious person, did not disdain to substitute others for his own sake.',
                                                           'Billiards', 'Behaved provocatively, but meanly.',
                                                           'Sent to reincarnation.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (5, 2, 1, 'Shirou Emiya',
                                                           'Sacrifices himself to destroy the Greater Grail.', '1993-03-12',
                                                           'Was kind to people, helped from the bottom of his heart.',
                                                           'Darts', 'Outwitted the opponent, but behaved with dignity.',
                                                           'Sent into oblivion.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (6, 2, 1, 'Kotori Takatori',
                                                           'Sacrificed her life.', '1988-12-21',
                                                           'Lived a righteous life, didnt like people, but never hurt others.',
                                                            'Darts', 'Lost with honor, was very calm and loyal to the opponent.',
                                                           'Sent to reincarnation.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (7, 2, 1, 'Satella Harvenheit',
                                                           'Death caused by loss of blood.', '1985-06-23',
                                                           'Loved riots and led a dissolute lifestyle. Not seen in illegal activities.',
                                                           'Poker', 'Played a dishonest game, cheated.',
                                                           'Sent to reincarnation.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (8, 2, 1, 'Gyro Zeppeli',
                                                           'Death caused by asphyxia.', '2004-09-01',
                                                           'Never appreciated what he has. He was cruel to people, but madly in love with animals.',
                                                           'Poker', 'Played fair, got angry after losing.',
                                                           'Sent into oblivion.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (9, 2, 1, 'Yatorishino Igsem',
                                                           'Сrushed by a stone during a rockfall.', '1993-09-24',
                                                           'Always responded to a request for help, but was narcissistic and suffered from hydonism.',
                                                           'Ballon Duel', 'Did not take the game seriously, had fun, accepted defeat with a smile.',
                                                           'Sent into oblivion.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (10, 2, 1, 'Inori Yuzuriha',
                                                           'Sacrificing herself.', '1993-07-08',
                                                           'Never understood other people, pretended to be a good person for approval.',
                                                           'Ballon Duel', 'Reacted with laughter to the game, was cheerful, but did not miss the chance to snatch victory.',
                                                           'Sent to reincarnation.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (11, 2, 1, 'Itachi Uchiha',
                                                           'Death caused by cancer that slowly poisoned his heart.', '1992-03-17',
                                                           'Suffered from a split personality, both personalities were always in conflict with each other, one was absolutely philanthropic, the second wanted to eradicate many people.',
                                                           'Domino', 'Used ingenuity to win, cheated if possible - chose fair play.',
                                                           'Sent into oblivion.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (12, 2, 1, 'Koro Sensei',
                                                           'Was stabbed in the heart.', '1990-02-04',
                                                           'Was a kind and sympathetic person until the death of his father, after which he became angry at the world and looked for any opportunity for revenge.',
                                                           'Domino', 'Used the opportunity to cheat, behaved kindly to the opponent.',
                                                           'Sent to reincarnation.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (13, 2, 1, 'Maes Hughes',
                                                           'Was shot in the heart by Envy.', '2003-11-15',
                                                           'Valued life and was loved by everyone around him for his human attitude towards everyone, even to inveterate vill.',
                                                           'Chess', 'Played fairly, but used psychological pressure, humiliated the opponent.',
                                                           'Sent into oblivion.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (14, 2, 1, 'Nina Tucker',
                                                           'Was eaten by cannibals.', '2001-09-11',
                                                           'Was an avid lutaman, he lost everything that was possible and everything that was impossible. Framed a huge number of people, for which he was killed in the name of revenge.',
                                                           'Chess', 'In fair play, he skillfully repelled the opponents attacks, at the end of the game he tried to injure the opponent with an elephant figure.',
                                                           'Sent to reincarnation.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (15, 2, 1, 'Kushina Uzumaki',
                                                           'Lions claw pierced her body.', '2001-09-01',
                                                           'Was active and kind, respected elders, did not tolerate lies.',
                                                           'Jenga', 'Broke the pyramid on the move of the opponent, while he was distracted to snatch the victory.',
                                                           'Sent to reincarnation.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (16, 2, 1, 'Neji Hyuga',
                                                           'Death caused by the ten tails firing multiple wood release projectiles.', '2000-10-12',
                                                           'Hated it when people were late and ignored, he hacked his friend to death for these two sins. For which he was killed by the police during the arrest.',
                                                           'Jenga', 'Was aggressive during the game, tried to break everything possible after losing.',
                                                           'Sent into oblivion.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (17, 2, 1, 'Kaori Miyazono',
                                                           'Death caused by the fatal wound to the brain.', '1998-08-07',
                                                           'Was not talerant, despised people with less intelligence, was a snob. Killed in a shootout.',
                                                          'Prosecco Pong', 'Did not know the measure during the game, drank too much, broke the bottle after losing.',
                                                           'Sent to reincarnation.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (18, 2, 1, 'Erwin Smith',
                                                           'Was hit by a car.', '1996-06-25',
                                                           'Loved animals, treated them in a way that he did not treat the closest people. Lived alone, quietly.',
                                                           'Prosecco Pong', 'Drunk until he lost his pulse, but was able to snatch victory, was drunk but remained humane.',
                                                           'Sent into oblivion.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (19, 2, 1, 'Obito Uchiha',
                                                           'Death caused by loss of blood.', '1995-10-03',
                                                           'Was jealous and emotional, could not contain his feelings and stabbed his girlfriend, whom he loved. Her father took revenge on him.',
                                                           'Spikeball', 'Was cunning during the game, but honest, treated the opponent with respect.',
                                                           'Sent into oblivion.');
insert into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (20, 2, 1, 'Sasha Blouse',
                                                           'Death caused by gunshot wound.', '1993-02-26',
                                                           'Was an onym at school, he hated teachers, his classmates loved him, but teachers could not stand him. For which he came to school one day and blew himself up with her.',
                                                           'Spikeball', 'Was calm and balanced, played honestly with due respect.',
                                                          'Sent to reincarnation.');
select setval(pg_get_serial_sequence('guest', 'id_guest'), 20);


insert into snack (id_snack, name) values (1, 'Sweet Chili Chicken Lettuce Cups');
insert into snack (id_snack, name) values (2, 'Keto Tortilla Chips');
insert into snack (id_snack, name) values (3, 'Herby Baked Falafel Bites');
insert into snack (id_snack, name) values (4, 'Collard Wrap Bento');
select setval(pg_get_serial_sequence('snack', 'id_snack'), 4);
insert into snack (name) values ('Kimbap');
insert into snack (name) values ('Apple Chips');
insert into snack (name) values ('Greek Feta Dip');
insert into snack (name) values ('Antipasto Bites');
insert into snack (name) values ('Curry-Lime Cashews');
insert into snack (name) values ('Whipped Ricotta Toast With Lemony Snap Peas');
insert into snack (name) values ('Zucchini Sushi');
insert into snack (name) values ('Greek Cucumber Cups');
insert into snack (name) values ('Bacon Avocado Fries');
insert into snack (name) values ('Roasted Chickpeas');
insert into snack (name) values ('Honey-Garlic CauliflowerDeath Games');

insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (1, 'Alcoholic', 'Red Wine', 'Valpolicella Ripasso Classico','7.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (2, 'Alcoholic', 'Red Wine', 'Del Dotto','7.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (3, 'Alcoholic', 'Red Wine', 'Vega Sicilia','10');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (4, 'Alcoholic', 'Red Wine', 'Pétrus','8.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (5, 'Alcoholic', 'Red Wine', 'Pago de Carraovejas','10');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (6, 'Alcoholic', 'White Wine', 'Domaine Choche-Dury','7');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (7, 'Alcoholic', 'White Wine', 'Joh. Jos. Prüm','7.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (8, 'Alcoholic', 'White Wine', 'Cartuxa','9.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (9, 'Alcoholic', 'White Wine', 'Château-Grillet','10');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (10, 'Alcoholic', 'White Wine', 'Château Haut-Brion','12');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (11, 'Alcoholic', 'Rose Wine', 'Goldenkloof Rosé','13');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (12, 'Alcoholic', 'Rose Wine', 'Quanta Terra','7.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (13, 'Alcoholic', 'Rose Wine', 'Scala Dei','11.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (14, 'Alcoholic', 'Rose Wine', 'Castillo Catadau Rosado','8');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (15, 'Alcoholic', 'Rose Wine', 'Citra Torre Viva Cerasuolo d''Abruzzo','7.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (16, 'Alcoholic', 'Champagne', 'Millésime Extra Brut Champagne Grand Cru','5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (17, 'Alcoholic', 'Champagne', 'Mas de Daumas Gassac','8');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (18, 'Alcoholic', 'Champagne', 'Frank John','10.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (19, 'Alcoholic', 'Champagne', 'Louis Roederer','8');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (20, 'Alcoholic', 'Champagne', 'Bollinger','9');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (21, 'Alcoholic', 'Whisky', 'Chivas Regal','40');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (22, 'Alcoholic', 'Whisky', 'Glenfiddich Grand Cru','45');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (23, 'Alcoholic', 'Whisky', 'Highland Park The Light','40.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (24, 'Alcoholic', 'Whisky', 'Glen Moray Portcask','49');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (25, 'Alcoholic', 'Whisky', 'Caperdonich Peated Small batch','50');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (26, 'Alcoholic', 'Vodka', 'Beluga Gold Line','40');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (27, 'Alcoholic', 'Vodka', 'Belvedere Pure','40');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (28, 'Alcoholic', 'Vodka', 'Polugar Single Malt Rye','38.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (29, 'Alcoholic', 'Vodka', 'Ciroc','40');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (30, 'Alcoholic', 'Vodka', 'Roberto Cavalli','40');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (31, 'Alcoholic', 'Gin', 'Remy Martin Louis XIII','47');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (32, 'Alcoholic', 'Gin', 'Johnnie Walker & Sons Bicentenary Blend','47.2');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (33, 'Alcoholic', 'Gin', 'Saint James 250th Anniversary Decanter','57');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (34, 'Alcoholic', 'Gin', 'Aukce Ron Zacapa Centenario Straight from the Cask','40');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (35, 'Alcoholic', 'Gin', 'Martell Cohiba Prestige','47');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (36, 'Alcoholic', 'Cognac', 'Metaxa AEN','45.3');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (37, 'Alcoholic', 'Cognac', 'L‘OR de Jean MARTELL','40');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (38, 'Alcoholic', 'Cognac', 'Godet Renaissance Grand Champagne','40');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (39, 'Alcoholic', 'Cognac', 'Foursquare Dominus Exceptional Cask','56');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (40, 'Alcoholic', 'Cognac', 'Chateau Montifaud','43');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (41, 'Alcoholic', 'Absinthe', 'Mead Base','65');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (42, 'Alcoholic', 'Absinthe', 'Pernod','68');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (43, 'Alcoholic', 'Absinthe', 'Verte','70');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (44, 'Alcoholic', 'Absinthe', 'Aukce Absinth King of Spirits','72');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (45, 'Alcoholic', 'Absinthe', 'Amave blanche','53');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (46, 'Alcoholic', 'Liqueur', 'Coloma Single Cask','35');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (47, 'Alcoholic', 'Liqueur', 'St.Germain','44.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (48, 'Alcoholic', 'Liqueur', 'Beluga Hunting Herbal Dessert','23');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (49, 'Alcoholic', 'Liqueur', 'Sheridans','30.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (50, 'Alcoholic', 'Liqueur', 'Godet Pearadise','50');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (51, 'Alcoholic', 'Rum', 'Black Tot','40');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (52, 'Alcoholic', 'Rum', 'Brugal Papa Andres','45');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (53, 'Alcoholic', 'Rum', 'Havana Club Maximo Ron Extra Anejo','40.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (54, 'Alcoholic', 'Rum', 'Highland Park Thorfinn','47');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (55, 'Alcoholic', 'Rum', 'Rum Dictador 2 Masters Glenfarclas','50.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (56, 'Alcoholic', 'Vermouth', 'Sister Isles','45');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (57, 'Alcoholic', 'Vermouth', 'Don Q Vermouth Cask','40');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (58, 'Alcoholic', 'Vermouth', 'Carpano Antica Formula','16.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (59, 'Alcoholic', 'Vermouth', 'Hotel Starlino Rosso','17');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (60, 'Alcoholic', 'Vermouth', 'Dolin Vermouth de Chambéry Rouge','16');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (61, 'Alcoholic', 'Dark Beer', 'Belhaven','5.2');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (62, 'Alcoholic', 'Dark Beer', 'Hacker-Pschorr Dunkle Weisse','12');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (63, 'Alcoholic', 'Dark Beer', 'Old Rasputi','9');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (64, 'Alcoholic', 'Dark Beer', 'Westmalle Dubbel','5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (65, 'Alcoholic', 'Dark Beer', 'Petrus Oud Bruin','6');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (66, 'Alcoholic', 'Light Beer', 'Inedit Damm','5.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (67, 'Alcoholic', 'Light Beer', 'Miller Lite','4');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (68, 'Alcoholic', 'Light Beer', 'Lagunitas DayTime IPA','6.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (69, 'Alcoholic', 'Light Beer', 'Hitachino Nest White Ale','7');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (70, 'Alcoholic', 'Light Beer', 'Allagash White','6');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (71, 'Alcoholic', 'Cocktail', 'Espresso martini','20');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (72, 'Alcoholic', 'Cocktail', 'Negroni','28');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (73, 'Alcoholic', 'Cocktail', 'Beton','40');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (74, 'Alcoholic', 'Cocktail', 'Bloody Mary','17');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (75, 'Alcoholic', 'Cocktail', 'White Russian','30');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (76, 'Alcoholic', 'Cocktail', 'Gimlet','37');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (77, 'Alcoholic', 'Cocktail', 'Cosmopolitan','11');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (78, 'Alcoholic', 'Cocktail', 'Screwdriver','40.5');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (79, 'Alcoholic', 'Cocktail', 'Daiquiri','22');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (80, 'Alcoholic', 'Cocktail', 'Old fashioned','43.2');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (81, 'Non-alcoholic', 'Still water', 'Evian','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (82, 'Non-alcoholic', 'Sparkling water', 'Perrier','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (83, 'Non-alcoholic', 'Fizzy water', 'Coca-Cola','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (84, 'Non-alcoholic', 'Fizzy water', 'Fanta','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (85, 'Non-alcoholic', 'Fizzy water', '7up','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (86, 'Non-alcoholic', 'Fizzy water', 'Dr Pepper','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (87, 'Non-alcoholic', 'Fizzy water', 'Schweppes','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (88, 'Non-alcoholic', 'Cocktail', 'Cranberry Sparkler','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (89, 'Non-alcoholic', 'Cocktail', 'Sangria Punch','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (90, 'Non-alcoholic', 'Cocktail', 'Spirit Free Bellini','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (91, 'Non-alcoholic', 'Cocktail', 'Mocktail Mary','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (92, 'Non-alcoholic', 'Cocktail', 'Virgin Strawberry Daiquiri','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (93, 'Non-alcoholic', 'Cocktail', 'Blackberry Nojito','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (94, 'Non-alcoholic', 'Cocktail', 'Strawberry Cucumber Mule Mocktail','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (95, 'Non-alcoholic', 'Cocktail', 'Blue Raspberry Faux-tini','0');
insert into drink (id_drink, type, sort, name, volume_of_alcohol) values (96, 'Non-alcoholic', 'Cocktail', 'Golden Sparkles','0');
select setval(pg_get_serial_sequence('drink', 'id_drink'), 96);


insert into order_desk (id_order, id_worker, id_guest) values (1, 3, 1);
insert into order_desk (id_order, id_worker, id_guest) values (2, 3, 2);
insert into order_desk (id_order, id_worker, id_guest) values (3, 3, 3);
insert into order_desk (id_order, id_worker, id_guest) values (4, 3, 4);
insert into order_desk (id_order, id_worker, id_guest) values (5, 3, 5);
insert into order_desk (id_order, id_worker, id_guest) values (6, 3, 6);
insert into order_desk (id_order, id_worker, id_guest) values (7, 3, 7);
insert into order_desk (id_order, id_worker, id_guest) values (8, 3, 8);
insert into order_desk (id_order, id_worker, id_guest) values (9, 3, 9);
insert into order_desk (id_order, id_worker, id_guest) values (10, 3, 10);
insert into order_desk (id_order, id_worker, id_guest) values (11, 3, 11);
insert into order_desk (id_order, id_worker, id_guest) values (12, 3, 12);
insert into order_desk (id_order, id_worker, id_guest) values (13, 3, 13);
insert into order_desk (id_order, id_worker, id_guest) values (14, 3, 14);
insert into order_desk (id_order, id_worker, id_guest) values (15, 3, 15);
insert into order_desk (id_order, id_worker, id_guest) values (16, 3, 16);
insert into order_desk (id_order, id_worker, id_guest) values (17, 3, 17);
insert into order_desk (id_order, id_worker, id_guest) values (18, 3, 18);
insert into order_desk (id_order, id_worker, id_guest) values (19, 3, 19);
insert into order_desk (id_order, id_worker, id_guest) values (20, 3, 20);
insert into order_desk (id_order, id_worker, worker_id_worker) values (21, 3, 1);
insert into order_desk (id_order, id_worker, worker_id_worker) values (22, 3, 1);
insert into order_desk (id_order, id_worker, worker_id_worker) values (23, 3, 1);
insert into order_desk (id_order, id_worker, worker_id_worker) values (24, 3, 1);
insert into order_desk (id_order, id_worker, worker_id_worker) values (25, 3, 1);
insert into order_desk (id_order, id_worker, worker_id_worker) values (26, 3, 1);
insert into order_desk (id_order, id_worker, worker_id_worker) values (27, 3, 2);
insert into order_desk (id_order, id_worker, worker_id_worker) values (28, 3, 2);
insert into order_desk (id_order, id_worker, worker_id_worker) values (29, 3, 2);
insert into order_desk (id_order, id_worker, worker_id_worker) values (30, 3, 2);
insert into order_desk (id_order, id_worker, worker_id_worker) values (31, 3, 3);
insert into order_desk (id_order, id_worker, worker_id_worker) values (32, 3, 3);
insert into order_desk (id_order, id_worker, worker_id_worker) values (33, 3, 3);
insert into order_desk (id_order, id_worker, worker_id_worker) values (34, 3, 3);
insert into order_desk (id_order, id_worker, worker_id_worker) values (35, 3, 3);

insert into order_desk_drink (id_order, id_drink) values (21, 5);
insert into order_desk_drink (id_order, id_drink) values (21, 6);
insert into order_desk_drink (id_order, id_drink) values (21, 13);
insert into order_desk_drink (id_order, id_drink) values (22, 1);
insert into order_desk_drink (id_order, id_drink) values (23, 12);
insert into order_desk_drink (id_order, id_drink) values (23, 43);
insert into order_desk_drink (id_order, id_drink) values (24, 20);
insert into order_desk_drink (id_order, id_drink) values (25, 33);
insert into order_desk_drink (id_order, id_drink) values (25, 30);
insert into order_desk_drink (id_order, id_drink) values (26, 61);

insert into order_desk_drink (id_order, id_drink) values (27, 5);
insert into order_desk_drink (id_order, id_drink) values (28, 85);
insert into order_desk_drink (id_order, id_drink) values (29, 15);
insert into order_desk_drink (id_order, id_drink) values (30, 25);
insert into order_desk_drink (id_order, id_drink) values (27, 26);
insert into order_desk_drink (id_order, id_drink) values (28, 27);
insert into order_desk_drink (id_order, id_drink) values (29, 28);
insert into order_desk_drink (id_order, id_drink) values (30, 29);
insert into order_desk_drink (id_order, id_drink) values (30, 30);

insert into order_desk_drink (id_order, id_drink) values (31, 5);
insert into order_desk_drink (id_order, id_drink) values (32, 27);
insert into order_desk_drink (id_order, id_drink) values (32, 2);
insert into order_desk_drink (id_order, id_drink) values (33, 79);
insert into order_desk_drink (id_order, id_drink) values (34, 96);
insert into order_desk_drink (id_order, id_drink) values (34, 26);
insert into order_desk_drink (id_order, id_drink) values (35, 37);

insert into order_desk_drink (id_order, id_drink) values (1, 73);
insert into order_desk_drink (id_order, id_drink) values (1, 56);
insert into order_desk_drink (id_order, id_drink) values (1, 42);
insert into order_desk_drink (id_order, id_drink) values (1, 92);
insert into order_desk_drink (id_order, id_drink) values (2, 92);
insert into order_desk_drink (id_order, id_drink) values (3, 92);
insert into order_desk_drink (id_order, id_drink) values (3, 93);
insert into order_desk_drink (id_order, id_drink) values (4, 92);
insert into order_desk_drink (id_order, id_drink) values (4, 94);
insert into order_desk_drink (id_order, id_drink) values (5, 92);
insert into order_desk_drink (id_order, id_drink) values (5, 95);
insert into order_desk_drink (id_order, id_drink) values (6, 92);
insert into order_desk_drink (id_order, id_drink) values (6, 91);
insert into order_desk_drink (id_order, id_drink) values (6, 57);
insert into order_desk_drink (id_order, id_drink) values (7, 92);
insert into order_desk_drink (id_order, id_drink) values (7, 86);
insert into order_desk_drink (id_order, id_drink) values (8, 92);
insert into order_desk_drink (id_order, id_drink) values (8, 77);
insert into order_desk_drink (id_order, id_drink) values (8, 67);
insert into order_desk_drink (id_order, id_drink) values (9, 92);
insert into order_desk_drink (id_order, id_drink) values (9, 62);
insert into order_desk_drink (id_order, id_drink) values (10, 92);
insert into order_desk_drink (id_order, id_drink) values (10, 60);
insert into order_desk_drink (id_order, id_drink) values (11, 92);
insert into order_desk_drink (id_order, id_drink) values (11, 59);
insert into order_desk_drink (id_order, id_drink) values (12, 92);
insert into order_desk_drink (id_order, id_drink) values (12, 57);
insert into order_desk_drink (id_order, id_drink) values (13, 92);
insert into order_desk_drink (id_order, id_drink) values (13, 55);
insert into order_desk_drink (id_order, id_drink) values (14, 92);
insert into order_desk_drink (id_order, id_drink) values (14, 50);
insert into order_desk_drink (id_order, id_drink) values (15, 92);
insert into order_desk_drink (id_order, id_drink) values (15, 43);
insert into order_desk_drink (id_order, id_drink) values (16, 92);
insert into order_desk_drink (id_order, id_drink) values (16, 39);
insert into order_desk_drink (id_order, id_drink) values (17, 92);
insert into order_desk_drink (id_order, id_drink) values (17, 34);
insert into order_desk_drink (id_order, id_drink) values (18, 92);
insert into order_desk_drink (id_order, id_drink) values (18, 28);
insert into order_desk_drink (id_order, id_drink) values (19, 92);
insert into order_desk_drink (id_order, id_drink) values (19, 22);
insert into order_desk_drink (id_order, id_drink) values (20, 92);
insert into order_desk_drink (id_order, id_drink) values (20, 19);

insert into snack_order_desk (id_snack, id_order) values (1, 1);
insert into snack_order_desk (id_snack, id_order) values (15, 2);
insert into snack_order_desk (id_snack, id_order) values (2, 3);
insert into snack_order_desk (id_snack, id_order) values (10, 4);
insert into snack_order_desk (id_snack, id_order) values (11, 5);
insert into snack_order_desk (id_snack, id_order) values (3, 6);
insert into snack_order_desk (id_snack, id_order) values (4, 8);
insert into snack_order_desk (id_snack, id_order) values (9, 9);
insert into snack_order_desk (id_snack, id_order) values (7, 10);
insert into snack_order_desk (id_snack, id_order) values (7, 12);
insert into snack_order_desk (id_snack, id_order) values (6, 13);
insert into snack_order_desk (id_snack, id_order) values (13, 14);
insert into snack_order_desk (id_snack, id_order) values (15, 15);
insert into snack_order_desk (id_snack, id_order) values (12, 16);
insert into snack_order_desk (id_snack, id_order) values (8, 17);
insert into snack_order_desk (id_snack, id_order) values (9, 18);
insert into snack_order_desk (id_snack, id_order) values (9, 20);