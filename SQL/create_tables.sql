--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

-- Started on 2023-08-17 18:37:18

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16590)
-- Name: game; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA game;


ALTER SCHEMA game OWNER TO postgres;

--
-- TOC entry 240 (class 1255 OID 16595)
-- Name: add_to_inventory(integer); Type: FUNCTION; Schema: game; Owner: postgres
--

CREATE FUNCTION game.add_to_inventory(p_item_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$	
DECLARE 
	v_item varchar(50);
	v_item_id int;
	v_inventory_id int;
	
BEGIN
	Select id into v_item_id
	from game.all_items
	where id = p_item_id;

	Select id into v_inventory_id
	from game.inventory 
	where username = USER 
	and item = (select item from game.item where id = p_item_id);

-- when the item doesn't exist, nothing happens
	IF (v_item_id is null)
		then
			return 'You must be crosseyed, there is no such thing as that found here' ;

-- when you don't have the item in your inventory it is added 
	ELSIF (v_inventory_id is null)
		then
			insert into game.inventory (id,item, origin, username)
			select id, item, origin, USER
			from game.all_items
			where id = p_item_id;

			select item into v_item from game.inventory where id = v_item_id;

			return 'Good job, you have succesfully added ' || v_item || ' to your inventory';

-- when you allready have the item in your inventory, nothing happens
		ELSE 
			select item into v_item from game.inventory where id = v_inventory_id;
			return 'Pay attention! You have already added ' || v_item || ' to your inventory';	
		END if;	

END$$;


ALTER FUNCTION game.add_to_inventory(p_item_id integer) OWNER TO postgres;

--
-- TOC entry 241 (class 1255 OID 16596)
-- Name: check_solution(integer, integer, integer); Type: FUNCTION; Schema: game; Owner: postgres
--

CREATE FUNCTION game.check_solution(p_loc_id integer, p_mnstr_id integer, p_strat_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE 
	v_limit int;
	v_item int;
	v_solution int;
	v_solution_wm int;
	v_solution_ws int;
	v_solution_wl int;
	v_inventory_item int;
BEGIN

	select COUNT(*) into v_limit
	from game.my_solution
	where message_type != 'SUCCESS'
	and solution_date = CURRENT_DATE
	and username = USER;

	select id into v_solution
	from game.solution 
	where location_id = p_loc_id
	and monster_id = p_mnstr_id
	and kill_strategy_id = p_strat_id;

	select id into v_solution_wm
	from game.solution 
	where location_id = p_loc_id
	and monster_id != p_mnstr_id
	and kill_strategy_id = p_strat_id;

	select id into v_solution_ws
	from game.solution 
	where location_id = p_loc_id
	and monster_id = p_mnstr_id
	and kill_strategy_id != p_strat_id;

	select id into v_solution_wl
	from game.solution 
	where location_id != p_loc_id
	and monster_id = p_mnstr_id
	and kill_strategy_id = p_strat_id;

-- LIMIT EXCEEDED
-- To minimize gambling you get 3 wrong tries per day
	if v_limit >= 3
		then
			return game.get_message('LIMIT_EXCEEDED');

-- SUCCESS
-- First check if the location, monster and strategy are correct
-- If location, monster and strategy are correct, check if there are necessary items
	elsif (v_solution is not null)
		then
			select item_id into v_item
			from game.solution 
			where id = v_solution;
	
	-- If there are no necessary items -> SUCCESS
			IF (v_item is null)
				then
					perform game.insert_solution('SUCCESS', p_loc_id, p_mnstr_id, p_strat_id);
					return game.get_message('SUCCESS') ;
			
	-- If there are necessary items, check if they are in the inventory		
			elsif (v_item is not null)
				then
					select id into v_inventory_item
					from game.inventory
					where id = v_item;
	
	-- If the item is in the inventory -> SUCCESS
					IF (v_inventory_item is not null)
						then
							perform game.insert_solution('SUCCESS', p_loc_id, p_mnstr_id, p_strat_id, v_inventory_item);
							return game.get_message('SUCCESS');
		
	-- If not -> MISSING ITEM
					ELSE 	
						perform game.insert_solution('MISSING_ITEM', p_loc_id, p_mnstr_id, p_strat_id);
						return game.get_message('MISSING_ITEM');
					end if;	
			end if;		

-- WRONG MONSTER
-- The location and strategy are correct, but the monster isn't
	elsif (v_solution_wm is not null)
		then
			perform game.insert_solution('WRONG_MONSTER', p_loc_id, p_mnstr_id, p_strat_id);
			return game.get_message('WRONG_MONSTER');
			
-- WRONG STRATEGY
-- The location and monster are correct, but the strategy isn't
	elsif (v_solution_ws is not null)
		then
			perform game.insert_solution('WRONG_STRATEGY', p_loc_id, p_mnstr_id, p_strat_id);
			return game.get_message('WRONG_STRATEGY') ;
			
-- WRONG LOCATION
-- The monster and strategy are correct, but the location isn't
	elsif (v_solution_wl is not null)
		then
			perform game.insert_solution('WRONG_LOCATION', p_loc_id, p_mnstr_id, p_strat_id);
			return game.get_message('WRONG_LOCATION') ;
			
-- EPIC FAILURE
-- Nothing is correct
	ELSE 
		perform game.insert_solution('EPIC_FAIL', p_loc_id, p_mnstr_id, p_strat_id);
		return game.get_message('EPIC_FAIL');
	end if;
	
END 
$$;


ALTER FUNCTION game.check_solution(p_loc_id integer, p_mnstr_id integer, p_strat_id integer) OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 16597)
-- Name: get_message(character varying); Type: FUNCTION; Schema: game; Owner: postgres
--

CREATE FUNCTION game.get_message(p_msg_type character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
	msg varchar;
begin
	SELECT message 
	INTO msg
	FROM game.solution_message
	WHERE message_type = p_msg_type;
	
	return msg;
end 
$$;


ALTER FUNCTION game.get_message(p_msg_type character varying) OWNER TO postgres;

--
-- TOC entry 242 (class 1255 OID 16598)
-- Name: insert_solution(character varying, integer, integer, integer, integer); Type: FUNCTION; Schema: game; Owner: postgres
--

CREATE FUNCTION game.insert_solution(p_msg_type character varying, p_loc_id integer, p_monster_id integer, p_strategy_id integer, p_item_id integer DEFAULT NULL::integer) RETURNS void
    LANGUAGE sql
    AS $$
INSERT INTO game.my_solution VALUES (CURRENT_DATE, USER, p_msg_type, p_loc_id, p_monster_id, p_strategy_id, p_item_id);
$$;


ALTER FUNCTION game.insert_solution(p_msg_type character varying, p_loc_id integer, p_monster_id integer, p_strategy_id integer, p_item_id integer) OWNER TO postgres;

--
-- TOC entry 239 (class 1255 OID 16599)
-- Name: sp_check_solution(numeric, numeric, numeric); Type: PROCEDURE; Schema: game; Owner: postgres
--

CREATE PROCEDURE game.sp_check_solution(IN location_id numeric, IN monster_id numeric, IN kill_strategy_id numeric, OUT message character varying)
    LANGUAGE plpgsql
    AS $$
	DECLARE lim int;
	DECLARE item int;
	DECLARE solution int;
	DECLARE solution_wm int;
	DECLARE solution_ws int;
	DECLARE solution_wl int;
	DECLARE inventory_item int;
BEGIN

	select COUNT(*) into lim
	from game.my_solution
	where message_type != 'SUCCESS'
	and solution_date = (SELECT CAST( GETDATE() AS Date ))
	and username = SYSTEM_USER;

	select id into solution
	from game.solution 
	where location_id = location_id
	and monster_id = monster_id
	and kill_strategy_id = kill_strategy_id;

	select id into solution_wm
	from game.solution 
	where location_id = location_id
	and monster_id != monster_id
	and kill_strategy_id = kill_strategy_id;

	select id into solution_ws
	from game.solution 
	where location_id = location_id
	and monster_id = monster_id
	and kill_strategy_id != kill_strategy_id;

	select id into solution_wl
	from game.solution 
	where location_id != location_id
	and monster_id = monster_id
	and kill_strategy_id = kill_strategy_id;

-- LIMIT EXCEEDED
-- To minimize gambling you get 3 wrong tries per day
	if lim >= 3
		then
			SELECT message into message
			FROM game.solution_message
			WHERE message_type = 'LIMIT_EXCEEDED';
			

-- SUCCESS
-- First check if the location, monster and strategy are correct
-- If location, monster and strategy are correct, check if there are necessary items
	elsif (solution is not null)
		then
			select item_id into item
			from game.solution 
			where id = solution;
	
	-- If there are no necessary items -> SUCCESS
			IF (item is null)
				then
					INSERT INTO game.my_solution VALUES (CAST( GETDATE() AS Date ), SYSTEM_USER, 'SUCCESS', location_id, monster_id, kill_strategy_id, NULL);

					SELECT message into message
					FROM game.solution_message
					WHERE message_type = 'SUCCESS';	
			
	-- If there are necessary items, check if they are in the inventory		
			elsif (item is not null)
				then
					select id into inventory_item
					from game.inventory
					where id = item;
	
	-- If the item is in the inventory -> SUCCESS
					IF (inventory_item is not null)
						then
							INSERT INTO game.my_solution VALUES (CAST( GETDATE() AS Date ), SYSTEM_USER, 'SUCCESS', location_id, monster_id, kill_strategy_id, inventory_item);
					
							SELECT message into message
							FROM game.solution_message
							WHERE message_type = 'SUCCESS';
		
	-- If not -> MISSING ITEM
					ELSE 	
						INSERT INTO game.my_solution VALUES (CAST( GETDATE() AS Date ), SYSTEM_USER, 'MISSING_ITEM', location_id, monster_id, kill_strategy_id, inventory_item);

						SELECT message into message
						FROM game.solution_message
						WHERE message_type = 'MISSING_ITEM';
					end if;	
			end if;		

-- WRONG MONSTER
-- The location and strategy are correct, but the monster isn't
	elsif (solution_wm is not null)
		then
			INSERT INTO game.my_solution VALUES (CAST( GETDATE() AS Date ), SYSTEM_USER, 'WRONG_MONSTER', location_id, monster_id, kill_strategy_id, inventory_item);

			SELECT message into message
			FROM game.solution_message
			WHERE message_type = 'WRONG_MONSTER';
			
-- WRONG STRATEGY
-- The location and monster are correct, but the strategy isn't
	elsif (solution_ws is not null)
		then
			INSERT INTO game.my_solution VALUES (CAST( GETDATE() AS Date ), SYSTEM_USER, 'WRONG_STRATEGY', location_id, monster_id, kill_strategy_id, inventory_item);

			SELECT message into message
			FROM game.solution_message
			WHERE message_type = 'WRONG_STRATEGY';
			
-- WRONG LOCATION
-- The monster and strategy are correct, but the location isn't
	elsif (solution_wl is not null)
		then
			INSERT INTO game.my_solution VALUES (CAST( GETDATE() AS Date ), SYSTEM_USER, 'WRONG_LOCATION', location_id, monster_id, kill_strategy_id, inventory_item);

			SELECT message into message
			FROM game.solution_message
			WHERE message_type = 'WRONG_LOCATION';
			
-- EPIC FAILURE
-- Nothing is correct
	ELSE 
		INSERT INTO game.my_solution VALUES (CAST( GETDATE() AS Date ), SYSTEM_USER, 'EPIC_FAIL', location_id, monster_id, kill_strategy_id, inventory_item);

		SELECT message into message
		FROM game.solution_message
		WHERE message_type = 'EPIC_FAIL';
	end if;

END; $$;


ALTER PROCEDURE game.sp_check_solution(IN location_id numeric, IN monster_id numeric, IN kill_strategy_id numeric, OUT message character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16600)
-- Name: item; Type: TABLE; Schema: game; Owner: postgres
--

CREATE TABLE game.item (
    id integer NOT NULL,
    person_id integer,
    item character varying(50),
    explanation character varying(500),
    bonus_flag character varying(1)
);


ALTER TABLE game.item OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16605)
-- Name: location; Type: TABLE; Schema: game; Owner: postgres
--

CREATE TABLE game.location (
    id integer NOT NULL,
    name character varying(50),
    location_type character varying(50),
    location_parent_id integer
);


ALTER TABLE game.location OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16608)
-- Name: person; Type: TABLE; Schema: game; Owner: postgres
--

