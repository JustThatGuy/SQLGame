CREATE FUNCTION game.add_to_inventory(p_item_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$	
DECLARE
	v_item varchar(50);
	v_item_id int;
	v_inventory_id int;
	v_message varchar(100);

BEGIN
	Select id into v_item_id
	from game.all_items
	where id = p_item_id;

	Select id into v_inventory_id
	from game.inventory
	where item = (select item from game.item where id = p_item_id);

-- when the item doesn't exist, nothing happens
	IF (v_item_id is null)
		then
			return game.get_message('NON_EXISTING_ITEM') ;

-- when you don't have the item in your inventory it is added
	ELSIF (v_inventory_id is null)
		then
			insert into game.inventory (id,item, origin)
			select id, item, origin
			from game.all_items
			where id = p_item_id;

			select item into v_item from game.inventory where id = v_item_id;
			v_message = 'Good job, you have succesfully added ' || v_item || ' to your inventory';

			return v_message;

-- when you allready have the item in your inventory, nothing happens
		ELSE
			select item into v_item from game.inventory where id = v_inventory_id;
			v_message = 'Pay attention! You have already added ' || v_item || ' to your inventory';

			return v_message;
		END if;

END$$;


ALTER FUNCTION game.add_to_inventory(p_item_id integer) OWNER TO postgres;


CREATE FUNCTION game.check_solution(p_loc_id integer, p_mnstr_id integer, p_strat_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_item_nr int;
	v_item varchar;
	v_solution int;
	v_solution_wm int;
	v_solution_ws int;
	v_solution_wl int;
	v_inventory_nr int;
	v_inventory_item varchar;
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
			select into v_item_nr, v_item count(*), array_agg(si.item_id)
		    from game.solution s
		    inner join game.solution_item si on s.id = si.solution_id
		    where s.id = v_solution;

	-- If there are no necessary items -> SUCCESS
			IF (v_item_nr = 0)
				then
					perform game.insert_solution('SUCCESS', p_loc_id, p_mnstr_id, p_strat_id);
					return game.get_message('SUCCESS') ;

	-- If there are necessary items, check if they are all in the inventory
			elsif (v_item_nr > 0)
				then
					select into v_inventory_nr, v_inventory_item count(*), array_agg(i.id)
				    from game.inventory i
					where id in (select item_id
						  		 from game.solution s
								 inner join game.solution_item si on s.id = si.solution_id
								 where s.id = v_solution);

	-- If all the items are in the inventory -> SUCCESS
					IF (v_inventory_nr = v_item_nr)
						then
							perform game.insert_solution('SUCCESS', p_loc_id, p_mnstr_id, p_strat_id, v_item);
							return game.get_message('SUCCESS');

	-- If not -> MISSING ITEM
					ELSE
						perform game.insert_solution('MISSING_ITEM', p_loc_id, p_mnstr_id, p_strat_id, v_inventory_item);
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


CREATE FUNCTION game.get_message(p_msg_type character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
	msg varchar;
begin
	SELECT message
	INTO msg
	FROM game.message
	WHERE message_type = p_msg_type;

	return msg;
end
$$;


ALTER FUNCTION game.get_message(p_msg_type character varying) OWNER TO postgres;

CREATE FUNCTION game.insert_solution(p_msg_type character varying, p_loc_id integer, p_mnstr_id integer, p_strat_id integer, p_item_id character varying DEFAULT NULL::character varying) RETURNS void
    LANGUAGE sql
    AS $$
INSERT INTO game.my_solution VALUES (CURRENT_DATE, USER, p_msg_type, p_loc_id, p_mnstr_id, p_strat_id, p_item_id);
$$;


ALTER FUNCTION game.insert_solution(p_msg_type character varying, p_loc_id integer, p_monster_id integer, p_strategy_id integer, p_item_id character varying) OWNER TO postgres;


CREATE FUNCTION game.remove_from_inventory(p_item_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$

DECLARE
	v_item varchar(50);
	v_item_id int;
	v_inventory_id int;
	v_message varchar(100);

BEGIN

	Select id into v_inventory_id
	from game.inventory
	where item = (select item from game.inventory where id = p_item_id);

-- when the item doesn't exist in the inventory, nothing happens
	IF (v_inventory_id is null)
		then
			return game.get_message('NON_EXISTING_ITEM') ;

-- when you have the item in your inventory it is removed
	ELSIF (v_inventory_id is not null)
		then
			select item into v_item from game.inventory where id = p_item_id;

			delete from game.inventory where id = p_item_id;

			v_message = 'Good job, you have succesfully removed ' || v_item || ' from your inventory';

			return v_message;

		END if;

END
$$;


ALTER FUNCTION game.remove_from_inventory(p_item_id integer) OWNER TO postgres;

