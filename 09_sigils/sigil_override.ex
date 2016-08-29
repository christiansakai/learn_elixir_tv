defmodule SigilOverride do
  @moduledoc """
  A module to demonstrate
  overriding a Kernel sigil.
  """
  import Kernel, except: [sigil_r: 2]

  @doc """
  Upcase a string.

  ## Examples
    
      iex> ~r/hello world/
      "HELLO WORLD"
  """
  def sigil_r(content, _opts) do
    String.upcase(content)
  end

  def test_sigil do
    ~r/hello world/
  end
end
