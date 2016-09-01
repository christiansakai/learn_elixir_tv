defmodule Calculator do
  @shortdoc """
  Calculate something.
  """

  @doc """
  Perform heavy computation.

  ## Parameters

  - `number` - number to be perfomed on.

  ## Examples

      iex> Calculator.calculate(2)
      4
  """
  @spec calculate(number()) :: number()
  def calculate(number) do
    # Simulate a heavy computation
    # by sleeping
    Process.sleep(2000)
    number * 2
  end
end
