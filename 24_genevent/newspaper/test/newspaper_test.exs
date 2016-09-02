defmodule NewspaperTest do
  use ExUnit.Case

  alias Newspaper.Publisher
  alias Newspaper.Subscriber

  test ".publish will publish to all subscribers" do
    Publisher.add_subscriber(Subscriber)
    Publisher.publish("Trump becomes the President!")
    Publisher.publish("Hillary becomes the Vice President!")
    Publisher.publish("We are doomed!")

    assert Publisher.subscriber_inbox() == [
      "We are doomed!",
      "Hillary becomes the Vice President!",
      "Trump becomes the President!",
    ]
  end
end
