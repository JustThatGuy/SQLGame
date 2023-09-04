import '../css/App.css';

function App() {

    const backenduri = 'http://localhost:8080'

    const execQuery = async () => {
        const query = document.getElementById("SQLQueryField").value
        if(query) {
            const res = await fetch(`${backenduri}/query`, {
                method: 'POST',
                headers: {
                    'Content-type': 'application/json; charset=UTF-8'
                },
                body: JSON.stringify({
                    query: query
                })
            });
            document.getElementById("ResultArea").innerText = await res.text();
        } else {
            document.getElementById("ResultArea").innerText = "You should enter a query in the SQL Query field..."
        }
    };

    const getInventory = async () => {
        const res = await fetch(`${backenduri}/inventory`, {
            method: 'GET'
        });

        if(res.ok) {
            const msg = await res.text();
            document.getElementById("ResultArea").innerText = msg;
        }
    }

    return (
        <div className="Screen">
            <div className="TabCell">
                <div data-current="Map" className="Tabs">
                    <div className="TabMenu" role="tablist">
                        <a data-w-tab="Map" className="TabLink" id="TabMenu-0-Tab-0" aria-controls="TabMenu-0-TabContent-0" href="#TabMenu-0-TabContent-0" role="tab" aria-selected="true">Map</a>
                        <a data-w-tab="Inventory" className="TabLink" id="TabMenu-0-Tab-1" aria-controls="TabMenu-0-TabContent-1" href="#TabMenu-0-TabContent-1" role="tab" aria-selected="false">Inventory</a>
                        <a data-w-tab="Locations" className="TabLink" id="TabMenu-0-Tab-2" aria-controls="TabMenu-0-TabContent-2" href="#TabMenu-0-TabContent-2" role="tab" aria-selected="false">Locations</a>
                        <a data-w-tab="People" className="TabLink" id="TabMenu-0-Tab-3" aria-controls="TabMenu-0-TabContent-3" href="#TabMenu-0-TabContent-3" role="tab" aria-selected="false">People</a>
                    </div>
                    <div className="TabPane" role="tablist">
                        <div data-w-map="Map" className="TabContent" id="TabMenu-0-TabContent-0" role="tabpanel" aria-labelledby="TabMenu-0-Tab-0">
                            <img src="../img/Aintree.png" className='Map'></img>
                        </div>
                        <div data-w-map="Inventory" className="TabContent" id="TabMenu-0-TabContent-1" role="tabpanel" aria-labelledby="TabMenu-0-Tab-1"></div>
                        <div data-w-map="Locations" className="TabContent" id="TabMenu-0-TabContent-2" role="tabpanel" aria-labelledby="TabMenu-0-Tab-2"></div>
                        <div data-w-map="People" className="TabContent" id="TabMenu-0-TabContent-3" role="tabpanel" aria-labelledby="TabMenu-0-Tab-3"></div>
                    </div>
                </div>
            </div>

            <div className="OperationsCell">
                <div className="QuestCell">
                    <div className="QuestIntroCell">
                        <h1 className="LevelHeader"> Level 1</h1>
                        <p className="LevelContext">With the items safely stored away, you carefully make your way through the path beneath the trees. A soft wind breezes through your hair as the path opens up to reveal a quaint village name Aintree, nestled amidst the palm trees.<br></br><br></br>You head towards the local inn, a cosy establishment with a thatched roof and a welcoming atmosphere. As you enter, you notice a few villages enjoying drinks and conversations. The innkeeper, a middle-aged woman with a friendly smile, greets you warmly. You show her the map and point to the X drawn on it, indicating your curiosity towards the location.<br></br><br></br>She seems reluctant to answer your questions and informs you that she will only provide the information you seek if you fulfil a request for her first. Intrigued by the proposition, you inquire about the nature of the quest and how you can assist her.</p>
                    </div>
                    <div className="NewQuestCell">
                        <blockquote className="NewQuest">
                            <strong className="BoldText">New Quest!</strong>
                            <br></br>
                            Discover the monster and its kill strategy, then obtain the necessary items.
                        </blockquote>
                        <div className="QuestDetails">
                            <p className="QuestText">
                            Lately I find my Inn covered in slime in the mornings and to be honest, it's quite a hassle to clean it off every day. The village elders suspect that we have a snail problem, and I'd like you to get rid of them for me. Be aware though, snails are super fast! The only way you're going to get them to slow down is if you can get them to eat some lettuce. Maybe the market vendors outside can sell you some?
                            </p>
                        </div>
                    </div>
                </div>

                <div className="LevelLayout">
                    <div className="Form" id="SQLForm" aria-label="SQL Form">
                        <div className="QueryHeader">
                            <label className="FieldLabel">SQL Query</label>
                            <button onClick={getInventory}>Get Inventory</button>
                            <button id="Execute" className="ExecuteButton" onClick={execQuery}>Execute ►</button>
                        </div>
                        <textarea id="SQLQueryField"></textarea>
                    </div>

                    <div className="ResultDisplay">
                        <label className="DisplayLabel">Result</label>
                        <div className="Result" id="ResultArea">Hello there</div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default App;