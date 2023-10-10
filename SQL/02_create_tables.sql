CREATE TABLE game.conversation (
    id integer NOT NULL,
    person_id integer,
    info character varying(5000)
);


ALTER TABLE game.conversation OWNER TO postgres;


CREATE TABLE game.inventory (
    id integer NOT NULL,
    item character varying(50),
    origin character varying(50)
);


ALTER TABLE game.inventory OWNER TO postgres;


CREATE TABLE game.item (
    id integer NOT NULL,
    person_id integer,
    item character varying(50),
    explanation character varying(500),
    bonus_flag character varying(1)
);


ALTER TABLE game.item OWNER TO postgres;


CREATE TABLE game.kill_strategy (
    id integer NOT NULL,
    strategy character varying(250)
);


ALTER TABLE game.kill_strategy OWNER TO postgres;


CREATE TABLE game.location (
    id integer NOT NULL,
    name character varying(50),
    location_type character varying(50),
    location_parent_id integer
);


ALTER TABLE game.location OWNER TO postgres;


CREATE TABLE game.message (
    id integer NOT NULL,
    message_type character varying(20),
    message character varying(500)
);


ALTER TABLE game.message OWNER TO postgres;


CREATE TABLE game.monster (
    id integer NOT NULL,
    item character varying(50),
    strength character varying(50),
    weakness character varying(50)
);


ALTER TABLE game.monster OWNER TO postgres;


CREATE TABLE game.my_solution (
    solution_date date,
    username character varying(50),
    message_type character varying(20),
    location_id integer,
    monster_id integer,
    kill_strategy_id integer,
    item_id character varying(10)
);


ALTER TABLE game.my_solution OWNER TO postgres;


CREATE TABLE game.person (
    id integer NOT NULL,
    name character varying(50),
    occupation character varying(50),
    location_id integer
);


ALTER TABLE game.person OWNER TO postgres;


CREATE TABLE game.quest (
    id integer NOT NULL,
    goal character varying(200),
    info character varying(5000),
    person_id integer
);


ALTER TABLE game.quest OWNER TO postgres;


CREATE TABLE game.solution (
    id integer NOT NULL,
    location_id integer,
    monster_id integer,
    kill_strategy_id integer
);


ALTER TABLE game.solution OWNER TO postgres;


CREATE TABLE game.solution_item (
    id integer NOT NULL,
    solution_id integer,
    item_id integer
);


ALTER TABLE game.solution_item OWNER TO postgres;


CREATE VIEW game.all_items AS
 SELECT item.id,
    item.item,
    item.explanation,
        CASE
            WHEN ((item.person_id IS NULL) AND ((item.bonus_flag)::text = 'N'::text)) THEN 'beach'::character varying
            WHEN ((item.person_id IS NULL) AND ((item.bonus_flag)::text = 'Y'::text)) THEN 'bonus'::character varying
            WHEN (item.person_id IS NOT NULL) THEN location.name
            ELSE 'unknown'::character varying
        END AS origin
   FROM ((game.item
     LEFT JOIN game.person ON ((item.person_id = person.id)))
     LEFT JOIN game.location ON ((person.location_id = location.id)));


ALTER TABLE game.all_items OWNER TO postgres;


CREATE VIEW game.beach_items AS
 SELECT item.id,
    item.item,
    item.explanation,
    'beach'::text AS origin
   FROM game.item
  WHERE ((item.person_id IS NULL) AND ((item.bonus_flag)::text = 'N'::text));


ALTER TABLE game.beach_items OWNER TO postgres;


CREATE VIEW game.location_overview AS
 WITH RECURSIVE location_overview(location_id, village, location, location_type) AS (
         SELECT location.id,
            location.name,
            location.name,
            location.location_type
           FROM game.location
          WHERE location.location_type::text = 'Village'::text
        UNION ALL
         SELECT l.id,
            lo.village,
            l.name,
            l.location_type
           FROM game.location l
             JOIN location_overview lo ON lo.location_id = l.location_parent_id
        )
 SELECT location_overview.location_id,
    location_overview.village,
    location_overview.location,
    location_overview.location_type
   FROM location_overview;

ALTER TABLE game.location_overview OWNER TO postgres;
