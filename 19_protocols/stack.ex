defmodule Stack do
  @moduledoc """
  Stack data structure.
  """

  defstruct length: 0, items: []

  @type t :: %__MODULE__ {
    length: non_neg_integer(),
    items: [number()]
  }

  @doc """
  Create a new stack.

  ## Examples

      iex> Stack.new
      %Stack{length: 0, items: []}
  """
  @spec new() :: t()
  def new do
    %__MODULE__{}
  end

  @doc """
  Push a number to the stack.

  ## Parameters

  - `stack` - A Stack struct.
  - `item` - A number.

  ## Examples

      iex> stack = Stack.new()
      iex> stack = Stack.push(stack, 1)
      %Stack{length: 1, items: [1]}
  """
  @spec push(t(), number()) :: t()
  def push(stack, item) when is_number(item) do
    %{stack | items: [item | stack.items],
      length: stack.length + 1}
  end

  @doc """
  Pop the last element out from the stack.

  ## Parameters

  - `stack` - A Stack struct.

  ## Examples

      iex> stack = Stack.new()
      iex> stack = Stack.push(stack, 1)
      iex> stack = Stack.pop(stack)
      %Stack{length: 0, items: []}
  """
  @spec pop(t()) :: number()
  def pop(stack) do
    [_h | t] = stack.items
    %{stack | items: t, length: stack.length - 1}
  end
end

defimpl Enumerable, for: Stack do
  def count(enumerable) do
    {:ok, enumerable.length}
  end

  def reduce(_, {:halt, acc}, _fun) do 
    {:halted, acc}
  end

  def reduce(enumerable, {:suspend, acc}, fun) do 
    {:suspended, acc, &reduce(enumerable, &1, fun)}
  end

  def reduce(%Stack{length: 0, items: []}, {:cont, acc}, _fun) do
    {:done, acc}
  end

  def reduce(stack = %Stack{length: _, items: [h | t]}, {:cont, acc}, fun) do
    reduce(%{stack | length: stack.length - 1, items: t}, fun.(h, acc), fun)
  end

  def member?(_enumerable, _item) do
    {:error, __MODULE__}
  end
end

defimpl Inspect, for: Stack do
  def inspect(inspectable, _) do
    """
    #Stack -> length #{inspectable.length}
    #{Enum.join(inspectable, " ==> ")}
    """
  end
end
