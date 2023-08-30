import '../css/Levels.css';
import React, { Component } from 'react';
import { Link } from "react-router-dom";

function Levels() {

    // Define levels for testing
    const levels = [{
        id: 0,
        name: 'Level One',
        desc: 'Small beginnings',
        image: '../img/level1.png'
    }, {
        id: 1,
        name: 'Level Two',
        desc: 'The first tracks',
        image: '../img/level2.png'
    }, {
        id: 2,
        name: 'Level Three',
        desc: 'Dungeon crawling is not for weaklings',
        image: '../img/level3.png'
    }, {
        id: 3,
        name: 'Level Four',
        desc: 'Where ends meet',
        image: '../img/level4.png'
    }];
    // Map levels to actual cards
    const levelCards = levels.map(level => 
        <Link to=":level1" class="Card" key={level.id}>
            <div className="LevelImage">
                <img src={level.image} alt={level.name}/>
            </div>
            <div className='LevelCardDescription'>
                <h1 className="LevelName">{level.name}</h1>
                <p className="LevelDescription">{level.desc}</p>
            </div>
        </Link>
    );
    
    // Build screen
    return (
        <div className="LevelScreen">
            <div className='ScreenTitle'>
                <h1 className='ScreenHeader'>Select a level</h1>
            </div>
            <ul className="LevelList">{levelCards}</ul>
        </div>
        
    );
};

export default Levels;