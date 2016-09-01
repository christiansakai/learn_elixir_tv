defmodule Todo.Item do
  @moduledoc """
  Module to represents one todo item.
  """
  defstruct id: nil,
            description: nil,
            completed: false


  @type t :: %__MODULE__{
    id: integer(),
    description: binary(),
    completed: boolean()
  }

  @doc """
  Create a new Todo.Item struct by
  assigning the struct with a random
  id generator.

  ## Parameters

  - `description` - The todo description.
  """
  @spec new(binary()) :: t
  def new(description) do
    %__MODULE__{
      id: :rand.uniform(1_000_000),
      description: description
    }
  end
end
