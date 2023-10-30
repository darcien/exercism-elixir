defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, input_base, _) when input_base < 2 do
    {:error, "input base must be >= 2"}
  end

  def convert(_, _, output_base) when output_base < 2 do
    {:error, "output base must be >= 2"}
  end

  def convert(digits, input_base, output_base) do
    if Enum.all?(digits, fn d -> d >= 0 and d < input_base end) do
      digit_count = length(digits)

      sum =
        digits
        |> Enum.with_index(1)
        |> Enum.reduce(0, fn {d, index}, acc ->
          acc + d * input_base ** (digit_count - index)
        end)

      {:ok, do_convert(sum, output_base, [])}
    else
      {:error, "all digits must be >= 0 and < input base"}
    end
  end

  defp do_convert(0, _output_base, output_digits) do
    case output_digits do
      [] -> [0]
      _ -> output_digits
    end
  end

  defp do_convert(number, output_base, output_digits) do
    {divided, remainder} = {div(number, output_base), rem(number, output_base)}
    do_convert(divided, output_base, [remainder | output_digits])
  end
end
