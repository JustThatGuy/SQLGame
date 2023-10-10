import '../css/Levels.css';
import React, { Component } from 'react';
import { Link } from "react-router-dom";
import levels from '../data/levels.json'

function Levels() {
    // Map levels to actual cards
    const levelCards = levels.map(level => 
        <Link to=":level1" className="Card" key={level.id}>
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