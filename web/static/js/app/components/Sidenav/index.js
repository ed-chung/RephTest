import React from "react";
import { Link, IndexLink } from 'react-router';


export default class Sidenav extends React.Component {
  render() {
    return <div className="col-sm-3 col-md-2 sidebar">
      <ul className="nav nav-sidebar">
        <li className="active"><Link to="/app">Dashboard</Link></li>
      </ul>
    </div>;
  }
};