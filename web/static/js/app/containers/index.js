import React from "react";
import { Provider } from "react-redux";
import { Router, browserHistory, createMemoryHistory } from "react-router";
import { match, RouterContext } from 'react-router'

import configureStore from "../store";
import routes from "../routes";


export default class Index extends React.Component {
  render() {
    let initialState, history, router;
    if (typeof window === "undefined") {
      initialState = this.props.initial_state;
      history = createMemoryHistory();
      match({ routes, location: this.props.location, history }, (err, redirect, props) => {
        if (props) {
          router = <RouterContext { ...props } />;
        }
      });
    } else {
      initialState = window.__INITIAL_STATE__;
      history = browserHistory;
      router = <Router history={history}>
        {routes}
      </Router>;
    }
    const store = configureStore(initialState);
    
    return (
      <Provider store={store}>
        {router}
      </Provider>
    );
  }
}
