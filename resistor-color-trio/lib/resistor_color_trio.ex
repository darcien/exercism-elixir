defmodule ResistorColorTrio do
  @value_by_color %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    [first, second, third | _rest] = for c <- colors, do: @value_by_color[c]

    {main_value, ten_exponent} =
      case {first, second} do
        {_, 0} -> {first, third + 1}
        _ -> {Integer.undigits([first, second]), third}
      end

    unit =
      case div(ten_exponent, 3) do
        0 -> :ohms
        1 -> :kiloohms
        2 -> :megaohms
        3 -> :gigaohms
      end

    {main_value * 10 ** rem(ten_exponent, 3), unit}
  end
end
