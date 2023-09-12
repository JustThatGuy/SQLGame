import '../css/App.css';
import TabMenu from '../components/TabMenu';
import Table from '../components/Table';
import data from "../data.json"

function App() {

    const backenduri = 'http://localhost:8080'

    const getHeadings = () => {
        return Object.keys(data[0]);
    }

    // parse query to backend
    const execQuery = async () => {
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
            document.getElementById("ResultArea").innerText = await res.text();
        } else {
            document.getElementById("ResultArea").innerText = "You should enter a query in the SQL Query field...";
        }
    };

    // inventory request function
    const getInventory = async () => {
        const res = await fetch(`${backenduri}/inventory`, {
            method: 'GET'
        });

        if (res.ok) {
            const msg = await res.text();
            document.getElementById("ResultArea").innerText = msg;
        }
    }



    // Define mock quest info
    const quests = [{
        id: 0,
        name: 'Level One',
        story: 'With the items safely stored away, you carefully make your way through the path beneath the trees. A soft wind breezes through your hair as the path opens up to reveal a quaint village name Aintree, nestled amidst the palm trees. You head towards the local inn, a cosy establishment with a thatched roof and a welcoming atmosphere. As you enter, you notice a few villages enjoying drinks and conversations. The innkeeper, a middle-aged woman with a friendly smile, greets you warmly. You show her the map and point to the X drawn on it, indicating your curiosity towards the location. She seems reluctant to answer your questions and informs you that she will only provide the information you seek if you fulfil a request for her first. Intrigued by the proposition, you inquire about the nature of the quest and how you can assist her.',
        goal: 'Discover the monster and its kill strategy, then obtain the necessary items.',
        info: "Lately I find my Inn covered in slime in the mornings and to be honest, it's quite a hassle to clean it off every day. The village elders suspect that we have a snail problem, and I'd like you to get rid of them for me. Be aware though, snails are super fast! The only way you're going to get them to slow down is if you can get them to eat some lettuce. Maybe the market vendors outside can sell you some?"
    }];

    // Map quest info to quest area
    const questInfo = quests.map(quest =>
        <div className="QuestCell" key={quest.id}>
            <div className="QuestIntroCell">
                <h1 className="LevelHeader">{quest.name}</h1>
                <p className="LevelContext">{quest.story}</p>
            </div>
            <div className="NewQuestCell">
                <blockquote className="NewQuest">
                    <strong className="BoldText">New Quest!</strong>
                    <br></br>
                        {quest.goal}
                </blockquote>
                <div className="QuestDetails">
                    <p className="QuestText">{quest.info}</p>
                </div>
            </div>
        </div>
    );


    
    // Build the screen
    return (
        <div className="Screen">
            <div className="TabCell">
                <TabMenu></TabMenu>
            </div>

            <div className="OperationsCell">
                {questInfo}

                <div className="LevelLayout">
                    <div className="Form" id="SQLForm" aria-label="SQL Form">
                        <div className="QueryHeader">
                            <label className="FieldLabel">SQL Query</label>
                            <button id="Execute" className="ExecuteButton" onClick={execQuery}>Execute ►</button>
                        </div>
                        <textarea id="SQLQueryField"></textarea>
                    </div>

                    <div className="ResultDisplay">
                        <label className="DisplayLabel">Result</label>
                        <div className="Result" id="ResultArea">
                            {/* <Table theadData={getHeadings()} tbodyData={data}/> */}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default App;