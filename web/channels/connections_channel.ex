defmodule Reph.ConnectionsChannel do
  use Reph.Web, :channel

  def join("connections", _params, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    push(socket, "init", Reph.Connections.state())
    {:ok, _} = Reph.Connections.add()
    {:noreply, socket}
  end
  def handle_info(%{event: event}, socket) when event in ["add", "remove"] do
    push(socket, event, %{})
    {:noreply, socket}
  end

  def terminate(_, _) do
    {:ok, _} = Reph.Connections.remove()
    :ok
  end
end