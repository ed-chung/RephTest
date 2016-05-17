import React from "react";
import ReactDOM from "react-dom";

import Index from "containers";


const index = React.createFactory(Index); 
ReactDOM.render(index(window.__INITIAL_STATE__), document.getElementById("index"));