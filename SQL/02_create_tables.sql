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


-- Completed on 2023-08-17 18:37:18

--
-- PostgreSQL database dump complete
--

