import '../css/HintItem.css';
import '../css/InventoryItem.css'

import React from 'react';
import Collapsible from 'react-collapsible';

export default function HintItem({ hint }) {
  return (
    <Collapsible className="Hint" containerElementProps={hint.id} trigger={hint.title}>
      <div className='HintInner'>
        <p className='HintDesc'>{hint.desc}</p>
        <div className='HintSol'>
          <p className="HintSolText" toggleData="ToggledOff">{hint.sol}</p>
          <i className='HintSolHide'></i>
        </div>
      </div>
    </Collapsible>
  );
}