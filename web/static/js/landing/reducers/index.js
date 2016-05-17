import { combineReducers } from "redux";
import { routerReducer } from "react-router-redux";

import ws from "./ws";
import connections from "./connections";
import auth from "./auth";


export default combineReducers({
  routing: routerReducer,
  ws,
  connections,
  auth
});
