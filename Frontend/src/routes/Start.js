import '../css/Start.css';
import { Link } from 'react-router-dom';

function Start() {
    return (
        <div className="Background">
            <div className="Title">
                <div className="GameLogo"></div>
            </div>
            <div className="Menu">
                <Link to="levels/:level1" className="StartGameButton">Start Game</Link>
            </div>
        </div>
    );
};

export default Start;