import React from "react";
import { Link, IndexLink } from 'react-router';


export default class Header extends React.Component {
  render() {
    return <header className="header">
      <nav role="navigation">
        <ul className="nav nav-pills pull-right">
          <li><Link className="btn" to="/auth/login">Login</Link></li>
          <li><Link className="btn" to="/auth/register">Register</Link></li>
        </ul>
      </nav>
      <IndexLink to="/"><span className="logo"></span></IndexLink>
    </header>;
  }
};