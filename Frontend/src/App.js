import './App.css';

function App() {
  return (
        <div class="LevelLayout">
            <div class="form" id="SQLForm" aria-label="SQL Form">
                <div class="QueryHeader">
                    <label for="field" class="FieldLabel">SQL Query</label>
                    <button onclick="executeSQL()" id="Execute" class="ExecuteButton">Execute ►</button>
                </div>
                <textarea id="SQLQueryField" placeholder="Enter your SQL code here."></textarea>
            </div>
    
            <div class="ResultDisplay">
                <label for="display" class="DisplayLabel">Result</label>
                <div class="Result" id="ResultArea">Hello there</div>
            </div>
        </div>
    );
}

export default App;
