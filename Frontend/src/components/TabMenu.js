import '../css/TabMenu.css';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';

// inventory request funtion
    const getInventory = async () => {
        const res = await fetch(`${backenduri}/inventory`, {
            method: 'GET'
        });

        if (res.ok) {
            const msg = await res.text();
            document.getElementById("ResultArea").innerText = msg;
        }
    }

export default () => (
  <Tabs className="Tabs">
    <TabList className="TabList">
      <Tab className="TabLink">Map</Tab>
      <Tab className="TabLink">Inventory</Tab>
      <Tab className="TabLink">Locations</Tab>
      <Tab className="TabLink">People</Tab>
    </TabList>

    <TabPanel className='TabPane'>
      <div className='TabContent'>
        <img src='../img/Aintree.png' className='Map'></img>
      </div>
    </TabPanel>
    <TabPanel className='TabPane'>
      <div className='TabContent'>
        <button className='StartGameButton' onClick={getInventory}>Get Inventory</button>
      </div>
    </TabPanel>
    <TabPanel className='TabPane'>
      <div className='TabContent'></div>
    </TabPanel>
    <TabPanel className='TabPane'>
      <div className='TabContent'></div>
    </TabPanel>
  </Tabs>
);