import '../css/DatabaseDiagram.css';
import React from 'react';
import Draggable from 'react-draggable';

export default () => {
    function toggleDiagram() {
        const diagramArea = document.getElementById('DiagramDrawer');
        if (diagramArea.style.height != "0%") {
            diagramArea.style.height = "0%";
        } else {
            diagramArea.style.height = "40%";
        }
    }

    return (
    <div className='DatabaseDiagramDrawer' id="DiagramDrawer">
        <button className='DrawerButton' onClick={toggleDiagram}>Database</button>
        <div className='DiagramArea'>
            <Draggable>
                <div className='DBDImg'></div>
            </Draggable>
        </div>
    </div>
    );
}