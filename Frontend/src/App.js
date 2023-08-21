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
                <div class="Tabs">

                </div>
            </div>

            <div class="OperationsCell">
                <div class="QuestCell">
                    <div class="QuestIntroCell">
                        <h1 class="LevelHeader"> Level 1</h1>
                        <p class="LevelContext">With the items safely stored away, you carefully make your way through the path beneath the trees. A soft wind breezes through your hair as the path opens up to reveal a quaint village name Aintree, nestled amidst the palm trees.<br></br><br></br>You head towards the local inn, a cosy establishment with a thatched roof and a welcoming atmosphere. As you enter, you notice a few villages enjoying drinks and conversations. The innkeeper, a middle-aged woman with a friendly smile, greets you warmly. You show here the map and point to the X drawn on it, indicating your curiosity towards the location.<br></br><br></br>She seems reluctant to answer your questions and informs you that she will only provide the information you seek if you fulfil a request for her first. Intrigued by the proposition, you inquire about the nature of the quest and how you can assist her.</p>
                    </div>
                </div>

                <div class="LevelLayout">
                    <div class="Form" id="SQLForm" aria-label="SQL Form">
                        <div class="QueryHeader">
                            <label for="field" class="FieldLabel">SQL Query</label>
                            <button onclick={executeSQL} id="Execute" class="ExecuteButton">Execute ►</button>
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
}

export default App;
