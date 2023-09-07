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
1	Scary clown	\N	\N
2	Mighty germ	\N	\N
3	Giant skunk	\N	\N
5	Were turtle	\N	\N
7	Psycho squirrel	\N	\N
8	Stoned golem	\N	\N
9	Horrid harpies	\N	\N
10	Teddy bear	\N	\N
12	Flying frogs	\N	\N
20	Insurance salesman	\N	\N
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

COPY game.quest (id, name, story, goal, info, person_id) FROM stdin;
0	Level One	With the items safely stored away, you carefully make your way through the path beneath the trees. A soft wind breezes through your hair as the path opens up to reveal a quaint village name Aintree, nestled amidst the palm trees. You head towards the local inn, a cosy establishment with a thatched roof and a welcoming atmosphere. As you enter, you notice a few villages enjoying drinks and conversations. The innkeeper, a middle-aged woman with a friendly smile, greets you warmly. You show her the map and point to the X drawn on it, indicating your curiosity towards the location. She seems reluctant to answer your questions and informs you that she will only provide the information you seek if you fulfil a request for her first. Intrigued by the proposition, you inquire about the nature of the quest and how you can assist her.	Discover the monster and its kill strategy, then obtain the necessary items.	Lately, I find my Inn covered in slime in the mornings. It is quite a hassle to clean it off every day. The village elders suspect that we have a snail problem. \n\nI would like you to get rid of these snails for me. Then I will tell you what you need to know. \n\nBut be aware that they are super fast. They will only slow down when they can eat some of our local lettuce. You can get that at the greengrocer outside. Add it to your inventory, then you can then lure the snails to the nearby saltmine. That will teach them...	12
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


-- Completed on 2023-08-17 18:37:18

--
-- PostgreSQL database dump complete
--

