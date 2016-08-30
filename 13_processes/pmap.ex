defmodule Pmap do
  @moduledoc """
  Module to demonstrate
  Elixir processes.
  """

  @doc """
  Parallel mapping.

  ## Parameters

  - `range` - A range of two integers
  - `func` - Optional function to operate on each integer

  ## Examples
      iex> Pmap.map(1..10)
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  """
  def map(range, func \\ fn x -> x end) do
    range
    |> Enum.map(&spawn_process(&1, func, self()))
    |> Enum.map(&await_response(&1))
  end

  defp spawn_process(number, func, parent) do
    spawn_link fn ->
      send parent, {:result, self(), func.(number)}
    end
  end

  defp await_response(child) do
    receive do
      {:result, ^child, result} -> result
    end
  end
end
