import '../css/TabMenu.css';

import { useState } from 'react';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';

import { backenduri } from '..';
import InventoryItem from './InventoryItem';
import hints from "../data/hints.json"
import HintItem from './HintItem';

export default () => {
  // inventory request funtion
  const [inventory, setInventory] = useState ([]);

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

  function tabWidth() {
    var Tabs = document.getElementsByClassName('TabLink');
    var TabWidth = 100/Tabs.length;
    for (var i=0;i<Tabs.length;i++) {
      Tabs[i].style.width = TabWidth + "%"
    }
  }

  return (
    <Tabs className="Tabs" onLoad={tabWidth}>
      <TabList className="TabList">
        <Tab className="TabLink">Map</Tab>
        <Tab className="TabLink" onClick={getInventory}>Inventory</Tab>
        <Tab className="TabLink">Hints</Tab>
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
        </div>
      </TabPanel>
      <TabPanel className='TabPane'>
        <div className='TabContent'>
          <ul className="Hints" id='Hints'>
            {hints.map((hints) => (
              <HintItem key={hints.id} hint={hints} />
            ))}
          </ul>
        </div>
      </TabPanel>
    </Tabs>
  );
}