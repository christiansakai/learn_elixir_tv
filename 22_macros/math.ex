defmodule Math do
  @moduledoc """
  Module contains macro to reverse Math operation.

  ## Examples
  
      iex> Math.opposite 1 + 1
      0
      iex> Math.opposite 12 / 4
      48
  """
  defmacro opposite({operator, _, [a, b]}) do
    build_opposite(operator, a, b)
  end

  defp build_opposite(outer_operator, {inner_operator, _, [inner_a, inner_b]}, outer_b) do
    outer_a = elem(Code.eval_quoted(build_opposite(inner_operator, inner_a, inner_b)), 0)
    build_opposite(outer_operator, outer_a, outer_b)
  end

  defp build_opposite(:+, a, b) do
    quote do
      unquote(a) - unquote(b)
    end
  end

  defp build_opposite(:-, a, b) do
    quote do
      unquote(a) + unquote(b)
    end
  end

  defp build_opposite(:*, a, b) do
    quote do
      unquote(a) / unquote(b)
    end
  end

  defp build_opposite(:/, a, b) do
    quote do
      unquote(a) * unquote(b)
    end
  end
end
