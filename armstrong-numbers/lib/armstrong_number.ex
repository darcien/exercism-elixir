defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    digit_count = length(digits)

    computed =
      digits
      |> Enum.map(fn d -> d ** digit_count end)
      |> Enum.sum()

    computed == number
  end
end
