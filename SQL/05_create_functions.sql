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
	v_item int;
	v_solution int;
	v_solution_wm int;
	v_solution_ws int;
	v_solution_wl int;
	v_inventory_item int;
BEGIN

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

-- SUCCESS
-- First check if the location, monster and strategy are correct
-- If location, monster and strategy are correct, check if there are necessary items
	if (v_solution is not null)
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

-- Completed on 2023-08-17 18:37:18

--
-- PostgreSQL database dump complete
--

