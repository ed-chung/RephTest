import React from "react";

import Header from "components/Header";


export default class App extends React.Component {
  render() {
    return <div className="container">
      <Header />
      {this.props.children}
    </div>;
  }
};