CREATE TABLE game.person (
    id integer NOT NULL,
    name character varying(50),
    occupation character varying(50),
    location_id integer
);


ALTER TABLE game.person OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16611)
-- Name: all_items; Type: VIEW; Schema: game; Owner: postgres
--

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

--
-- TOC entry 219 (class 1259 OID 16616)
-- Name: beach_items; Type: VIEW; Schema: game; Owner: postgres
--

CREATE VIEW game.beach_items AS
 SELECT item.id,
    item.item,
    item.explanation,
    'beach'::text AS origin
   FROM game.item
  WHERE ((item.person_id IS NULL) AND ((item.bonus_flag)::text = 'N'::text));


ALTER TABLE game.beach_items OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16620)
-- Name: inventory; Type: TABLE; Schema: game; Owner: postgres
--

CREATE TABLE game.inventory (
    id integer NOT NULL,
    item character varying(50),
    origin character varying(50),
    username character varying(50)
);


ALTER TABLE game.inventory OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16623)
-- Name: kill_strategy; Type: TABLE; Schema: game; Owner: postgres
--

CREATE TABLE game.kill_strategy (
    id integer NOT NULL,
    strategy character varying(250)
);


ALTER TABLE game.kill_strategy OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16626)
-- Name: monster; Type: TABLE; Schema: game; Owner: postgres
--

