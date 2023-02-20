-- 1. List name, date of birth ( date_of_birth ) and cause of death ( cause_of_death ) of the guest,
-- who played billiards and his soul was sent into oblivion.
SELECT DISTINCT name, date_of_birth, cause_of_death
FROM guest
WHERE game = 'Billiards' AND verdict = 'Sent into oblivion.';

-- 2. List all guests' attributes who played poker.
SELECT DISTINCT *
FROM guest
WHERE game = 'Poker';

-- 3. What game was played by guest Kaori Miyazono.
SELECT DISTINCT game
FROM guest
WHERE name = 'Kaori Miyazono';

-- 4. List guest's name and prehistory ( guest_prehistory ) whose death was caused by heart attack.
SELECT DISTINCT name, guest_prehistory
FROM guest
WHERE cause_of_death = 'Death caused by heart attack.';

-- 5. Number of guests visited the bar.
SELECT COUNT(id_guest) AS number_of_guests
FROM guest;

-- 6. List snack's name that was never ordered.
-- using except
SELECT DISTINCT name AS snack
FROM
    (   SELECT  *
        FROM snack
        EXCEPT
        SELECT  id_snack, name
        FROM snack
        NATURAL JOIN snack_order_desk
    ) snack_was_not_ordered;

-- using not exists
SELECT DISTINCT name AS snack
FROM snack
    WHERE NOT EXISTS
        (   SELECT DISTINCT *
            FROM snack_order_desk
            WHERE snack_order_desk.id_snack = snack.id_snack
        );

-- using not in
SELECT DISTINCT name AS snack
FROM snack
WHERE id_snack NOT IN
        (   SELECT DISTINCT id_snack
            FROM snack_order_desk
        );

-- 7. List all guest's attributes who has ordered Absinthe or Vermouth.
SELECT DISTINCT guest.*
FROM
(
    SELECT DISTINCT id_guest
    FROM
       (
        SELECT DISTINCT order_desk.*
        FROM order_desk
        JOIN order_desk_drink USING(id_order)
        JOIN drink USING(id_drink)
        WHERE sort = 'Absinthe'
        UNION
        SELECT DISTINCT order_desk.*
        FROM order_desk
        JOIN order_desk_drink USING(id_order)
        JOIN drink USING(id_drink)
        WHERE sort = 'Vermouth'
        ) table_union
) in_total

NATURAL JOIN guest;

-- 8. List all worker's attributes who has ordered all sorts of wine (Red Wine, White Wine and Rose Wine).
SELECT DISTINCT worker.*
FROM
(
    SELECT DISTINCT worker_id_worker AS id_worker
    FROM
    (
        SELECT DISTINCT order_desk.*
        FROM order_desk
        JOIN order_desk_drink using(id_order)
        JOIN drink using(id_drink)
        WHERE sort = 'Red Wine'
        INTERSECT
        SELECT DISTINCT order_desk.*
        FROM order_desk
        JOIN order_desk_drink using(id_order)
        JOIN drink using(id_drink)
        WHERE sort = 'White Wine'
        INTERSECT
        SELECT DISTINCT order_desk.*
        FROM order_desk
        JOIN order_desk_drink using(id_order)
        JOIN drink using(id_drink)
        WHERE sort = 'Red Wine'
        ) table_intersect
) in_total
NATURAL JOIN worker;

-- 9. What guest ordered only cocktail "Virgin Strawberry Daiquiri". List all guest's attributes.
SELECT g.*
FROM guest g
JOIN order_desk od using ( id_guest )
JOIN order_desk_drink odd using ( id_order )
JOIN drink d using ( id_drink )
WHERE d.name = 'Virgin Strawberry Daiquiri'
except
SELECT g1.*
FROM guest g1
JOIN order_desk od1 using ( id_guest )
JOIN order_desk_drink odd1 using ( id_order )
JOIN drink d1 using ( id_drink )
WHERE d1.name != 'Virgin Strawberry Daiquiri';

-- 10. Amount of options for combining all drinks and snacks.
SELECT COUNT(*) AS amount_of_options
FROM
(   SELECT DISTINCT snack.*,
                    drink.*
    FROM snack
    CROSS JOIN drink
)table_amount;

-- 11. Name of the snack that guest Maes Hughes has ordered.
SELECT DISTINCT name
FROM ( SELECT DISTINCT id_guest, id_order
       FROM ( SELECT DISTINCT
                        table_guest.*,
                        order_desk.id_order,
                        order_desk.id_worker AS id_worker_1,
                        order_desk.id_guest AS id_guest_1,
                        order_desk.worker_id_worker
        FROM
            (   SELECT DISTINCT * FROM guest
                WHERE name = 'Maes Hughes'
            ) table_guest
        JOIN order_desk ON table_guest.id_guest = order_desk.id_order
    ) in_total
) fin_res
NATURAL JOIN snack_order_desk
NATURAL JOIN snack;

-- 12. Group drinks related to sort Wine, Cocktail and Beer, as their sum of degree in drinks decreases,
-- indicate sort and total sum of degree in drinks( total_sum_of_degree ).
-- Do not list information about Light Beer.
SELECT sort, sum(volume_of_alcohol) as total_sum_of_degree
FROM drink
WHERE sort LIKE '%Wine' or sort LIKE '%Beer' or sort = 'Cocktail'
GROUP BY sort
HAVING sort != 'Light Beer'
ORDER BY total_sum_of_degree DESC;

