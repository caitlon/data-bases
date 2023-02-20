-- remove if there is a function to remove tables and sequences
DROP FUNCTION IF EXISTS remove_all();

-- I'll create a function that removes tables and sequences
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
-- I call a function that removes tables and sequences - I could drop the whole schema and recreate it, but we use PLSQL
select remove_all();

-- Remove conflicting tables
-- DROP TABLE IF EXISTS arbiter CASCADE;
-- DROP TABLE IF EXISTS assistent CASCADE;
-- DROP TABLE IF EXISTS bar CASCADE;
-- DROP TABLE IF EXISTS bartender CASCADE;
-- DROP TABLE IF EXISTS drink CASCADE;
-- DROP TABLE IF EXISTS guest CASCADE;
-- DROP TABLE IF EXISTS order_desk CASCADE;
-- DROP TABLE IF EXISTS snack CASCADE;
-- DROP TABLE IF EXISTS worker CASCADE;
-- DROP TABLE IF EXISTS order_desk_drink CASCADE;
-- DROP TABLE IF EXISTS snack_order_desk CASCADE;
-- End of removing

CREATE TABLE arbiter (
    id_worker INTEGER NOT NULL,
    id_bar INTEGER NOT NULL,
    additional_role VARCHAR(100)
);
ALTER TABLE arbiter ADD CONSTRAINT pk_arbiter PRIMARY KEY (id_worker);
ALTER TABLE arbiter ADD CONSTRAINT u_fk_arbiter_bar UNIQUE (id_bar);

CREATE TABLE assistent (
    id_worker INTEGER NOT NULL
);
ALTER TABLE assistent ADD CONSTRAINT pk_assistent PRIMARY KEY (id_worker);

CREATE TABLE bar (
    id_bar SERIAL NOT NULL,
    name VARCHAR(50) NOT NULL,
    rules VARCHAR(256) NOT NULL,
    description VARCHAR(256) NOT NULL
);
ALTER TABLE bar ADD CONSTRAINT pk_bar PRIMARY KEY (id_bar);

CREATE TABLE bartender (
    id_worker INTEGER NOT NULL
);
ALTER TABLE bartender ADD CONSTRAINT pk_bartender PRIMARY KEY (id_worker);

CREATE TABLE drink (
    id_drink SERIAL NOT NULL,
    type VARCHAR(50) NOT NULL,
    sort VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    volume_of_alcohol REAL
);
ALTER TABLE drink ADD CONSTRAINT pk_drink PRIMARY KEY (id_drink);

CREATE TABLE guest (
    id_guest SERIAL NOT NULL,
    id_worker INTEGER NOT NULL,
    arbiter_id_worker INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    cause_of_death VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    guest_prehistory VARCHAR(256) NOT NULL,
    game VARCHAR(100) NOT NULL,
    behaviour_during_game VARCHAR(256) NOT NULL,
    verdict VARCHAR(100) NOT NULL
);
ALTER TABLE guest ADD CONSTRAINT pk_guest PRIMARY KEY (id_guest);

CREATE TABLE order_desk (
    id_order SERIAL NOT NULL,
    id_worker INTEGER NOT NULL,
    id_guest INTEGER,
    worker_id_worker INTEGER
);
ALTER TABLE order_desk ADD CONSTRAINT pk_order_desk PRIMARY KEY (id_order);

CREATE TABLE snack (
    id_snack SERIAL NOT NULL,
    name VARCHAR(100) NOT NULL
);
ALTER TABLE snack ADD CONSTRAINT pk_snack PRIMARY KEY (id_snack);

CREATE TABLE worker (
    id_worker SERIAL NOT NULL,
    id_bar INTEGER NOT NULL,
    name VARCHAR(50) NOT NULL
);
ALTER TABLE worker ADD CONSTRAINT pk_worker PRIMARY KEY (id_worker);

CREATE TABLE order_desk_drink (
    id_order INTEGER NOT NULL,
    id_drink INTEGER NOT NULL
);
ALTER TABLE order_desk_drink ADD CONSTRAINT pk_order_desk_drink PRIMARY KEY (id_order, id_drink);

CREATE TABLE snack_order_desk (
    id_snack INTEGER NOT NULL,
    id_order INTEGER NOT NULL
);
ALTER TABLE snack_order_desk ADD CONSTRAINT pk_snack_order_desk PRIMARY KEY (id_snack, id_order);

ALTER TABLE arbiter ADD CONSTRAINT fk_arbiter_worker FOREIGN KEY (id_worker) REFERENCES worker (id_worker) ON DELETE CASCADE;
ALTER TABLE arbiter ADD CONSTRAINT fk_arbiter_bar FOREIGN KEY (id_bar) REFERENCES bar (id_bar) ON DELETE CASCADE;

ALTER TABLE assistent ADD CONSTRAINT fk_assistent_worker FOREIGN KEY (id_worker) REFERENCES worker (id_worker) ON DELETE CASCADE;

ALTER TABLE bartender ADD CONSTRAINT fk_bartender_worker FOREIGN KEY (id_worker) REFERENCES worker (id_worker) ON DELETE CASCADE;

ALTER TABLE guest ADD CONSTRAINT fk_guest_assistent FOREIGN KEY (id_worker) REFERENCES assistent (id_worker) ON DELETE CASCADE;
ALTER TABLE guest ADD CONSTRAINT fk_guest_arbiter FOREIGN KEY (arbiter_id_worker) REFERENCES arbiter (id_worker) ON DELETE CASCADE;

ALTER TABLE order_desk ADD CONSTRAINT fk_order_desk_bartender FOREIGN KEY (id_worker) REFERENCES bartender (id_worker) ON DELETE CASCADE;
ALTER TABLE order_desk ADD CONSTRAINT fk_order_desk_guest FOREIGN KEY (id_guest) REFERENCES guest (id_guest) ON DELETE CASCADE;
ALTER TABLE order_desk ADD CONSTRAINT fk_order_desk_worker FOREIGN KEY (worker_id_worker) REFERENCES worker (id_worker) ON DELETE CASCADE;

ALTER TABLE worker ADD CONSTRAINT fk_worker_bar FOREIGN KEY (id_bar) REFERENCES bar (id_bar) ON DELETE CASCADE;

ALTER TABLE order_desk_drink ADD CONSTRAINT fk_order_desk_drink_order_desk FOREIGN KEY (id_order) REFERENCES order_desk (id_order) ON DELETE CASCADE;
ALTER TABLE order_desk_drink ADD CONSTRAINT fk_order_desk_drink_drink FOREIGN KEY (id_drink) REFERENCES drink (id_drink) ON DELETE CASCADE;

ALTER TABLE snack_order_desk ADD CONSTRAINT fk_snack_order_desk_snack FOREIGN KEY (id_snack) REFERENCES snack (id_snack) ON DELETE CASCADE;
ALTER TABLE snack_order_desk ADD CONSTRAINT fk_snack_order_desk_order_desk FOREIGN KEY (id_order) REFERENCES order_desk (id_order) ON DELETE CASCADE;

