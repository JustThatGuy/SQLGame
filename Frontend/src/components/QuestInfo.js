const quests = [{
    id: 0,
    name: 'Level One',
    story: 'With the items safely stored away, you carefully make your way through the path beneath the trees. A soft wind breezes through your hair as the path opens up to reveal a quaint village name Aintree, nestled amidst the palm trees. You head towards the local inn, a cosy establishment with a thatched roof and a welcoming atmosphere. As you enter, you notice a few villages enjoying drinks and conversations. The innkeeper, a middle-aged woman with a friendly smile, greets you warmly. You show her the map and point to the X drawn on it, indicating your curiosity towards the location. She seems reluctant to answer your questions and informs you that she will only provide the information you seek if you fulfil a request for her first. Intrigued by the proposition, you inquire about the nature of the quest and how you can assist her.',
    goal: 'Discover the monster and its kill strategy, then obtain the necessary items.',
    info: "Lately I find my Inn covered in slime in the mornings and to be honest, it's quite a hassle to clean it off every day. The village elders suspect that we have a snail problem, and I'd like you to get rid of them for me. Be aware though, snails are super fast! The only way you're going to get them to slow down is if you can get them to eat some lettuce. Maybe the market vendors outside can sell you some?"
}];

// Map quest info to quest area
export const questInfo = quests.map(quest =>
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