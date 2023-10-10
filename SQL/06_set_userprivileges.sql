-- User
CREATE USER sqlgamer WITH PASSWORD 'wachtwoord';

GRANT ALL PRIVILEGES ON DATABASE monster TO sqlgamer;

GRANT ALL PRIVILEGES ON SCHEMA game TO sqlgamer;


-- Functions
GRANT EXECUTE ON FUNCTION game.add_to_inventory(p_item_id integer) TO sqlgamer;

GRANT EXECUTE ON FUNCTION game.check_solution(p_loc_id integer, p_mnstr_id integer, p_strat_id integer) TO sqlgamer;

GRANT EXECUTE ON FUNCTION game.get_message(p_msg_type character varying) TO sqlgamer;

GRANT EXECUTE ON FUNCTION game.insert_solution(p_msg_type character varying, p_loc_id integer, p_monster_id integer, p_strategy_id integer, p_item_id character varying) TO sqlgamer;

GRANT EXECUTE ON FUNCTION game.remove_from_inventory(p_item_id integer) TO sqlgamer;


-- Tables
GRANT SELECT ON TABLE game.conversation TO sqlgamer;

GRANT DELETE, INSERT, SELECT ON TABLE game.inventory TO sqlgamer;

GRANT SELECT ON TABLE game.item TO sqlgamer;

GRANT SELECT ON TABLE game.kill_strategy TO sqlgamer;

GRANT SELECT ON TABLE game.location TO sqlgamer;

GRANT SELECT ON TABLE game.message TO sqlgamer;

GRANT SELECT ON TABLE game.monster TO sqlgamer;

GRANT INSERT, SELECT ON TABLE game.my_solution TO sqlgamer;

GRANT SELECT ON TABLE game.person TO sqlgamer;

GRANT SELECT ON TABLE game.quest TO sqlgamer;

GRANT SELECT ON TABLE game.solution TO sqlgamer;

GRANT SELECT ON TABLE game.solution_item TO sqlgamer;

GRANT SELECT ON TABLE game.item TO sqlgamer WITH GRANT OPTION;


-- Views
GRANT SELECT ON TABLE game.all_items TO sqlgamer;

GRANT SELECT ON TABLE game.beach_items TO sqlgamer;

GRANT SELECT ON TABLE game.location_overview TO sqlgamer;
