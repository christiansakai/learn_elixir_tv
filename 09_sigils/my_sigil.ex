defmodule MySigil do
  @moduledoc """
  Module to demonstrate creating a sigil.
  """

  @doc """
  Pad a string with one empty space
  in front and back.

  ## Examples

      iex> ~p/Hello World/
      " Hello World "
  """
  def sigil_p(content, _opts) do
    pad_length = String.length(content)
    content
    |> String.pad_leading(pad_length + 1)
    |> String.pad_trailing(pad_length + 2)
  end
end

defmodule OtherModule do
  @moduledoc """
  A module to demonstrate
  using a created custom sigil.
  """

  import MySigil

  @doc """
  Test a created custom sigil.
  """
  def test_sigil do
    ~p/Hello World/
  end
end
