defmodule Todo.Cache do
  @moduledoc """
  Temporary cache to save todo list
  in case the process crashes.
  """

  use GenServer
  import String, only: [to_atom: 1]
  alias Todo.Item

  # Public API
  
  @doc """
  Save a todo list.

  ## Parameters

  - `list` - A todo list struct.
  """
  @spec save(%{name: binary(), list: [Item.t]}) :: :true
  def save(list) do
    :ets.insert(__MODULE__, {to_atom(list.name), list})
  end

  @doc """
  Find a todo list based on its name.

  ## Parameters

  - `name` - The name of the todo list.
  """
  @spec find(binary()) :: %{name: binary(), list: [Item.t]}
  def find(name) do
    case :ets.lookup(__MODULE__, to_atom(name)) do
      [{_id, list}] -> list
      [] -> nil
    end
  end

  @doc """
  Wipe all the cache data.
  """

  @spec clear() :: :true
  def clear do
    :ets.delete_all_objects(__MODULE__)
  end

  # GenServer API

  @doc false
  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc false
  def init(_) do
    table = :ets.new(__MODULE__, [:named_table, :public])
    {:ok, table}
  end

end
