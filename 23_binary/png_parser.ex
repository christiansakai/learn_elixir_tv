defmodule PngParser do
  @moduledoc """
  Module to demonstrate binaries.
  Based on tutorial from
  http://www.zohaib.me/binary-pattern-matching-in-elixir/
  """

  

  defstruct width: 0, height: 0, bit_depth: 0, 
            color_type: nil, compression: nil, 
            filter: nil, interlace: nil, chunks: []

  @type t :: %__MODULE__{
    width: binary(),
    height: number(),
    bit_depth: number(),
    color_type: number(),
    compression: number(),
    filter: number(),
    interlace: number(),
    chunks: [chunk()]
  }

  @type chunk :: %{
    length: number(),
    chunk_type: number(),
    data: binary(),
    crc: number()
  }

  @doc """
  Parse a PNG file.
  """
  @spec png_parse(binary()) :: t()
  def png_parse(<<
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
    _length :: size(32),
    "IHDR",
    width :: size(32),
    height :: size(32),
    bit_depth,
    color_type,
    compression_method,
    filter_method,
    interlace_method,
    _crc :: size(32),
    chunks :: binary>>) do
    
    png = %__MODULE__{
      width: width,
      height: height,
      bit_depth: bit_depth,
      color_type: color_type,
      compression: compression_method,
      filter: filter_method,
      interlace: interlace_method,
      chunks: []
    }

    png_parse_chunks(chunks, png)
  end

  defp png_parse_chunks(<<
    length :: size(32),
    chunk_type :: size(32),
    chunk_data :: binary-size(length),
    crc :: size(32),
    chunks :: binary>>, png) do

    chunk = %{
      length: length,
      chunk_type: chunk_type,
      data: chunk_data,
      crc: crc
    }

    png = %{png | chunks: [chunk | png.chunks]}

    png_parse_chunks(chunks, png)
  end

  defp png_parse_chunks(<<>>, png) do
    %{png | chunks: Enum.reverse(png.chunks)}
  end
end

File.read!("elixir.png")
|> PngParser.png_parse()
|> IO.inspect()
