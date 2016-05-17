defmodule Reph.Connections do
  use GenServer

  @initial_state %{
    "total" => 0,
    "online" => 0,
    "max_online" => 0
  }

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def reset, do: GenServer.cast(__MODULE__, :reset)

  def add, do: GenServer.call(__MODULE__, :add)

  def remove, do: GenServer.call(__MODULE__, :remove)

  def state, do: GenServer.call(__MODULE__, :state)

  def init(_args) do
    {:ok, @initial_state}
  end

  def handle_call(:add, _, state) do
    new_online = state["online"] + 1
    max_online = case new_online > state["max_online"] do
      true -> new_online
      false -> state["max_online"]
    end
    new_state = %{state |
      "total" => state["total"] + 1,
      "online" => new_online,
      "max_online" => max_online
    }
    Reph.broadcast("connections", %{event: "add"})
    {:reply, {:ok, new_state}, new_state}
  end
  def handle_call(:remove, _, state) do
    new_state = %{state |
      "online" => state["online"] - 1
    }
    Reph.broadcast("connections", %{event: "remove"})
    {:reply, {:ok, new_state}, new_state}
  end
  def handle_call(:state, _, state) do
    {:reply, state, state}
  end

  def handle_cast(:reset, state) do
    {:noreply, @initial_state}
  end
end
