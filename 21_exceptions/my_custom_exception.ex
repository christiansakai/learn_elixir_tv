defmodule MyCustomException do
  defexception code: nil, 
               message: nil

  def exception([code: code, message: message]) do
    %__MODULE__{code: code, message: message}
  end
end
