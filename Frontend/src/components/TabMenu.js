import '../css/TabMenu.css';
import { useState } from 'react';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';

import InventoryItem from './InventoryItem';

import { backenduri } from '..';

export default () => {
  const [inventory, setInventory] = useState ([]);

  // inventory request funtion
  const getInventory = async () => {
    const res = await fetch(`${backenduri}/inventory`, {
      method: 'GET'
    });

    // response parsing
    if (res.ok) {
      const msg = await res.json();
      console.log(msg);
      setInventory(msg);
    }
  }

  return (
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
          <ul className="Inventory" id='Inventory'>
            {inventory.map((item) => (
              <InventoryItem key={item.id} item={item} />
            ))}
          </ul>
          <button className='GetInventoryButton' onClick={getInventory}>Get Inventory</button>
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
}