import './App.css';
import React, {useState, useEffect} from 'react';

function App() {
    const [quest, setQuest] = useState(false);
    useEffect(() => {
        getQuest();
    }, []);
    
    function getQuest() {
        fetch('http://localhost:8080')
            .then(response => {
                return response.text();
            })
        .then(data => {
            setQuest(data);
        })
    }

    const [query, setQuery] = useState('Enter your SQL code here.');
    const handleQueryChange = event => {
        setQuery(event.target.value);
    }

    function executeSQL() {
        fetch('http://localhost:8080/sqlQuery')
            .then(response => {
                return response.text();
            })
            .then(data => {
                setQuest(data);
            })
    }

    return (
        <div class="Screen">
            <div class="TabCell">
                <div data-current="Map" class="Tabs">
                    <div class="TabMenu" role="tablist">
                        <a data-w-tab="Map" class="TabLink" id="TabMenu-0-Tab-0" aria-controls="TabMenu-0-TabContent-0" href="#TabMenu-0-TabContent-0" role="tab" aria-selected="true">Map</a>
                        <a data-w-tab="Inventory" class="TabLink" id="TabMenu-0-Tab-1" aria-controls="TabMenu-0-TabContent-1" href="#TabMenu-0-TabContent-1" role="tab" aria-selected="false">Inventory</a>
                        <a data-w-tab="Locations" class="TabLink" id="TabMenu-0-Tab-2" aria-controls="TabMenu-0-TabContent-2" href="#TabMenu-0-TabContent-2" role="tab" aria-selected="false">Locations</a>
                        <a data-w-tab="People" class="TabLink" id="TabMenu-0-Tab-3" aria-controls="TabMenu-0-TabContent-3" href="#TabMenu-0-TabContent-3" role="tab" aria-selected="false">People</a>
                    </div>
                    <div class="TabPane" role="tablist">
                        <div data-w-map="Map" class="TabContent" id="TabMenu-0-TabContent-0" role="tabpanel" aria-labelledby="TabMenu-0-Tab-0"></div>
                        <div data-w-map="Inventory" class="TabContent" id="TabMenu-0-TabContent-1" role="tabpanel" aria-labelledby="TabMenu-0-Tab-1"></div>
                        <div data-w-map="Locations" class="TabContent" id="TabMenu-0-TabContent-2" role="tabpanel" aria-labelledby="TabMenu-0-Tab-2"></div>
                        <div data-w-map="People" class="TabContent" id="TabMenu-0-TabContent-3" role="tabpanel" aria-labelledby="TabMenu-0-Tab-3"></div>
                    </div>
                </div>
            </div>

            <div class="OperationsCell">
                <div class="QuestCell">
                    <div class="QuestIntroCell">
                        <h1 class="LevelHeader"> Level 1</h1>
                        <p class="LevelContext">With the items safely stored away, you carefully make your way through the path beneath the trees. A soft wind breezes through your hair as the path opens up to reveal a quaint village name Aintree, nestled amidst the palm trees.<br></br><br></br>You head towards the local inn, a cosy establishment with a thatched roof and a welcoming atmosphere. As you enter, you notice a few villages enjoying drinks and conversations. The innkeeper, a middle-aged woman with a friendly smile, greets you warmly. You show her the map and point to the X drawn on it, indicating your curiosity towards the location.<br></br><br></br>She seems reluctant to answer your questions and informs you that she will only provide the information you seek if you fulfil a request for her first. Intrigued by the proposition, you inquire about the nature of the quest and how you can assist her.</p>
                    </div>
                    <div class="NewQuestCell">
                        <blockquote class="NewQuest">
                            <strong class="BoldText">New Quest!</strong>
                            <br></br>
                            Discover the monster and its kill strategy, then obtain the necessary items.
                        </blockquote>
                        <div class="QuestDetails">
                            <p class="QuestText">
                            Lately I find my Inn covered in slime in the mornings and to be honest, it's quite a hassle to clean it off every day. The village elders suspect that we have a snail problem, and I'd like you to get rid of them for me. Be aware though, snails are super fast! The only way you're going to get them to slow down is if you can get them to eat some lettuce. Maybe the market vendors outside can sell you some?
                            </p>
                        </div>
                    </div>
                </div>

                <div class="LevelLayout">
                    <div class="Form" id="SQLForm" aria-label="SQL Form">
                        <div class="QueryHeader">
                            <label for="field" class="FieldLabel">SQL Query</label>
                            <button onClick={executeSQL} id="Execute" class="ExecuteButton">Execute ►</button>
                        </div>
                        <textarea id="SQLQueryField" value={query} onChange={handleQueryChange}></textarea>
                    </div>  
    
                    <div class="ResultDisplay">
                        <label for="display" class="DisplayLabel">Result</label>
                        <div class="Result" id="ResultArea">Hello there</div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default App;