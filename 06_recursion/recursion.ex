defmodule Recursion do
  @moduledoc """
  Example of using recursion
  to process list
  """

  @doc """
  Calculate the total of a 
  list of numbers

  ## Parameters
  
  - `list` - A list of numbers
  - `func` - Optional function which will be applied to each element on the list

  ## Examples
  
      iex> Recursion.sum([1, 2, 3])
      6
      iex> Recursion.sum([1, 2, 3], fn x -> x * x end)
      14
  """
  @spec sum([number()], (number() -> number())) :: number()
  def sum(list, func \\ fn x -> x end) do
    do_sum(list, func, 0)
  end

  defp do_sum([], _func, acc), do: acc
  defp do_sum([h | t], func, acc) do
    do_sum(t, func, func.(h) + acc)
  end

  @doc """
  Reverse a list

  ## Parameters
  
  - `list` - A list

  ## Examples
  
      iex> Recursion.reverse([1, 2, 3])
      [3, 2, 1]
  """
  @spec reverse(list()) :: list()
  def reverse(list) do
    do_reverse(list, [])
  end

  defp do_reverse([], acc), do: acc
  defp do_reverse([h | t], acc) do
    do_reverse(t, [h | acc])
  end
end