CREATE TABLE game.monster (
    id integer NOT NULL,
    item character varying(50),
    strength character varying(50),
    weakness character varying(50)
);


ALTER TABLE game.monster OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16629)
-- Name: my_solution; Type: TABLE; Schema: game; Owner: postgres
--

CREATE TABLE game.my_solution (
    solution_date date,
    username character varying(50),
    message_type character varying(20),
    location_id integer,
    monster_id integer,
    kill_strategy_id integer,
    item_id integer
);


ALTER TABLE game.my_solution OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16632)
-- Name: quest; Type: TABLE; Schema: game; Owner: postgres
--

CREATE TABLE game.quest (
    id integer NOT NULL,
    person_id integer,
    quest character varying(5000)
);


ALTER TABLE game.quest OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16637)
-- Name: solution; Type: TABLE; Schema: game; Owner: postgres
--

CREATE TABLE game.solution (
    id integer NOT NULL,
    location_id integer,
    monster_id integer,
    kill_strategy_id integer,
    item_id integer
);


ALTER TABLE game.solution OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16640)
-- Name: solution_message; Type: TABLE; Schema: game; Owner: postgres
--

CREATE TABLE game.solution_message (
    id integer NOT NULL,
    message_type character varying(20),
    message character varying(500)
);


ALTER TABLE game.solution_message OWNER TO postgres;

