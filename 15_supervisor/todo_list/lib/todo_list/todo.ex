defmodule TodoList.Todo do
  use GenServer

  # Client API

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def add(todo, item) do
    GenServer.cast(todo, {:add, item})
  end

  def remove(todo, item) do
    GenServer.call(todo, {:remove, item})
  end

  def list_all(todo) do
    GenServer.call(todo, :list_all)
  end

  # Server API

  @doc false
  def init(arg) do
    {:ok, arg}
  end

  def handle_cast({:add, item}, todo) do
    {:noreply, [item | todo]}
  end

  def handle_call({:remove, item}, _from, todo) do
    {:reply, item, todo -- [item]}
  end

  def handle_call(:list_all, _from, todo) do
    {:reply, todo, todo}
  end

end
