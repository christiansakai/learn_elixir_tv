ExUnit.start

defmodule TodoListTest do
  use ExUnit.Case

  doctest TodoList

  test "todo list functions properly" do
    TodoList.start_link
    assert TodoList.get_list() == []

    TodoList.add("1")
    assert TodoList.get_list() == ["1"]

    TodoList.add("2")
    assert TodoList.get_list() == ["2", "1"]

    TodoList.add("3")
    assert TodoList.get_list() == ["3", "2", "1"]

    TodoList.remove("2")
    assert TodoList.get_list() == ["3", "1"]
  end
end
