const initialState = {
  total: 0,
  online: 0,
  max_online: 0,
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
    case "CONNECTIONS_INIT":
      return {
        total: action.total,
        online: action.online,
        max_online: action.max_online,
      };
    case "CONNECTION_ADD":
      const new_online = state.online + 1;
      let max_online = state.max_online;

      if (new_online > max_online) {
        max_online = max_online + 1;
      }
      return {
        total: state.total + 1,
        online: new_online,
        max_online: max_online,
      };
    case "CONNECTION_REMOVE":
      return {
        ...state,
        online: state.online - 1
      }
    default:
      return state;
  }
}