--
-- TOC entry 3395 (class 0 OID 16620)
-- Dependencies: 220
-- Data for Name: inventory; Type: TABLE DATA; Schema: game; Owner: postgres
--

COPY game.inventory (id, item, origin, username) FROM stdin;
1	driftwood	beach	postgres
\.


--
-- TOC entry 3392 (class 0 OID 16600)
-- Dependencies: 215
-- Data for Name: item; Type: TABLE DATA; Schema: game; Owner: postgres
--

COPY game.item (id, person_id, item, explanation, bonus_flag) FROM stdin;
1	\N	driftwood	Can be used for making a fire or building a shelter.	N
2	\N	small knife	\N	N
3	\N	matches	When you drank the whisky or the rum, you can use this with the paper to write a message in a bottle.	N
4	\N	clothes	You never know when you might wet your pants and need a fresh pair.	N
5	\N	rope	\N	N
6	\N	paper	When you drank the whisky or the rum, you can use this with the matches to write a message in a bottle.	N
7	\N	candle	A little light in the darkness. Can be used to check for monsters under your bed.	N
8	\N	plate	It can't hurt to be civilized even when you are on a strange island.	N
9	\N	cup	It beats drinking out of your hand. But straight from the bottle would be even better.	N
10	\N	whisky	Aged single malt scottish whisky. Can be used to clean wounds, numb pain and act as liquid courage.	N
11	\N	rum	\N	N
12	\N	bag of coins	\N	N
100	4	iris	Noble flower, symbolises faith, courage, valour, hope and wisdom	N
101	4	rose	Symbolises love, affection and beauty.	N
102	4	lily	Tall, majestic and resilient.	N
103	4	poppy	Powerfull narcotic.	N
104	20	cucumber	Very delicious and nutricious	N
105	20	local lettuce	Local delicacy. Can be used to lure snails.	N
106	20	gherkin	Pickled baby cucumber.	N
107	20	pickle	Pickled cucumber.	N
108	5	lute	Stringed instrument, the name is derived from the Arabic "el lud", meaning "the wood".	N
109	5	harp	Stringed instrument.	N
110	5	drum	Percussion instrument.	N
111	5	ukulele	Stringed instrument, looks like a small guitar, originates from Hawaii.	N
112	5	cajon	Percussion instrument, mostly used to accompany flamenco dancers.	N
113	5	zither	Stringed instrument.	N
114	5	balalaika	Stringed instrument.	N
\.


