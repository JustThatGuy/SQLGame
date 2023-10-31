import '../css/Table.css'
import data from '../data/data.json'

export default function BasicTable({jsonData}) {
  const columns = Object.keys(jsonData[0]);

  return (
    <table>
       <thead>
          <tr>
           {columns.map(heading => {
             return <th key={heading}>{heading}</th>
           })}
         </tr>
       </thead>
       <tbody>
           {jsonData.map((row) => {
               return <tr>
                   {columns.map(cell => {
                        return <td>{row[cell]}</td>
                   })}
             </tr>;
           })}
       </tbody>
    </table>
  );
}