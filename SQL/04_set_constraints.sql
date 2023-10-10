-- PRIMARY KEYS

ALTER TABLE ONLY game.conversation
    ADD CONSTRAINT conversation_pkey PRIMARY KEY (id);


ALTER TABLE ONLY game.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (id);


ALTER TABLE ONLY game.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);


ALTER TABLE ONLY game.kill_strategy
    ADD CONSTRAINT kill_strategy_pkey PRIMARY KEY (id);


ALTER TABLE ONLY game.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


ALTER TABLE ONLY game.message
    ADD CONSTRAINT solution_message_pkey PRIMARY KEY (id);


ALTER TABLE ONLY game.monster
    ADD CONSTRAINT monster_pkey PRIMARY KEY (id);


ALTER TABLE ONLY game.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


ALTER TABLE ONLY game.quest
    ADD CONSTRAINT quest_pkey PRIMARY KEY (id);


ALTER TABLE ONLY game.solution
    ADD CONSTRAINT solution_pkey PRIMARY KEY (id);


ALTER TABLE ONLY game.solution_item
    ADD CONSTRAINT solution_item_pkey PRIMARY KEY (id);


-- FOREIGN KEYS

ALTER TABLE ONLY game.conversation
    ADD CONSTRAINT fk_conversation_person FOREIGN KEY (person_id) REFERENCES game.person(id);


ALTER TABLE ONLY game.item
    ADD CONSTRAINT fk_item_person FOREIGN KEY (person_id) REFERENCES game.person(id);


ALTER TABLE ONLY game.location
    ADD CONSTRAINT fk_location_location FOREIGN KEY (location_parent_id) REFERENCES game.location(id);


ALTER TABLE ONLY game.person
    ADD CONSTRAINT fk_person_location FOREIGN KEY (location_id) REFERENCES game.location(id);


ALTER TABLE ONLY game.quest
    ADD CONSTRAINT fk_quest_person FOREIGN KEY (person_id) REFERENCES game.person(id);


ALTER TABLE ONLY game.solution
    ADD CONSTRAINT fk_solution_kill_strategy FOREIGN KEY (kill_strategy_id) REFERENCES game.kill_strategy(id);


ALTER TABLE ONLY game.solution
    ADD CONSTRAINT fk_solution_location FOREIGN KEY (location_id) REFERENCES game.location(id);


ALTER TABLE ONLY game.solution
    ADD CONSTRAINT fk_solution_monster FOREIGN KEY (monster_id) REFERENCES game.monster(id);


ALTER TABLE ONLY game.solution_item
    ADD CONSTRAINT solution_item_solution FOREIGN KEY (solution_id) REFERENCES game.solution(id);

