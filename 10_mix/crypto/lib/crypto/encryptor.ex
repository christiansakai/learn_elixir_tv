defmodule Crypto.Encryptor do
  @moduledoc """
  Module to encrypt a text.
  """
  @prefix Application.get_env(:crypto, __MODULE__)[:prefix]

  @doc """
  Encrypt a text.

  ## Parameters

  - `text` - The text to be encrypted.

  ## Examples

      iex> Crypto.Encryptor.encrypt("hello")
      "Encrypted_test: olleh"
  """
  @spec encrypt(String.t) :: String.t
  def encrypt(text) do
    @prefix <> String.reverse(text)
  end
end
