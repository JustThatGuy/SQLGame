import '../css/DatabaseDiagram.css';
import Draggable from 'react-draggable';

export default () => {
    return (
    <div className='DatabaseDiagram'>
        <button className='DrawerButton'>Database</button>
        <div className='DiagramArea'>
            <Draggable>
                <img src='DatabaseDiagram.png' className='DBDimg' />
            </Draggable>
        </div>
    </div>
    );
}