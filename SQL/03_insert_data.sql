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

COPY game.conversation (id, person_id, info) FROM stdin;
1	5	The bird-woman creatures are mythological beings. They lure people with their hypnotic singing and abduct the for god knows what reason.\nI have a theory that they can't stand noise, that's why they come at night. So between the items in my shop, pick the one that is the loudest. It would have the highest number behind the name. Because of the loudness, it would be wise to protect your ears with some plugs. Good luck!
\.


COPY game.inventory (id, item, origin) FROM stdin;
13	map	unknown
\.


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
107	20	pickles	Pickled cucumber.	N
118	20	relish	A piquant sauce or pickle eaten with plain food to add flavour.	N
117	4	whoopsie-daisiy	Accidental sacred flower for the goddess of love, beauty and fertility	N
115	18	mocha	Mixture of coffee and chocolate	N
116	18	chai	Blend of black tea, honey, spices and milk. Can also be used as the word for life.	N
119	18	espresso	The perfect balance between acidity, bitterness and sweetness	N
202	\N	BFG9000	\N	Y
200	\N	legendary longsword	\N	Y
201	\N	enchanted amulet	\N	Y
203	\N	pointy hat of power	\N	Y
204	\N	sword of slaying everything except squid	Cannot be used against Squidzilla. If you encounter Squidzilla, you must drop this item from your inventory or you will be grabbed, slimed, crushed and gobbled.	Y
205	\N	boots of buttkicking	\N	Y
206	\N	sneaky basterd sword	Can be used for stabbing someone in the back.	Y
207	\N	badass bandana	Makes you look very fierce.	Y
208	\N	potion of idiotic bravery	\N	Y
209	\N	rapier of certain death	\N	Y
210	\N	pretty balloons	Can be used at childrens parties or to distract some monsters.	Y
211	\N	magic lamp	Can be used to summon a genie that will grant you a wish. But only if you believe in such things.	Y
212	\N	helm of courage	You can do it!	Y
213	\N	shield of ubiquity	When you raise this shield it seems to form all around you. Nothing or no one can harm you.	Y
13	\N	map	Intriguing piece of paper adorned with a mysterious -X-	N
120	27	earplugs	\N	N
108	5	lute (40)	Stringed instrument, the name is derived from the Arabic "el lud", meaning "the wood".	N
109	5	harp (78)	Stringed instrument.	N
110	5	drum (115)	Percussion instrument, can accompany many different types of songs. Also used to send messages.	N
111	5	ukulele (80)	Stringed instrument, looks like a small guitar, originates from Hawaii.	N
112	5	cajón (108)	Percussion instrument, mostly used to accompany flamenco dancers.	N
113	5	zither (100)	Stringed instrument.	N
114	5	balalaika (85)	Stringed instrument.	N
\.


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
21	Cloud Nine City	Village	1
23	Coalmine	Mine	6
24	Lattetude	Coffee shop	2
26	River Lane	Street	13
27	Steam Way	Street	13
28	Waterfall Avenue	Street	13
20	Two Notes	Musical store	26
22	Sound of music	Music store	28
25	The happy chemist	Drugstore	27
\.


COPY game.message (id, message_type, message) FROM stdin;
1	SUCCESS	You are awesome, you have succesfully slain the monster. You have earned a good nights rest, without any monsters under your bed.
3	WRONG_MONSTER	You may not be as smart as you think since this monster doesn't live here.
4	MISSING_ITEM	It looks like you are missing a crucial item for your quest in you inventory. You have no hope of slaying the monster without it. So back and search for it.
5	WRONG_LOCATION	Well you could have been successfull in slaying the monster. If only you had chosen the correct location. So focus and try to remember where you are.
6	EPIC_FAIL	This was an epic fail. Are you sure you want to continue with this adventure? You better start over from the beginning.
7	LIMIT_EXCEEDED	You must be very tired, you have entered 3 wrong solutions today. Have yourself a little nap and try again tomorrow.
2	WRONG_STRATEGY	Unfortunately the monster excaped and left you in a right mess. Go back to the inn to take a shower and a nap so you can try again. But beware of monsters under your bed.
8	ADDED_ITEM	Good job, you have succesfully added ' || v_item || ' to your inventory
9	EXISTING_ITEM	Pay attention! You have already added ' || v_item || ' to your inventory
10	NON_EXISTING_ITEM	Look carefully, there is no such thing as that to be found here
\.


COPY game.monster (id, item, strength, weakness) FROM stdin;
9	Horrid harpies	beautiful hypnotising song	\N
25	Snails on speed	fast	local lettuce
2	Mighty germ	\N	\N
10	Teddy bear	\N	\N
3	Giant skunk	\N	\N
12	Flying frogs	\N	\N
5	Were turtle	\N	\N
20	Insurance salesman	\N	\N
1	Scary clown	\N	\N
8	Stoned golem	\N	\N
7	Psycho squirrel	\N	\N
\.


COPY game.person (id, name, occupation, location_id) FROM stdin;
1	Nora Steel	\N	\N
2	Stevie Adams	\N	\N
3	Vicente Amigo	\N	\N
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
19	Patrick Hastings	\N	\N
21	Carlos Montoya	\N	\N
22	Antonio Canales	\N	\N
23	Miguel Poveda	\N	\N
24	Tony Campbell	\N	\N
25	Alex Prescott	\N	\N
26	Lucy Fin	\N	\N
18	La Perla de Cadiz	shopkeeper	24
4	Lola Flores	flower seller	6
20	Jesse Cook	greengrocer	6
27	Jo Brown	shopkeeper	25
\.


COPY game.quest (id, goal, info, person_id) FROM stdin;
1	Discover the monster and its kill strategy, then obtain the necessary items.	Lately, I find my Inn covered in slime in the mornings. It is quite a hassle to clean it off every day. The village elders suspect that we have a snail problem. \r\n\r\nI would like you to get rid of these snails for me. Then I will tell you what you need to know. \r\n\r\nBut be aware that they are super fast. They will only slow down when they can eat some of our local lettuce. You can get that at the greengrocer outside. Add it to your inventory, then you can then lure the snails to the nearby saltmine. That will teach them...	12
2	Select some useful items for your journey and add them to your inventory	Looking around, you can see a lot of stuff that is washed ashore. As an aspiring adventurer, you will undoubtedly want to locate these treasures and deposit them in your trophy case.	\N
\.


COPY game.solution (id, location_id, monster_id, kill_strategy_id) FROM stdin;
1	18	25	17
2	5	9	14
\.


COPY game.solution_item (id, solution_id, item_id) FROM stdin;
1	1	105
2	2	110
3	2	120
\.
