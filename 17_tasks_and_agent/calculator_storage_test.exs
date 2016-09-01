ExUnit.start()

defmodule CalculatorStorageTest do
  use ExUnit.Case

  doctest Calculator

  test "parallel computation using Task and Agent works" do
    numbers = [1, 2, 3, 4, 5]
    Storage.start_link()
    Storage.parallel_calculation(numbers)

    assert Storage.get_results() == [2, 4, 6, 8, 10]
  end
end
