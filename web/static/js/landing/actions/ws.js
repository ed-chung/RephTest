import { Socket } from 'phoenix';


const setupHandlers = (name, channel, dispatch) => {
  switch (name) {
    case "connections":
      channel.on("init", (msg) => {
        dispatch({
          type: "CONNECTIONS_INIT",
          total: msg.total,
          online: msg.online,
          max_online: msg.max_online
        });
      });
      channel.on("add", () => {
        dispatch({
          type: "CONNECTION_ADD"
        });
      });
      channel.on("remove", () => {
        dispatch({
          type: "CONNECTION_REMOVE"
        });
      });
      break;
    default:
      break;
  }
}

export default {
  socket_connect: () => {
    return (dispatch, getState) => {
      if (typeof window !== "undefined") {
        const { ws } = getState();
        let socket = ws.socket;
        if (socket !== null) {
          socket.disconnect();
        }
        const params = {token: localStorage.getItem('phoenixAuthToken')};
        const logger = (kind, msg, data) => {
          console.log(`${kind}: ${msg}`, data);
        };
        socket = new Socket('/socket', {params, logger});
        socket.connect();
        dispatch({
          type: 'SOCKET_CONNECTED',
          socket: socket
        });
      }
    }
  },
  channel_join: (name, alias = null) => {
    alias = alias === null ? name : alias;
    return (dispatch, getState) => {
      const { ws } = getState();
      if (ws.socket !== null) {
        const channel = ws.socket.channel(name);
        channel.join().receive('ok', () => {
          setupHandlers(alias, channel, dispatch);
          dispatch({
            type: 'CHANNEL_JOINED',
            name: alias,
            channel: channel
          });
        });
      }
    }
  }
};