ExUnit.start

defmodule MyApp.MathTest do
  use ExUnit.Case

  doctest MyApp.Math

  test "add adds two numbers together" do
    assert MyApp.Math.add(2, 3) == 5
  end
end
