defmodule For do
  @moduledoc """
  A module to demonstrate
  for macro.
  """

  @doc """
  Get even integers between two integers.
  `from` must be strictly smaller than `to`.

  ## Parameters
  
  - `from` - An integer to start from.
  - `to` - An integer to end to.

  ## Examples

      For.even_numbers_between(1, 10)
      [2, 4, 6, 8, 10]
  """
  @spec even_numbers_between(integer(), integer()) :: [integer()]
  def even_numbers_between(from, to) when from < to do
    numbers = for num <- from..to, into: [], do: num

    numbers |> Enum.filter(&(rem(&1, 2) == 0))
  end
  def even_numbers_between(from, to), do: []

  @doc """
  Join a list of binaries together
  with a separator. There is a trailing
  separator left as side effect.

  ## Parameters
  
  - `list` - A list of binaries.
  - `separator` - An optional separator.

  ## Examples
  
      For.join_list(["I", "love", "You"], " ")
      "I love You "
  """
  @spec join_list([binary()], binary()) :: binary()
  def join_list(list, separator \\ "") do
    joined = for binary <- list, into: "" do
      binary <> separator
    end
  end
end
