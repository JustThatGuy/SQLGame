import '../css/InventoryItem.css';

export default function InventoryItem({ item }) {
    return (
      <div className='Item' key={item.id}>
        <p className='ItemID ItemText'>{item.id}</p>
        <h3 className='ItemName ItemText'>{item.item}</h3>
        <p className='ItemOrigin ItemText'>{item.origin}</p>
      </div>
    );
}