-- 13. Worker who has ordered all drinks related to sort 'Vodka'. List all attributes.
-- ( Worker who doesn't have a sort of 'Vodka', that he doesn't order. )
SELECT w.*
FROM worker w
WHERE NOT EXISTS
(
    SELECT *
    FROM drink d
    WHERE d.sort = 'Vodka' AND NOT EXISTS
    (
        SELECT *
        FROM order_desk od
        JOIN order_desk_drink odd using ( id_order )
        WHERE od.worker_id_worker = w.id_worker and odd.id_drink = d.id_drink
    )
);

-- 14. Category D1 query check.
SELECT d.*
FROM drink d WHERE sort = 'Vodka'
except
SELECT dd.*
FROM drink dd
WHERE EXISTS ( select * from worker ww where ww.id_worker =
(
SELECT w.id_worker
FROM worker w
WHERE NOT EXISTS
(
    SELECT *
    FROM drink d
    WHERE d.sort = 'Vodka' AND NOT EXISTS
    (
        SELECT *
        FROM order_desk od
        JOIN order_desk_drink odd using ( id_order )
        WHERE od.worker_id_worker = w.id_worker AND odd.id_drink = d.id_drink
    )
)));

-- 15. List all guests and all their orders records, if guest doesn't have any order anyway list him/her.
-- Specify information about guests including id_guest, guetst's name, cause_of_death, date_of_birth,
-- guest_prehistory, game, behaviour_during_game and verdict, and only id_order and id_worker who served
-- the guest. Result sort by id_guest ascending.
begin;

INSERT into guest (id_guest, id_worker, arbiter_id_worker,
                   name, cause_of_death, date_of_birth,
                   guest_prehistory, game,
                   behaviour_during_game, verdict) values (21, 2, 1, 'Katya Biser',
                                                           'Hart attack caused by BI-DBS.', '2001-05-04',
                                                           'Was too active.',
                                                           'Tower attack', 'Broke the pyramid on the move of the opponent, while he was distracted to snatch the victory.',
                                                           'Sent to reincarnation.');

SELECT DISTINCT   guest.id_guest, name, cause_of_death,
                  date_of_birth, guest_prehistory, game,
                  behaviour_during_game, verdict,
                  id_order, order_desk.id_worker
FROM guest
LEFT JOIN order_desk ON (guest.id_guest = order_desk.id_guest)
ORDER BY id_guest ASC;
rollback;

-- 16. Select all snacks and all orders, even those snacks that were never ordered and worker
-- who served order. Indicate id_snack, snaks' name and id_order. Result sort by id_snack ascending.
SELECT DISTINCT s.id_snack, s.name, id_order, w.id_worker
FROM snack s
left JOIN snack_order_desk ON (s.id_snack = snack_order_desk.id_snack)
left JOIN order_desk using ( id_order )
full join worker w using ( id_worker )
ORDER BY s.id_snack ASC;

-- 17. Create a view of strong beverages ( named strong_beverages ) - drinks which volume of alcohol
-- ( volume_of_alcohol ) is above 50 percent. Result sort by volume_of_alcohol decreasing.
CREATE OR replace view strong_beverages AS
(   SELECT *
    FROM drink
    WHERE volume_of_alcohol > 50
    ORDER BY volume_of_alcohol DESC
)
WITH CHECK OPTION;

-- 18. List all strong beverages.
SELECT * FROM strong_beverages;

-- 19. List all bar workers with their atrributes ( id_worker, id_bar, name ).
SELECT *
FROM worker

-- 20. Delete all snacks that were never ordered.
begin;

DELETE FROM snack
WHERE id_snack IN
    (
        SELECT id_snack FROM snack
        WHERE id_snack NOT IN
            (
                SELECT id_snack FROM snack_order_desk
            )
    );

rollback;

-- 21. An error occurred while entering drinks' volume of alcohol what strength exceeds 50 degrees,
-- you need to increase their volume of alcohol by 0.5.
begin;

UPDATE drink
SET volume_of_alcohol = volume_of_alcohol + 0.5
WHERE id_drink IN
    (
        SELECT id_drink
        FROM order_desk_drink
        WHERE volume_of_alcohol > 50
    );

rollback;

-- 22. How many sorts of drinks and snacks are presented in the bar.
SELECT COUNT(id_drink) as sorts_of_drinks
FROM drink;

SELECT COUNT(id_snack) as sorts_of_snacks
FROM snack;

-- 23. Average volume of alcohol in the first order in which an alcoholic drink was ordered in relation
-- to all ordered drinks, i.e. how many degrees would be approximately for that order.
SELECT DISTINCT id_order,
(
    SELECT AVG(volume_of_alcohol)
    FROM drink
    JOIN order_desk_drink using(id_drink)
) as average_volume_of_alcohol_in_order
FROM order_desk
ORDER BY id_order ASC, id_order limit 1;

-- 24. Insert a random drink into a random order_desk_drink.
begin;

INSERT into order_desk_drink
(
    SELECT id_order, id_drink
    FROM
    (
        SELECT drink.id_drink,
               order_desk_drink.id_order
        FROM drink CROSS JOIN order_desk_drink
    ) as drink_order

    ORDER BY random() limit 1
);

rollback;

-- 25. List orders' id served by bartender ascending.
SELECT DISTINCT id_order
FROM order_desk
JOIN bartender ON (bartender.id_worker = order_desk.id_worker)
ORDER BY id_order ASC;

