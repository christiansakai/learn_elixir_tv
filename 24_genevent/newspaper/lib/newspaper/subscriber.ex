defmodule Newspaper.Subscriber do
  @moduledoc """
  A module to demonstrate GenEvent functionality.
  This module is basically the event handler.
  """

  use GenEvent

  @doc false
  def init(_name) do
    {:ok, []}
  end

  @doc false
  def handle_event({:publish, news}, state) do
    IO.puts """
    #{__MODULE__} received news "#{news}"
    """
    {:ok, [news | state]}
  end

  @doc false
  def handle_event(_other, state) do
    {:ok, state}
  end

  @doc false
  def handle_call(:inbox, state) do
    {:ok, state, state}
  end
end
