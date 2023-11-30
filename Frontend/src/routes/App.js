import '../css/App.css';

import { useState, useEffect } from "react"
import { backenduri } from '..';
import TabMenu from '../components/TabMenu';
import Table from '../components/Table';
import data from "../data/data.json"
import DatabaseDiagram from '../components/DatabaseDiagram';
import { questInfo } from "../components/QuestInfo"

export default function App() {

    const [queryResult, setQueryResult] = useState(data)
    const [errorState, setErrorState] = useState()

    // parse query to backend
    const execQuery = async () => {
        var errorContainer = document.getElementById("errorPopup");
        var table = document.getElementById("resultTable")

        const query = document.getElementById("SQLQueryField").value;

        if (query) {
            const res = await fetch(`${backenduri}/query`, {
                method: 'POST',
                headers: {
                    'Content-type': 'application/json; charset=UTF-8'
                },
                body: JSON.stringify({
                    query: query
                })
            });

            if (res.ok) {
                var result = await res.json();
                setQueryResult(result);
                errorContainer.style = "display:none";
                table.style = "display:block";
                
            } else {
                errorContainer.innerText = await res.text();
                errorContainer.style = "display:block";
                table.style = "display:none";
            }

        } else {
            errorContainer.innerText = "You should enter a query in the SQL Query field...";
            errorContainer.style = "display:block";
            table.style = "display:none";
        }
    };



    // Build the screen
    return (
        <div className="Screen">
            <div className="TabCell">
                <TabMenu />
            </div>

            <div className="OperationsCell">
                <div className="LevelLayout">
                    <div className="Form" id="SQLForm" aria-label="SQL Form">
                        <div className="QueryHeader">
                            <label className="FieldLabel">SQL Query</label>
                            <button id="Execute" className="ExecuteButton" onClick={execQuery}>Execute ►</button>
                        </div>
                        <textarea id="SQLQueryField" placeholder='Enter SQL Query'></textarea>
                    </div>

                    <div className="ResultDisplay">
                        <label className="DisplayLabel">Result</label>
                        <div className="Result" id="ResultArea">
                            <div id='errorPopup' style={{display: "none"}}>
                                <p id='errorMsg'>Placeholder Error</p>
                            </div>
                            <Table data={queryResult} />
                        </div>
                    </div>
                </div>

                {questInfo[0]}

            </div>

            <DatabaseDiagram />
        </div>
    );
};