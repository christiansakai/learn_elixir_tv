defmodule EnumStream do
  @moduledoc """
  A module to demonstrate
  an Enum and Stream module.
  """

  @months ["January",
           "February",
           "March",
           "April",
           "May",
           "June",
           "July",
           "August",
           "September",
           "October",
           "November",
           "December"]

  @file "sample.txt"

  @doc """
  Writes twelve months in a year each line.
  """
  @spec months :: :ok
  def months do
    @months 
    |> Stream.each(&IO.puts/1)
    |> Stream.run()
  end

  @doc """
  Read "sample.txt" and writes every other
  word which startds with "d", sorted by
  length and capitalized.
  """
  @spec read_sample :: :ok
  def read_sample do
    open_file = fn -> File.open!("sample.txt") end
    read_file = fn file ->
      case IO.read(file, :line) do
        data when is_binary(data) and data != "\n" -> 
          {[String.trim(data)], file}
        data when data == "\n" ->
          {[], file}
        _ -> {:halt, file}
      end
    end
    close_file = fn file -> File.close(file) end

    Stream.resource(open_file, read_file, close_file)
    |> Stream.filter(&String.starts_with?(&1, "d"))
    |> Stream.map(&String.capitalize/1)
    |> Enum.sort(&(String.length(&1) <= String.length(&2)))
    |> Enum.each(&IO.puts/1)
  end
end
