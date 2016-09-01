defmodule Todo.Server do
  @moduledoc """
  Server to supervise todo lists.
  With this you can add many todo lists.
  """

  use Supervisor
  alias Todo.List

  # Public API

  @doc """
  Add a new todo list.

  ## Parameters

  - `name` - The name of the todo list.
  """
  @spec add_list(binary()) :: {:ok, pid()}
  def add_list(name) do
    Supervisor.start_child(__MODULE__, [name])
  end

  @doc """
  Find a todo list.

  ## Parameters

  - `name` - The name of the todo list.
  """
  @spec find_list(binary()) :: pid()
  def find_list(name) do
    lists
    |> Enum.find(&List.name(&1) == name)
  end

  @doc """
  Delete a todo list.

  ## Parameters

  - `child` - The pid of the todo list.
  """
  @spec delete_list(pid()) :: :ok
  def delete_list(child) do
    Supervisor.terminate_child(__MODULE__, child)
  end

  @doc """
  Gets all the available todo lists.
  """
  @spec lists() :: [pid()]
  def lists do
    __MODULE__
    |> Supervisor.which_children()
    |> Enum.map(fn {_, child, _, _} -> child end)
  end
  
  # Supervisor API

  @doc false
  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc false
  def init(_) do
    children = [
      worker(List, [])
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

end
