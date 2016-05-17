import { combineReducers } from "redux";
import { routerReducer } from "react-router-redux";

import ws from "./ws";
import connections from "./connections";


export default combineReducers({
  routing: routerReducer,
  ws,
  connections
});