--
-- TOC entry 3396 (class 0 OID 16623)
-- Dependencies: 221
-- Data for Name: kill_strategy; Type: TABLE DATA; Schema: game; Owner: postgres
--

COPY game.kill_strategy (id, strategy) FROM stdin;
1	Drop a rock on its head
2	Tickle till it giggles helplessly
3	Stomp on it
4	Bore it to death with tedious jokes
5	Kill it with kindness
6	Clone yourself and let the clone do the killing
7	Use a BFG9000 to blast it to smithereens
8	Huff and puff and blow the house down on top of it
9	Burn it to a crisp
10	Barf on it
11	Lock it in a dungeon untill it starves to death
12	Wrap in tinfoil and zap it in de microwave
13	Stick it with the pointy end
14	Sing songs untill its ears blead
15	Hire the divorse attorney of your ex
16	Poison it
17	Lure it to a saltmine with the local lettuce and let it melt nothing
\.


--
-- TOC entry 3393 (class 0 OID 16605)
-- Dependencies: 216
-- Data for Name: location; Type: TABLE DATA; Schema: game; Owner: postgres
--

COPY game.location (id, name, location_type, location_parent_id) FROM stdin;
1	SQL Island	Island	\N
2	Quatroformaggio	Village	1
3	Bloodwolves	Inn	11
4	Horse and Dragon	Inn	6
5	Hollow Bears	Inn	13
6	Aintree	Village	1
7	The Ugly Giraffe Inn	Inn	11
8	Sleepy Shark Pub	Inn	17
9	The Lions	Inn	2
10	Sun and Moon Pub	Inn	16
11	Triopolis	Village	1
12	Heavenly Dancers	Inn	2
13	Two Rivers	Village	1
14	Pentagram	Village	1
15	The Laughing Cabbage Taver	Inn	2
16	Six Mile Creek	Village	1
17	Sevenoaks	Village	1
18	Saltmine	Mine	6
19	Bloodwolves	Inn	14
20	Two Notes	Musical shop	13
21	Cloud Nine City	Village	1
22	Sound of music	Music shop	13
23	Coalmine	Mine	6
\.


--
-- TOC entry 3397 (class 0 OID 16626)
-- Dependencies: 222
-- Data for Name: monster; Type: TABLE DATA; Schema: game; Owner: postgres
--

COPY game.monster (id, item, strength, weakness) FROM stdin;
9	Horrid harpies	\N	\N
25	Snails on speed	fast	local lettuce
\.


--
-- TOC entry 3398 (class 0 OID 16629)
-- Dependencies: 223
-- Data for Name: my_solution; Type: TABLE DATA; Schema: game; Owner: postgres
--

COPY game.my_solution (solution_date, username, message_type, location_id, monster_id, kill_strategy_id, item_id) FROM stdin;
2023-08-16	postgres	WRONG_MONSTER	18	9	17	\N
2023-08-16	postgres	SUCCESS	5	9	14	\N
2023-08-16	postgres	MISSING_ITEM	18	25	17	\N
2023-08-16	postgres	WRONG_STRATEGY	18	25	1	\N
\.


--
-- TOC entry 3394 (class 0 OID 16608)
-- Dependencies: 217
-- Data for Name: person; Type: TABLE DATA; Schema: game; Owner: postgres
--

