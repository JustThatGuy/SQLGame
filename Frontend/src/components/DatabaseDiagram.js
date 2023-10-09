import '../css/DatabaseDiagram.css';
import React from 'react';
import Draggable from 'react-draggable';

export default () => {
    function toggleDiagram() {
        const diagramArea = document.getElementById('DiagramArea');
        if (diagramArea.style.height != "0%") {
            diagramArea.style.height = "0%";
        } else {
            diagramArea.style.height = "40%";
        }
    }

    return (
    <div className='DatabaseDiagram' id="DiagramArea">
        <button className='DrawerButton' onClick={toggleDiagram}>Database</button>
        <div className='DiagramArea'>
            <Draggable>
                <img src='../img/DatabaseDiagram.png' className='DBDimg'/>
            </Draggable>
        </div>
    </div>
    );
}