defmodule Sort do
  @callback sort(list()) :: list()
end

defmodule QuickSort do
  @moduledoc """
  Demonstration of a behaviour implementation.
  """

  @behaviour Sort

  @doc """
  Sort a list.

  ## Parameters

  - `list` - A list of numbers

  ## Examples

      iex> QuickSort.sort [5, 3, 6, 7, 2]
      [2, 3, 5, 6, 7]
  """
  @spec sort([number()]) :: [number()]
  def sort([]), do: []
  def sort([head | tail]) do
    {smaller, bigger} = Enum.partition(tail, &(&1 < head))
    sort(smaller) ++ [head] ++ sort(bigger)
  end
end
