defmodule TodoList do
  @moduledoc """
  Module to demonstrate GenServer.
  """

  use GenServer

  # Client API
  
  @doc """
  Start the TodoList with empty list.
  """
  @spec start_link() :: {:ok, pid()}
  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__) 
  end

  @doc """
  Add a todo.

  ## Parameters
  
  - `todo` - A todo.
  """
  @spec add(String.t) :: :ok
  def add(todo) do
    GenServer.cast(__MODULE__, {:add, todo})
  end

  @doc """
  Remove a todo from a todo list.

  ## Parameters

  - `todo` - A todo to be removed.
  """
  @spec remove(String.t) :: String.t
  def remove(todo) do
    GenServer.call(__MODULE__, {:remove, todo})
  end

  @doc """
  Return the list of todos.
  """
  @spec get_list() :: list()
  def get_list do
    GenServer.call(__MODULE__, :list)
  end

    
  # Server API

  @doc false
  def init(args) do
    {:ok, args}
  end

  @doc false
  def handle_cast({:add, todo}, list) do
    {:noreply, [todo | list]}
  end

  @doc false
  def handle_call({:remove, todo}, _from, list) do
    {:reply, todo, list -- [todo]}
  end

  @doc false
  def handle_call(:list, _from, list) do
    {:reply, list, list}
  end
end
