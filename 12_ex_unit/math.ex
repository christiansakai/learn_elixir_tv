defmodule MyApp.Math do
  @moduledoc """
  A module to demonstrate ExUnit
  and doctest
  """

  @doc """
  Adds two numbers together and returns the sum.

  ## Parameters

  - `a` - The first number to be added
  - `b` - The second number to be added

  ## Examples
  
      iex> MyApp.Math.add(2, 3)
      5
  """
  @spec add(number(), number()) :: number()
  def add(a, b), do: a + b
end