COPY game.person (id, name, occupation, location_id) FROM stdin;
1	Nora Steel	\N	\N
2	Stevie Adams	\N	\N
3	Vicente Amigo	\N	\N
4	Lola Flores	market vendor	6
5	Ash Brown	shopkeeper	20
6	Harry Palmer	\N	\N
7	Duncan Stone	\N	\N
8	Stevie Palmer	\N	\N
9	Paco de Lucia	\N	\N
10	Estrella Morente	\N	\N
11	Finn Marshall	\N	\N
12	Mary Skinner	innkeeper	4
13	Luke King	\N	\N
14	Maria Robles	\N	\N
15	Carmen Linares	\N	\N
16	Prescott Knight	\N	\N
17	Pat Brown	innkeeper	5
18	La Perla de Cadiz	\N	\N
19	Patrick Hastings	\N	\N
20	Jesse Cook	market vendor	6
21	Carlos Montoya	\N	\N
22	Antonio Canales	\N	\N
23	Miguel Poveda	\N	\N
24	Tony Campbell	\N	\N
25	Alex Prescott	\N	\N
26	Lucy Fin	\N	\N
\.


--
-- TOC entry 3399 (class 0 OID 16632)
-- Dependencies: 224
-- Data for Name: quest; Type: TABLE DATA; Schema: game; Owner: postgres
--

COPY game.quest (id, person_id, quest) FROM stdin;
1	12	Lately, I find my Inn covered in slime in the mornings. It is quite a hassle to clean it off every day. The village elders suspect that we have a snail problem. \n\nI would like you to get rid of these snails for me. Then I will tell you what you need to know. \n\nBut be aware that they are super fast. They will only slow down when they can eat some of our local lettuce. The market vendors outside can probably sell you some. You can then lure the snails to the nearby saltmine. That will teach them...'
\.


--
-- TOC entry 3400 (class 0 OID 16637)
-- Dependencies: 225
-- Data for Name: solution; Type: TABLE DATA; Schema: game; Owner: postgres
--

COPY game.solution (id, location_id, monster_id, kill_strategy_id, item_id) FROM stdin;
1	18	25	17	1
2	5	9	14	\N
\.


--
-- TOC entry 3401 (class 0 OID 16640)
-- Dependencies: 226
-- Data for Name: solution_message; Type: TABLE DATA; Schema: game; Owner: postgres
--

COPY game.solution_message (id, message_type, message) FROM stdin;
1	SUCCESS	You are awesome, you have succesfully slain the monster. You have earned a good nights rest, without any monsters under your bed.
3	WRONG_MONSTER	You may not be as smart as you think since this monster doesn't live here.
4	MISSING_ITEM	It looks like you are missing a crucial item for your quest in you inventory. You have no hope of slaying the monster without it. So back and search for it.
5	WRONG_LOCATION	Well you could have been successfull in slaying the monster. If only you had chosen the correct location. So focus and try to remember where you are.
6	EPIC_FAIL	This was an epic fail. Are you sure you want to continue with this adventure? You better start over from the beginning.
7	LIMIT_EXCEEDED	You must be very tired, you have entered 3 wrong solutions today. Have yourself a little nap and try again tomorrow.
2	WRONG_STRATEGY	Unfortunately the monster excaped and left you in a right mess. Go back to the inn to take a shower and a nap so you can try again. But beware of monsters under your bed.
\.


--
-- TOC entry 3229 (class 2606 OID 16646)
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (id);


--
-- TOC entry 3223 (class 2606 OID 16648)
-- Name: item item_pkey; Type: CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);


--
-- TOC entry 3231 (class 2606 OID 16650)
-- Name: kill_strategy kill_strategy_pkey; Type: CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.kill_strategy
    ADD CONSTRAINT kill_strategy_pkey PRIMARY KEY (id);


--
-- TOC entry 3225 (class 2606 OID 16652)
-- Name: location location_pkey; Type: CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


--
-- TOC entry 3233 (class 2606 OID 16654)
-- Name: monster monster_pkey; Type: CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.monster
    ADD CONSTRAINT monster_pkey PRIMARY KEY (id);


--
-- TOC entry 3227 (class 2606 OID 16656)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 3235 (class 2606 OID 16658)
-- Name: quest quest_pkey; Type: CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.quest
    ADD CONSTRAINT quest_pkey PRIMARY KEY (id);


--
-- TOC entry 3239 (class 2606 OID 16660)
-- Name: solution_message solution_message_pkey; Type: CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.solution_message
    ADD CONSTRAINT solution_message_pkey PRIMARY KEY (id);


--
-- TOC entry 3237 (class 2606 OID 16662)
-- Name: solution solution_pkey; Type: CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.solution
    ADD CONSTRAINT solution_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 16663)
-- Name: item fk_item_person; Type: FK CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.item
    ADD CONSTRAINT fk_item_person FOREIGN KEY (person_id) REFERENCES game.person(id);


