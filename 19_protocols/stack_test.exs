ExUnit.start()

defmodule StackTest do
  use ExUnit.Case

  doctest Stack

  setup do
    {:ok, stack: Stack.new()}
  end

  test ".push will push something to the stack", %{stack: stack} do
    stack = Stack.push(stack, 0)

    assert stack.length == 1
  end

  test ".pop will pop the latest pushed element from the stack", %{stack: stack} do
    stack = Stack.push(stack, 0)
    stack = Stack.push(stack, 1)
    stack = Stack.pop(stack)

    assert stack.length == 1
  end

  test "Enum.count works for Stack", %{stack: stack} do
    stack = Stack.push(stack, 0)

    assert Enum.count(stack) == 1
  end

  test "Enum.reduce works for Stack", %{stack: stack} do
    stack = Stack.push(stack, 3)
    stack = Stack.push(stack, 6)
    stack = Stack.push(stack, 9)

    assert Enum.reduce(stack, fn x, acc -> x + acc end) == 18
  end

  test "Enum.member? works for Stack", %{stack: stack} do
    stack = Stack.push(stack, 5)

    refute Enum.member?(stack, 2)
    assert Enum.member?(stack, 5)
  end

  test "IO.inspect works for Stack", %{stack: stack} do
    stack = Stack.push(stack, 3)
    stack = Stack.push(stack, 6)
    stack = Stack.push(stack, 9)

    IO.inspect stack
  end
end
