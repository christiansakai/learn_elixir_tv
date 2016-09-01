defmodule Todo.ListTest do
  use ExUnit.Case

  alias Todo.List
  alias Todo.Item
  alias Todo.Cache

  setup do
    Cache.clear()
    {:ok, list} = List.start_link("Test")
    {:ok, list: list}
  end

  test ".name returns the name of the list", %{list: list} do
    assert List.name(list) == "Test"
  end

  test ".items returns the todos on the list", %{list: list} do
    assert List.items(list) == []
  end

  test ".add adds an item to on the list", %{list: list} do
    item = Item.new("buy milk")
    List.add(list, item)

    assert List.items(list) == [item]
  end

  test ".update updates an item on the list", %{list: list} do
    item = Item.new("buy milk")
    List.add(list, item)

    item = %{item | description: "buy egg", completed: true}
    List.update(list, item)

    assert List.items(list) == [item]
  end

  test ".remove removes an item on the list", %{list: list} do
    item = Item.new("buy milk")
    List.add(list, item)
    List.remove(list, item)
    
    assert List.items(list) == []
  end

  test ".empty empties the list", %{list: list} do
    item = Item.new("buy milk")
    List.add(list, item)
    List.empty(list)
    
    assert List.items(list) == []
  end
end
