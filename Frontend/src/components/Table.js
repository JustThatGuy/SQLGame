import '../css/Table.css'

import React, { Component } from 'react';
import data from '../data/data.json'

export class Table extends Component {
  render() {
    //const { data } = this.props;
    const columns = Object.keys(data[0]);
    return (
      <table>
        <thead>
          <TableHead columns={columns} />
        </thead>
        <tbody>
          <TableBody columns={columns} data={data} />
        </tbody>
      </table>
    );
  }
}

class TableHead extends Component {
  render() {
    const { columns } = this.props;
    return (
      <tr>
        {columns.map(header => {
          return <th>{header}</th>;
        })}
      </tr>
    );
  }
}

class TableBody extends Component {
  render() {
    const { columns, data } = this.props;
    return data.map(row => (
      <tr>
        {columns.map(cell => (
          <td>{row[cell]}</td>
        ))}
      </tr>
    ));
  }
}

export default Table;