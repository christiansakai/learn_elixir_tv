ExUnit.start()

defmodule MyCustomExceptionTest do
  use ExUnit.Case

  test "it throws the correct exception" do
    try do
      raise MyCustomException, code: 1, message: "Exception!"
    rescue
      exception ->
        assert exception == %MyCustomException{code: 1, 
                                               message: "Exception!"}
    end
  end
end
