ExUnit.start()

defmodule MathTest do
  use ExUnit.Case
  import Math

  doctest Math

  test "opposite works on +" do
    result = opposite 1 + 1
    assert result == 0
  end

  test "opposite works on -" do
    result = opposite 1 - 1
    assert result == 2
  end

  test "opposite works on *" do
    result = opposite 9 * 3
    assert result == 3
  end

  test "opposite works on /" do
    result = opposite 4 / 3
    assert result == 12
  end

  test "opposite works on recursively" do
    result = opposite 12 / 4 + 2
    assert result == 46
  end
end
