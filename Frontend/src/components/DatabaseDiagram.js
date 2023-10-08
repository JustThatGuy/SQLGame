import '../css/DatabaseDiagram.css';
import React from 'react';
import Draggable from 'react-draggable';

export default () => {
    return (
    <div className='DatabaseDiagram'>
        <button className='DrawerButton'>Database</button>
        <div className='DiagramArea'>
            <Draggable>
                <img src='../img/DatabaseDiagram.png' className='DBDimg'/>
            </Draggable>
        </div>
    </div>
    );
}