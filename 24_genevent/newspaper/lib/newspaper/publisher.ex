defmodule Newspaper.Publisher do
  @moduledoc """
  Demonstrating a GenEvent functionality.
  This module is basically the event emitter.
  """
  alias Newspaper.Subscriber

  @doc false
  def start_link do
    GenEvent.start_link(name: __MODULE__)
  end

  @doc """
  Add a subscriber.
  """
  @spec add_subscriber(atom()) :: :ok
  def add_subscriber(module) do
    GenEvent.add_handler(__MODULE__, module, [])
  end

  @doc """
  Emit an event to the subscribers.

  ## Parameters

  - `news` - A news to be emitted.
  """
  @spec publish(binary()) :: :ok
  def publish(news) do
    GenEvent.notify(__MODULE__, {:publish, news})
  end

  @doc """
  Get subscriber inboxes.
  """
  @spec subscriber_inbox() :: [binary()]
  def subscriber_inbox do
    GenEvent.call(__MODULE__, Subscriber, :inbox)
  end
end
