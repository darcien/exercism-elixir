defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code
    |> Integer.digits(2)
    |> Enum.take(-5)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce([], fn {digit, index}, actions ->
      if digit == 0 do
        actions
      else
        case index do
          0 -> actions ++ ["wink"]
          1 -> actions ++ ["double blink"]
          2 -> actions ++ ["close your eyes"]
          3 -> actions ++ ["jump"]
          4 -> Enum.reverse(actions)
          _ -> actions
        end
      end
    end)
  end
end
