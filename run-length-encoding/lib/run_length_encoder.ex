defmodule RunLengthEncoder do
  @number_digits_as_string for n <- 1..9, do: to_string(n)

  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    # THESE ARE ALL DECODING CODE,
    # NOT ENCODING
    # YOU NEED TO REWRITE THIS
    do_encode(String.split(string, "", trim: true), [], "")
  end

  defp do_encode([], _head_digits, result) do
    result
  end

  defp do_encode([head | rest], head_digits, result) when head in @number_digits_as_string do
    do_encode(rest, head_digits ++ [String.to_integer(head)], result)
  end

  defp do_encode([head | rest], head_digits, result) do
    # encoded_characters

    case head_digits do
      [] -> do_encode(rest, [], result <> head)
      _ -> do_encode(rest, [], result <> head)
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
  end
end
