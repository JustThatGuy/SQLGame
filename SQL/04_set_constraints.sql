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


-- Completed on 2023-08-17 18:37:18

--
-- PostgreSQL database dump complete
--

