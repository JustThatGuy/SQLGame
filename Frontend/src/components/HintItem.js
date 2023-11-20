import '../css/HintItem.css';
import '../css/InventoryItem.css'

import React from 'react';
import Collapsible from 'react-collapsible';
import { useState } from 'react';

export default function HintItem({ hint }) {

  const [show, setShow] = useState(false);
  const [icon, setIcon] = useState("visibility");
  const [text, setText] = useState("Solution");

  const toggleSolution = () => {
    setShow((state) => (state === false ? true : false));
    setIcon((state) => (state === "visibility" ? "visibility_off" : "visibility"));
    setText((state) => (state === "Solution" ? null : "Solution"));
  }

  return (
    <Collapsible containerElementProps={hint.id} trigger={hint.title} transitionTime={100} easing='ease' contentHiddenWhenClosed='true'>
      <p className='HintDesc'>{hint.desc}</p>
      <div className='HintSol'>{text}
        <p className="HintSolText" style={show?{display:"inline-block"}:{display:'none'}}>{hint.sol}</p>
        <span id='HintIcon' className="material-symbols-rounded HintSolView" onClick={toggleSolution}>{icon}</span>
      </div>
    </Collapsible>
  );
}