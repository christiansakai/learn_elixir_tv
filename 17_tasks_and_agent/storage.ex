defmodule Storage do
  @moduledoc """
  Module to demonstrate Task and Agent.
  """

  @doc false
  def start_link do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  @doc """
  Perform a parallel computation
  using Task. Update the results
  using Agent in this module.

  ## Parameters
  
  - `numbers` - list of numbers to be performed on
  """
  @spec parallel_calculation([number()]) :: :ok
  def parallel_calculation(numbers) do
    numbers
    |> Enum.map(fn number ->
      Task.async(fn ->
        Calculator.calculate(number)
      end)
    end)
    |> Enum.map(&Task.await(&1))
    |> Enum.each(fn result ->
      Agent.update(__MODULE__, &(&1 ++ [result]))
    end)
  end

  @doc """
  Get the results stored in this module.
  """
  @spec get_results() :: [number()]
  def get_results do
    Agent.get(__MODULE__, &(&1))
  end
end