--
-- TOC entry 3241 (class 2606 OID 16668)
-- Name: location fk_location_location; Type: FK CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.location
    ADD CONSTRAINT fk_location_location FOREIGN KEY (location_parent_id) REFERENCES game.location(id);


--
-- TOC entry 3242 (class 2606 OID 16673)
-- Name: person fk_person_location; Type: FK CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.person
    ADD CONSTRAINT fk_person_location FOREIGN KEY (location_id) REFERENCES game.location(id);


--
-- TOC entry 3243 (class 2606 OID 16678)
-- Name: quest fk_quest_person; Type: FK CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.quest
    ADD CONSTRAINT fk_quest_person FOREIGN KEY (person_id) REFERENCES game.person(id);


--
-- TOC entry 3244 (class 2606 OID 16683)
-- Name: solution fk_solution_item; Type: FK CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.solution
    ADD CONSTRAINT fk_solution_item FOREIGN KEY (item_id) REFERENCES game.item(id);


--
-- TOC entry 3245 (class 2606 OID 16688)
-- Name: solution fk_solution_kill_strategy; Type: FK CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.solution
    ADD CONSTRAINT fk_solution_kill_strategy FOREIGN KEY (kill_strategy_id) REFERENCES game.kill_strategy(id);


--
-- TOC entry 3246 (class 2606 OID 16693)
-- Name: solution fk_solution_location; Type: FK CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.solution
    ADD CONSTRAINT fk_solution_location FOREIGN KEY (location_id) REFERENCES game.location(id);


--
-- TOC entry 3247 (class 2606 OID 16698)
-- Name: solution fk_solution_monster; Type: FK CONSTRAINT; Schema: game; Owner: postgres
--

ALTER TABLE ONLY game.solution
    ADD CONSTRAINT fk_solution_monster FOREIGN KEY (monster_id) REFERENCES game.monster(id);


--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 240
-- Name: FUNCTION add_to_inventory(p_item_id integer); Type: ACL; Schema: game; Owner: postgres
--

GRANT ALL ON FUNCTION game.add_to_inventory(p_item_id integer) TO "sql-gamer";


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 241
-- Name: FUNCTION check_solution(p_loc_id integer, p_mnstr_id integer, p_strat_id integer); Type: ACL; Schema: game; Owner: postgres
--

GRANT ALL ON FUNCTION game.check_solution(p_loc_id integer, p_mnstr_id integer, p_strat_id integer) TO "sql-gamer";


--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 238
-- Name: FUNCTION get_message(p_msg_type character varying); Type: ACL; Schema: game; Owner: postgres
--

GRANT ALL ON FUNCTION game.get_message(p_msg_type character varying) TO "sql-gamer";


--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 242
-- Name: FUNCTION insert_solution(p_msg_type character varying, p_loc_id integer, p_monster_id integer, p_strategy_id integer, p_item_id integer); Type: ACL; Schema: game; Owner: postgres
--

GRANT ALL ON FUNCTION game.insert_solution(p_msg_type character varying, p_loc_id integer, p_monster_id integer, p_strategy_id integer, p_item_id integer) TO "sql-gamer";


--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE item; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.item TO "sql-gamer" WITH GRANT OPTION;


--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE location; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.location TO "sql-gamer" WITH GRANT OPTION;


--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE person; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.person TO "sql-gamer" WITH GRANT OPTION;


--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE all_items; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.all_items TO "sql-gamer" WITH GRANT OPTION;


--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE beach_items; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.beach_items TO "sql-gamer" WITH GRANT OPTION;


--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE inventory; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.inventory TO "sql-gamer" WITH GRANT OPTION;


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE kill_strategy; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.kill_strategy TO "sql-gamer" WITH GRANT OPTION;


--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE monster; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.monster TO "sql-gamer" WITH GRANT OPTION;


--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE my_solution; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.my_solution TO "sql-gamer" WITH GRANT OPTION;


--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE quest; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.quest TO "sql-gamer" WITH GRANT OPTION;


--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE solution; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.solution TO "sql-gamer" WITH GRANT OPTION;


--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE solution_message; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.solution_message TO "sql-gamer" WITH GRANT OPTION;


-- Completed on 2023-08-17 18:37:18

--
-- PostgreSQL database dump complete
--

