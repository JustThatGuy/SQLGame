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

CREATE USER sqlgamer WITH PASSWORD 'wachtwoord';

GRANT ALL PRIVILEGES ON DATABASE monster TO sqlgamer;

GRANT ALL PRIVILEGES ON SCHEMA game TO sqlgamer;

--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 240
-- Name: FUNCTION add_to_inventory(p_item_id integer); Type: ACL; Schema: game; Owner: postgres
--

GRANT ALL ON FUNCTION game.add_to_inventory(p_item_id integer) TO "sqlgamer";


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 241
-- Name: FUNCTION check_solution(p_loc_id integer, p_mnstr_id integer, p_strat_id integer); Type: ACL; Schema: game; Owner: postgres
--

GRANT ALL ON FUNCTION game.check_solution(p_loc_id integer, p_mnstr_id integer, p_strat_id integer) TO "sqlgamer";


--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 238
-- Name: FUNCTION get_message(p_msg_type character varying); Type: ACL; Schema: game; Owner: postgres
--

GRANT ALL ON FUNCTION game.get_message(p_msg_type character varying) TO "sqlgamer";


--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 242
-- Name: FUNCTION insert_solution(p_msg_type character varying, p_loc_id integer, p_monster_id integer, p_strategy_id integer, p_item_id integer); Type: ACL; Schema: game; Owner: postgres
--

GRANT ALL ON FUNCTION game.insert_solution(p_msg_type character varying, p_loc_id integer, p_monster_id integer, p_strategy_id integer, p_item_id integer) TO "sqlgamer";


--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE item; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.item TO "sqlgamer" WITH GRANT OPTION;


--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE location; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.location TO "sqlgamer" WITH GRANT OPTION;


--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE person; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.person TO "sqlgamer" WITH GRANT OPTION;


--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE all_items; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.all_items TO "sqlgamer" WITH GRANT OPTION;


--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE beach_items; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.beach_items TO "sqlgamer" WITH GRANT OPTION;


--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE inventory; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.inventory TO "sqlgamer" WITH GRANT OPTION;
GRANT INSERT ON TABLE game.inventory TO "sqlgamer";
GRANT DELETE ON TABLE game.inventory TO "sqlgamer";


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE kill_strategy; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.kill_strategy TO "sqlgamer" WITH GRANT OPTION;


--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE monster; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.monster TO "sqlgamer" WITH GRANT OPTION;


--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE my_solution; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.my_solution TO "sqlgamer" WITH GRANT OPTION;
GRANT INSERT ON TABLE game.my_solution TO "sqlgamer";


--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE quest; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.quest TO "sqlgamer" WITH GRANT OPTION;


--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE solution; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.solution TO "sqlgamer" WITH GRANT OPTION;


--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE solution_message; Type: ACL; Schema: game; Owner: postgres
--

GRANT SELECT ON TABLE game.solution_message TO "sqlgamer" WITH GRANT OPTION;


-- Completed on 2023-08-17 18:37:18

--
-- PostgreSQL database dump complete
--

