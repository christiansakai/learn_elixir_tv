defmodule Todo.List do
  @moduledoc """
  A todo list using GenServer.
  """

  use GenServer
  alias Todo.Item
  alias Todo.Cache

  # Public API
  
  @doc """
  Gets the name of a todo list.

  ## Parameters

  - `list` - A todo list pid.
  """
  @spec name(pid()) :: binary()
  def name(list) do
    GenServer.call(list, :name)
  end

  @doc """
  Add an item to a todo list.

  ## Parameters

  - `list` - A todo list pid.
  - `item` - A Todo.Item struct.
  """
  @spec add(pid(), Item.t) :: :ok
  def add(list, item) do
    GenServer.cast(list, {:add, item})
  end

  @doc """
  Update an item in a todo list.

  ## Parameters

  - `list` - A todo list pid.
  - `item` - A Todo.Item struct.
  """
  @spec update(pid(), Item.t) :: :ok
  def update(list, item) do
    GenServer.cast(list, {:update, item})
  end

  @doc """
  Remove an item from a todo list.

  ## Parameters

  - `list` - A todo list pid.
  - `item` - A Todo.Item struct.
  """
  @spec remove(pid(), Item.t) :: Item.t
  def remove(list, item) do
    GenServer.call(list, {:remove, item})
  end

  @doc """
  Get the full todo list.

  ## Parameters

  - `list` - A todo list pid.
  """
  @spec items(pid()) :: [Item.t]
  def items(list) do
    GenServer.call(list, :items)
  end

  @doc """
  Empties the todo list.

  ## Parameters

  - `list` - A todo list pid.
  """
  @spec empty(pid()) :: :ok
  def empty(list) do
    GenServer.cast(list, :empty)
  end


  # GenServer API

  @doc """
  Start a new todo list.

  ## Parameters

  - `name` - A todo list name.
  """
  @spec start_link(binary()) :: {:ok, pid()}
  def start_link(name) do
    GenServer.start_link(__MODULE__, name)
  end

  @doc false
  def init(name) do
    todo_list = Cache.find(name) || %{name: name, items: []}
    {:ok, todo_list}
  end

  @doc false
  def handle_cast({:add, item}, state) do
    new_state = %{state | items: [item | state.items]}
    Cache.save(new_state)
    {:noreply, new_state}
  end

  @doc false
  def handle_cast({:update, item}, state) do
    index = Enum.find_index(state.items, &(&1.id == item.id))

    new_items = List.replace_at(state.items, index, item)
    new_state = %{state | items: new_items}
    Cache.save(new_state)
    {:noreply, new_state}
  end

  @doc false
  def handle_cast(:empty, state) do
    new_state = %{state | items: []}
    Cache.save(new_state)
    {:noreply, new_state}
  end

  @doc false
  def handle_call(:name, _from, state) do
    {:reply, state.name, state}
  end

  @doc false
  def handle_call({:remove, item}, _from, state) do
    new_items = state.items -- [item]
    new_state = %{state | items: new_items}
    Cache.save(new_state)
    {:reply, item, new_state}
  end

  @doc false
  def handle_call(:items, _from, state) do
    {:reply, state.items, state}
  end
end
