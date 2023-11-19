import '../css/HintItem.css';
import '../css/InventoryItem.css'

import React from 'react';
import Collapsible from 'react-collapsible';

export default function HintItem({ hint }) {

  const [show, setShow] = React.useState(false);

  return (
    <Collapsible containerElementProps={hint.id} trigger={hint.title} transitionTime={100} easing='ease' contentHiddenWhenClosed='true'>
      <p className='HintDesc'>{hint.desc}</p>
      <button onClick={()=>setShow(!show)}>Show solution</button>
      <div style={show?{display:"inline-block"}:{display:'none'}}className='HintSol'>
        <p className="HintSolText" toggleData="ToggledOff">{hint.sol}</p>
        <i className='HintSolHide'></i>
      </div>
    </Collapsible>
  );
}