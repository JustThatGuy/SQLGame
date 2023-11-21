import '../css/QuestInfo.css'

import levels from '../data/levels.json'
import Solution from '../components/Solution'

// // Map quest info to quest area
export const questInfo = levels.map(quest =>
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

        <Solution />
        
    </div>
);