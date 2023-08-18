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
        <div class="LevelLayout">
            <div class="form" id="SQLForm" aria-label="SQL Form">
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
    );
}

export default App;
